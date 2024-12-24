import 'package:products_application/core/model/product.dart';
import 'package:products_application/features/feature_home/data/api/model/product_model.dart';

/// A utility class for mapping data between [ProductModel] and [Product].
///
/// The purpose of this class is to convert data objects from the data layer
/// ([ProductModel]) into domain layer objects ([Product]).
class HomeMapper {
  /// Converts a [ProductModel] instance into a [Product] instance.
  ///
  /// This method takes a [ProductModel], which typically represents a product
  /// object fetched from an external data source (e.g., an API or database),
  /// and transforms it into a [Product], which is used in the domain layer.
  static Product fromModel(ProductModel model) {
    return Product(
      id: model.id,
      title: model.title,
      description: model.description,
      category: model.category,
      price: model.price,
      rating: model.rating,
      thumbnail: model.thumbnail,
    );
  }
}
