import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_application/core/error/failures.dart';
import 'package:products_application/core/usecase/usecase.dart';
import 'package:products_application/features/feature_cart/domain/usecases/add_product_to_cart.dart';
import 'package:products_application/features/feature_cart/domain/usecases/get_products_in_cart.dart';
import 'package:products_application/features/feature_cart/domain/usecases/remove_product_from_cart.dart';
import 'package:products_application/features/feature_cart/presentation/bloc/cart_event.dart';
import 'package:products_application/features/feature_cart/presentation/bloc/cart_state.dart';

/// The BLoC (Business Logic Component) responsible for managing the cart state.
///
/// This `CartBloc` handles events related to the cart, such as loading products,
/// adding products, and removing products from the cart. It interacts with the
/// use cases `AddProductToCart`, `GetProductsInCart`, and `RemoveProductFromCart`
/// to perform actions related to the cart. The state is updated based on the
/// results of these actions and is emitted using different states such as
/// `CartLoading`, `CartLoaded`, `ProductAddedToCartSuccess`, and `CartError`.

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddProductToCart _addProductToCart;
  final GetProductsInCart _getProductsInCart;
  final RemoveProductFromCart _removeProductFromCart;

  CartBloc({
    required AddProductToCart addProductToCart,
    required GetProductsInCart getProductsInCart,
    required RemoveProductFromCart removeProductFromCart,
  })  : _addProductToCart = addProductToCart,
        _getProductsInCart = getProductsInCart,
        _removeProductFromCart = removeProductFromCart,
        super(CartInitial()) {
    // Event handler for loading products in the cart
    on<LoadProductsInCartEvent>((event, emit) async {
      emit(CartLoading()); // Emit loading state

      // Get the products from the cart
      final result = await _getProductsInCart(NoParams());
      result.fold(
        // If the operation failed, emit an error state
        (failure) => emit(CartError(_mapFailureToMessage(failure))),
        // If the operation succeeded, emit loaded state with products
        (products) => emit(CartLoaded(products)),
      );
    });

    // Event handler for adding a product to the cart
    on<AddProductToCartEvent>((event, emit) async {
      emit(CartLoading());

      final result = await _addProductToCart(
          AddProductToCartParams(product: event.product));

      result.fold(
        (failure) => emit(CartError(_mapFailureToMessage(failure))),
        (product) => emit(ProductAddedToCartSuccess(product)),
      );
    });
    // Event handler for removing a product from the cart
    on<RemoveProductFromCartEvent>((event, emit) async {
      emit(CartLoading());

      final result = await _removeProductFromCart(
        RemoveProductFromCartParams(product: event.product),
      );

      if (emit.isDone) return;

      // Call the use case to remove the product from the cart
      await result.fold(
        // If removing the product fails, emit an error state

        (failure) async {
          emit(CartError(_mapFailureToMessage(failure)));
        },
        // If removing the product is successful, update the cart with the new list

        (product) async {
          final updatedList = await _getProductsInCart(NoParams());

          // If the operation is complete, return early
          if (emit.isDone) return;

          updatedList.fold(
            // If fetching updated list fails, emit an error state
            (failure) => emit(CartError(_mapFailureToMessage(failure))),
            // If fetching updated list is successful, emit the new list of products
            (products) => emit(CartLoaded(products)),
          );
        },
      );
    });
  }
}

String _mapFailureToMessage(Failure failure) {
  return 'Failed to load';
}
