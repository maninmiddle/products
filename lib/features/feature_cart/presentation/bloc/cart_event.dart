import 'package:products_application/core/model/product.dart';

/// Abstract base class representing all the events related to the cart.
///
/// `CartEvent` serves as the base class for all the events that can trigger
/// a change in the state of the cart. These events are processed by the `CartBloc`.
///
abstract class CartEvent {}

/// Event triggered when a product is added to the cart.
class AddProductToCartEvent extends CartEvent {
  final Product product;
  AddProductToCartEvent(this.product);
}

/// Event triggered when a product is removed from the cart.
class RemoveProductFromCartEvent extends CartEvent {
  final Product product;
  RemoveProductFromCartEvent(this.product);
}

/// Event triggered to load all products currently in the cart.
class LoadProductsInCartEvent extends CartEvent {}
