import 'package:fpdart/fpdart.dart';
import 'package:products_application/core/error/failures.dart';
import 'package:products_application/core/model/product.dart';

/// An abstract interface defining the contract for a cart repository.
///
/// The `CartRepository` class is responsible for handling the business logic
/// related to the cart. It provides methods to interact with the data source
/// (local or remote), which allows adding, removing, and retrieving products
/// in the cart.
abstract interface class CartRepository {
  Future<Either<Failure, List<Product>>> getProductsInCart();
  Future<Either<Failure, Product>> addProductToCart({
    required Product product,
  });
  Future<Either<Failure, Product>> removeProductFromCart({
    required Product product,
  });
}
