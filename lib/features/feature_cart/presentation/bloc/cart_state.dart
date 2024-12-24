import 'package:products_application/core/model/product.dart';

/// Abstract base class representing all possible states related to the cart.
///  `CartState` serves as the base class for all the states that can be emitted
/// by the `CartBloc`. These states represent different stages of the cart's
/// lifecycle, such as loading, loaded, error, and success states.

abstract class CartState {}

/// Initial state of the cart.
class CartInitial extends CartState {}

/// State indicating that the cart is being loaded.
class CartLoading extends CartState {}

/// State when the cart is successfully loaded with products.
class CartLoaded extends CartState {
  final List<Product> products;
  CartLoaded(this.products);
}

/// State indicating an error occurred while loading or modifying the cart.
class CartError extends CartState {
  final String message;
  CartError(this.message);
}

/// State when a product is successfully added to the cart.
class ProductAddedToCartSuccess extends CartState {
  final Product product;
  ProductAddedToCartSuccess(this.product);
}

/// State when a product is successfully removed from the cart.
class ProductRemovedFromCartSuccess extends CartState {
  final Product product;
  ProductRemovedFromCartSuccess(this.product);
}
