import 'package:products_application/core/model/product.dart';

/// A utility class for converting between `Product` objects and their corresponding
/// representation in a database (i.e., converting `Product` objects to maps for storage
/// and converting database maps back to `Product` objects).
///
/// This class provides two methods:
/// - `fromMap`: Converts a map (typically retrieved from the database) into a `Product` object.
/// - `toMap`: Converts a `Product` object into a map suitable for storing in the database.
///
/// The `Product` class represents a product entity in the cart, and the map typically
/// represents a row in the 'cart' table of the SQLite database.
class CartMapper {
  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      id: int.tryParse(map['id'].toString()) ?? 0,
      title: map['title'],
      description: map['description'],
      category: map['category'],
      price: map['price'],
      rating: map['rating'],
      thumbnail: map['thumbnail'],
    );
  }

  static Map<String, dynamic> toMap(Product product) {
    return {
      'id': product.id,
      'title': product.title,
      'description': product.description,
      'category': product.category,
      'rating': product.rating,
      'thumbnail': product.thumbnail,
      'price': product.price,
    };
  }
}
