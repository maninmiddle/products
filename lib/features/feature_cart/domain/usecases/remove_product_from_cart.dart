import 'package:fpdart/src/either.dart';
import 'package:products_application/core/error/failures.dart';
import 'package:products_application/core/model/product.dart';
import 'package:products_application/core/usecase/usecase.dart';
import 'package:products_application/features/feature_cart/domain/repository/cart_repository.dart';

/// A use case for removing a product from the cart.
///
/// This class implements the `UseCase` interface, and its responsibility is
/// to remove a product from the cart by interacting with the `CartRepository`.
/// It encapsulates the business logic for removing a product from the cart
/// and delegates the actual removal to the `CartRepository`. The result is
/// returned as an `Either<Failure, Product>`, where `Right` contains the
/// product that was removed, and `Left` contains a `Failure` object in case
/// of an error.
class RemoveProductFromCart
    implements UseCase<Product, RemoveProductFromCartParams> {
  final CartRepository cartRepository;
  RemoveProductFromCart(this.cartRepository);

  @override
  Future<Either<Failure, Product>> call(
      RemoveProductFromCartParams params) async {
    return await cartRepository.removeProductFromCart(product: params.product);
  }
}

class RemoveProductFromCartParams {
  final Product product;
  RemoveProductFromCartParams({
    required this.product,
  });
}
