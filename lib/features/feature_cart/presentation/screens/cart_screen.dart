import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_application/core/model/product.dart';
import 'package:products_application/core/services/cart_service.dart';
import 'package:products_application/core/theme/app_pallete.dart';
import 'package:products_application/core/utils/show_snack.dart';
import 'package:products_application/features/feature_cart/presentation/bloc/cart_bloc.dart';
import 'package:products_application/features/feature_cart/presentation/bloc/cart_event.dart';
import 'package:products_application/features/feature_cart/presentation/bloc/cart_state.dart';
import 'package:products_application/features/feature_cart/presentation/widgets/custom_cart_card.dart';

/// A screen that displays the products in the user's cart.
///
/// `CartScreen` is a `StatefulWidget` that manages the state of the cart.
/// It listens for cart-related events, such as loading products, and displays
/// a list of products in the cart. It also handles error and loading states.
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<Product> _products;
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(LoadProductsInCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Cart",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: AppPallete.whiteColor,
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          // This listener listens for specific state changes and takes action when needed.
          if (state is CartError) {
            showSnackBar(context, state.message); // Show a Snackbar on error
          }
        },
        builder: (context, state) {
          // This builder rebuilds the UI based on the current state.
          if (state is CartLoading) {
            // Show a loading spinner when loading the cart
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CartLoaded) {
            // Display the cart items when they're successfully loaded
            _products = state.products;
            return ListView.builder(
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  return CustomCartCard(
                    product: product,
                    onRemoveProductFromCart: () {
                      _removeProduct(product, index);
                    },
                  );
                });
          }
          return Center(child: Text("No products in cart"));
        },
      ),
    );
  }

  // This function remove the product from the list of products in the UI
  void _removeProduct(Product product, int index) async {
    setState(() {
      _products.removeAt(index);
    });

    final cartService = context.read<CartService>();
    await cartService.removeProductFromCart(product);
  }
}
