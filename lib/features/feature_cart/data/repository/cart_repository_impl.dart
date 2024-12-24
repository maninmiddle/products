import 'package:fpdart/src/either.dart';
import 'package:products_application/core/error/failures.dart';
import 'package:products_application/core/model/product.dart';
import 'package:products_application/features/feature_cart/data/data_sources/cart_local_data_source.dart';
import 'package:products_application/features/feature_cart/domain/repository/cart_repository.dart';

/// The implementation of the `CartRepository` interface, responsible for
/// interacting with the local data source to perform operations on the cart,
/// such as adding, removing, and retrieving products. This class ensures that
/// the business logic of interacting with the local database is encapsulated
/// and provides the expected result (either success or failure) to the caller.
///
/// The `CartRepositoryImpl` class communicates with `CartLocalDataSource` to
/// perform the actual database operations and returns the result wrapped in an
/// `Either<Failure, T>`, which is a functional programming construct that
/// represents either a success (`Right`) or a failure (`Left`).
///
/// This class provides the following operations:
/// - `addProductToCart`: Adds a product to the cart.
/// - `getProductsInCart`: Retrieves all products currently in the cart.
/// - `removeProductFromCart`: Removes a product from the cart.
class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource cartLocalDataSource;

  CartRepositoryImpl(this.cartLocalDataSource);

  @override
  Future<Either<Failure, Product>> addProductToCart(
      {required Product product}) async {
    try {
      await cartLocalDataSource.addProductToCart(product: product);
      return Right(product);
    } catch (e) {
      return Left(Failure('Failed to add product to cart'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsInCart() async {
    try {
      final products = await cartLocalDataSource.loadProductsInCart();
      return Right(products);
    } catch (e) {
      return Left(Failure('Failed to add product to cart'));
    }
  }

  @override
  Future<Either<Failure, Product>> removeProductFromCart(
      {required Product product}) async {
    try {
      await cartLocalDataSource.removeProductFromCart(product: product);
      return Right(product);
    } catch (e) {
      return Left(Failure('Failed to remove product'));
    }
  }
}
