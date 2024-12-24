import 'package:fpdart/src/either.dart';
import 'package:products_application/core/error/failures.dart';
import 'package:products_application/core/model/product.dart';
import 'package:products_application/core/usecase/usecase.dart';
import 'package:products_application/features/feature_cart/domain/repository/cart_repository.dart';

/// A use case for adding a product to the cart.
///
/// This class implements the `UseCase` interface, and its responsibility is
/// to add a product to the cart by interacting with the `CartRepository`.
/// It encapsulates the business logic for adding a product to the cart and
/// delegates the actual data manipulation to the `CartRepository`. The result
/// is returned as an `Either<Failure, Product>`, where `Right` contains the
/// successfully added product, and `Left` contains a `Failure` object in case
/// of an error.
///
/// The `AddProductToCart` use case is invoked by passing an instance of
/// `AddProductToCartParams`, which contains the product to be added to the cart.
///
class AddProductToCart implements UseCase<Product, AddProductToCartParams> {
  final CartRepository cartRepository;
  AddProductToCart(this.cartRepository);

  @override
  Future<Either<Failure, Product>> call(AddProductToCartParams params) async {
    return await cartRepository.addProductToCart(product: params.product);
  }
}

class AddProductToCartParams {
  final Product product;

  AddProductToCartParams({
    required this.product,
  });
}
