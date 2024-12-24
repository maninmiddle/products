import 'package:fpdart/src/either.dart';
import 'package:products_application/core/error/failures.dart';
import 'package:products_application/core/model/product.dart';
import 'package:products_application/core/usecase/usecase.dart';
import 'package:products_application/features/feature_cart/domain/repository/cart_repository.dart';

/// A use case for retrieving the list of products currently in the cart.
///
/// This class implements the `UseCase` interface, and its responsibility is
/// to fetch all products that are currently in the cart by interacting with
/// the `CartRepository`. It encapsulates the business logic for loading the
/// products in the cart and delegates the actual data retrieval to the
/// `CartRepository`. The result is returned as an `Either<Failure, List<Product>>`,
/// where `Right` contains the list of products in the cart, and `Left` contains a
/// `Failure` object in case of an error.
class GetProductsInCart implements UseCase<List<Product>, NoParams> {
  final CartRepository cartRepository;
  GetProductsInCart(this.cartRepository);

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await cartRepository.getProductsInCart();
  }
}
