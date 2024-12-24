import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:products_application/core/services/cart_service.dart';
import 'package:products_application/features/feature_home/presentation/widgets/custom_rounded_bottom_nav.dart';
import 'package:products_application/navigation/bloc/navigation_bloc.dart';
import 'package:products_application/navigation/bloc/navigation_event.dart';
import 'package:products_application/navigation/bloc/navigation_state.dart';

class LayoutScaffold extends StatefulWidget {
  const LayoutScaffold({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('LayoutScaffold'));

  final StatefulNavigationShell navigationShell;

  @override
  State<LayoutScaffold> createState() => _LayoutScaffoldState();
}

class _LayoutScaffoldState extends State<LayoutScaffold> {
  @override
  void initState() {
    super.initState();
    _updateCartCount();
  }

  void _updateCartCount() async {
    final cartService = context.read<CartService>();
    final productCount = await cartService.getProductCount();
    if (mounted) {
      context.read<NavigationBloc>().add(CartCountChangedEvent(productCount));
    }
  }

  @override
  Widget build(BuildContext context) {
    final RouteMatch lastMatch =
        GoRouter.of(context).routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : GoRouter.of(context).routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    final shouldShowBottomNav = location != '/details';

    return Scaffold(
      extendBody: true,
      body: widget.navigationShell,
      bottomNavigationBar: shouldShowBottomNav
          ? BlocConsumer<NavigationBloc, NavigationState>(
              listener: (context, state) {},
              builder: (context, state) {
                final itemCount = state.cartItemCount;
                return CustomBottomNavigationBar(
                  currentIndexValue: widget.navigationShell.currentIndex,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(
                      icon: Badge(
                        label: Text(itemCount.toString()),
                        child: Icon(Icons.shopping_basket_outlined),
                      ),
                      label: 'Cart',
                    ),
                  ],
                  onTap: widget.navigationShell.goBranch,
                );
              },
            )
          : null,
    );
  }
}
