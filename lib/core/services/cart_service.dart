import 'dart:async';
import 'dart:developer';

import 'package:products_application/core/model/product.dart';
import 'package:products_application/features/feature_cart/domain/repository/cart_repository.dart';
import 'package:products_application/features/feature_cart/presentation/bloc/cart_bloc.dart';
import 'package:products_application/features/feature_cart/presentation/bloc/cart_event.dart';

/// [CartService] is responsible for managing the cart's operations such as adding,
/// removing products, and notifying the app of changes to the cart count.
/// It interacts with the [CartRepository] for data storage and retrieval and
/// the [CartBloc] for managing the cart's state.
class CartService {
  final CartRepository cartRepository;
  final CartBloc cartBloc;

  /// [_cartCountController] is a [StreamController] that manages and broadcasts
  /// the count of products in the cart to listeners.
  final _cartCountController = StreamController<int>.broadcast();

  /// Exposes a stream of the current cart count to allow other parts of the app
  /// to listen for updates.
  Stream<int> get cartCountStream => _cartCountController.stream;

  /// Creates an instance of [CartService] that interacts with the [CartRepository]
  /// and [CartBloc] to perform cart operations.
  ///
  /// [cartRepository] is used for data operations.
  /// [cartBloc] is used for dispatching events and managing state.
  CartService(this.cartRepository, this.cartBloc);

  /// Adds a [product] to the cart.
  Future<void> addProductToCart(Product product) async {
    await cartRepository.addProductToCart(product: product);
    cartBloc.add(AddProductToCartEvent(product));
    _notifyCartCount();
  }

  /// Loads the products currently in the cart.
  Future<void> loadProductsInCart() async {
    await cartRepository.getProductsInCart();
    cartBloc.add(LoadProductsInCartEvent());
  }

  /// Removes a [product] from the cart.
  Future<void> removeProductFromCart(Product product) async {
    await cartRepository.removeProductFromCart(product: product);
    cartBloc.add(RemoveProductFromCartEvent(product));
    log("Product removed!");
    _notifyCartCount();
  }

  /// Retrieves the current number of products in the cart.
  Future<int> getProductCount() async {
    final result = await cartRepository.getProductsInCart();
    return result.fold(
      (failure) => 0,
      (products) => products.length,
    );
  }

  /// Notifies the listeners of the current cart count by adding it to the
  /// [_cartCountController] stream.
  Future<void> _notifyCartCount() async {
    final count = await getProductCount();
    log("Updated product count: $count");
    _cartCountController.add(count);
  }

  /// Disposes the [StreamController] when it's no longer needed.
  void dispose() {
    _cartCountController.close();
  }
}
