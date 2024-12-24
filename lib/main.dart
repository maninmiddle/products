import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_application/core/services/cart_service.dart';
import 'package:products_application/core/theme/theme.dart';
import 'package:products_application/features/feature_cart/presentation/bloc/cart_bloc.dart';
import 'package:products_application/features/feature_home/presentation/bloc/home_bloc.dart';
import 'package:products_application/init_dependencies.dart';
import 'package:products_application/navigation/bloc/navigation_bloc.dart';
import 'package:products_application/navigation/router.dart';
import 'package:provider/provider.dart';

void main() async {
  // Ensures that the Flutter engine is initialized before starting the app
  WidgetsFlutterBinding.ensureInitialized();
  // Initializes the dependencies (services and blocs)
  await initDependencies();
  // Runs the application
  runApp(
    MultiBlocProvider(
      providers: [
        // Provides the HomeBloc instance throughout the app
        BlocProvider(
          create: (_) => serviceLocator<HomeBloc>(),
        ),
        // Provides the CartBloc instance throughout the app
        BlocProvider(
          create: (_) => serviceLocator<CartBloc>(),
        ),
        // Provides the NavigationBloc instance throughout the app
        BlocProvider(
          create: (_) => serviceLocator<NavigationBloc>(),
        ),
        // Provides the CartService instance throughout the app
        Provider<CartService>(
          create: (_) => serviceLocator<CartService>(),
        )
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Configures the app with the router and theme
    return MaterialApp.router(
      routerConfig: router, // Sets the routing configuration for the app
      theme: AppTheme.lightThemeMode, // Sets the app's light theme
      debugShowCheckedModeBanner:
          false, // Disables the debug banner in development mode
    );
  }
}
