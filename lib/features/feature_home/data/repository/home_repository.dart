import 'package:fpdart/src/either.dart';
import 'package:products_application/core/error/failures.dart';
import 'package:products_application/core/model/product.dart';
import 'package:products_application/features/feature_home/data/api/request/home_remote_data_source.dart';
import 'package:products_application/features/feature_home/data/mapper/home_mapper.dart';
import 'package:products_application/features/feature_home/domain/repository/home_repository.dart';

/// Implementation of the [HomeRepository] interface.
///
/// This class provides the logic for fetching product data from a remote data source
/// and transforming it into domain layer entities.
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  /// Constructor for [HomeRepositoryImpl].
  ///
  /// - [remoteDataSource]: An instance of [HomeRemoteDataSource] to fetch data from the API.
  HomeRepositoryImpl(this.remoteDataSource);

  /// Fetches a list of products from the remote data source.
  ///
  /// The method performs the following steps:
  /// 1. Calls [HomeRemoteDataSource.getProductsFromApi] to fetch raw product data as a list of [ProductModel].
  /// 2. Maps the [ProductModel] data to domain entities ([Product]) using [HomeMapper.fromModel].
  /// 3. Returns a [Right] containing the list of [Product] if successful.
  /// 4. Returns a [Left] with a [Failure] if an error occurs during the process.
  ///
  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final productModel = await remoteDataSource.getProductsFromApi();
      final products = productModel.map(HomeMapper.fromModel).toList();
      return Right(products);
    } catch (e) {
      return Left(Failure('Server failure!'));
    }
  }
}
