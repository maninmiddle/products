import 'package:go_router/go_router.dart';
import 'package:products_application/core/model/product.dart';
import 'package:products_application/features/feature_cart/presentation/screens/cart_screen.dart';
import 'package:products_application/features/feature_details/presentation/details_screen.dart';
import 'package:products_application/features/feature_home/presentation/screens/home_screen.dart';
import 'package:products_application/navigation/layout/layout_scaffold.dart';
import 'package:products_application/navigation/models/routes.dart';

final router = GoRouter(
  initialLocation: Routes.homePage,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => LayoutScaffold(
        navigationShell: navigationShell,
      ),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
              path: Routes.homePage,
              builder: (context, state) => const HomeScreen())
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: Routes.cartPage, builder: (context, state) => CartScreen())
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: Routes.detailsPage,
            builder: (context, state) => DetailsScreen(
              product: state.extra as Product,
            ),
          )
        ])
      ],
    ),
  ],
);
