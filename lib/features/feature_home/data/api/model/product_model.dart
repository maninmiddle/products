import 'package:products_application/core/model/product.dart';

/// A data model representing a product, inheriting from the [Product] class.
///
/// This class is designed to handle product data, including serialization and
/// deserialization to/from JSON.
class ProductModel extends Product {
  /// Constructor for creating an instance of [ProductModel].
  ///
  /// All parameters are passed to the constructor of the [Product] superclass.
  const ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.price,
    required super.rating,
    required super.thumbnail,
  });

  /// A factory constructor for creating a [ProductModel] instance from JSON.
  ///
  /// Accepts [json], a [Map<String, dynamic>] object representing data in JSON format.
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        category: json['category'],
        price: json['price'].toDouble(),
        rating: json['rating'].toDouble(),
        thumbnail: json['thumbnail']);
  }

  /// Converts the [ProductModel] instance to JSON.
  ///
  /// Returns a [Map<String, dynamic>] containing all the fields of the model
  /// in JSON format.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'rating': rating,
      'thumbnail': thumbnail
    };
  }
}
