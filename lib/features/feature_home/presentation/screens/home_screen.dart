import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:products_application/core/model/product.dart';
import 'package:products_application/core/services/cart_service.dart';
import 'package:products_application/core/utils/show_snack.dart';
import 'package:products_application/features/feature_home/presentation/bloc/home_bloc.dart';
import 'package:products_application/features/feature_home/presentation/bloc/home_event.dart';
import 'package:products_application/features/feature_home/presentation/bloc/home_state.dart';
import 'package:products_application/features/feature_home/presentation/widgets/custom_product_card.dart';
import 'package:products_application/navigation/models/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false; // Flag to check if search is active
  final TextEditingController _searchController =
      TextEditingController(); // Controller to manage search input
  List<Product> _filteredProducts =
      []; // List of filtered products based on search query
  @override
  void initState() {
    super.initState();
    context
        .read<HomeBloc>()
        .add(FetchProductsEvent()); // Dispatches an event to fetch products
  }

  @override
  Widget build(BuildContext context) {
    final cartService = context.read<
        CartService>(); // Cart service for adding/removing products from the cart

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  _filterProducts(value);
                },
              )
            : Center(
                child: Text(
                  "Products",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  _filterProducts("");
                }
              });
            },
          ),
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeFailure) {
            showSnackBar(
                context, state.error); // Show error message in case of failure
          }
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return Center(
              child:
                  CircularProgressIndicator(), // Show loading indicator while fetching data
            );
          }
          if (state is HomeDisplaySuccess) {
            // Если есть фильтрация, показываем отфильтрованные товары
            final productsToDisplay =
                _filteredProducts.isEmpty ? state.products : _filteredProducts;

            return GridView.builder(
              itemCount: productsToDisplay.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1 / 1.5,
              ),
              itemBuilder: (context, index) {
                final product = productsToDisplay[index];
                return CustomProductCard(
                  product: product,
                  onTapListener: () {
                    context.push(Routes.detailsPage,
                        extra: product); // Navigate to product details page
                  },
                  onPressedButton: () {
                    log("message");
                    cartService
                        .addProductToCart(product); // Add product to the cart
                    cartService.loadProductsInCart(); // Refresh cart contents
                  },
                  onRemoveProductFromCart:
                      () {}, // Placeholder for future remove action
                );
              },
            );
          }
          return const SizedBox(); // Placeholder when no state is matched
        },
      ),
    );
  }

  void _filterProducts(String query) {
    final products = context.read<HomeBloc>().state is HomeDisplaySuccess
        ? (context.read<HomeBloc>().state as HomeDisplaySuccess).products
        : [];

    if (products is List<Product>) {
      setState(() {
        _filteredProducts = products
            .where((product) =>
                product.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }
}
