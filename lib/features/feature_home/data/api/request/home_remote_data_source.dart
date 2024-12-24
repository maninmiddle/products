import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:products_application/core/secrets/app_secrets.dart';
import 'package:products_application/features/feature_home/data/api/model/product_model.dart';

/// Abstract interface for remote data source responsible for fetching products.
abstract interface class HomeRemoteDataSource {
  /// Returns a [Future] that resolves to a list of [ProductModel] instances.
  Future<List<ProductModel>> getProductsFromApi();
}

/// Implementation of [HomeRemoteDataSource] using the `http` package.
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final http.Client client;

  HomeRemoteDataSourceImpl(this.client);

  /// Fetches products from the API and parses the response into a list of [ProductModel].
  ///
  /// The API endpoint is defined in [AppSecrets.baseUrl]. The method logs the process,
  /// including the request URI, response status, and response body for debugging purposes.
  ///
  /// - On a successful response with status code `200`, it expects a JSON structure with
  ///   a `products` field that contains a list of product data. Each item in the list is
  ///   parsed into a [ProductModel].
  ///
  /// - If the response status is not `200` or the data format is invalid, an exception
  ///   is thrown.
  ///
  @override
  Future<List<ProductModel>> getProductsFromApi() async {
    try {
      final uri = Uri.parse(AppSecrets.baseUrl);
      log('Fetching products from $uri');
      final response = await client.get(uri);

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is Map<String, dynamic> && data['products'] is List) {
          final productsList = data['products'] as List;
          return productsList
              .map((json) => ProductModel.fromJson(json))
              .toList();
        } else {
          throw Exception("Invalid data format");
        }
      } else {
        throw HttpException(
            'Failed to load products: ${response.reasonPhrase}');
      }
    } catch (e, stackTrace) {
      log('Error fetching products: $e', stackTrace: stackTrace);
      rethrow;
    }
  }
}
