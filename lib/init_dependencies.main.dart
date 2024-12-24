part of 'init_dependencies.dart';

// Service locator instance for dependency management
final serviceLocator = GetIt.instance;

// HTTP client instance for making network requests
final client = http.Client();

// Initializes dependencies and registers them with the service locator (GetIt)
Future<void> initDependencies() async {
  // Initialize and register all dependencies related to the Home feature
  _initHome();
  // Initialize and register all dependencies related to the Cart feature
  _initCart();
  // Initialize and register the NavigationBloc for navigation state management
  _initNavigation();
  // Register the HTTP client as a lazy singleton
  serviceLocator.registerLazySingleton(() => client);
}

void _initHome() {
  serviceLocator
    // Registers the HomeRemoteDataSource for network-related operations
    ..registerFactory<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    // Registers the HomeRepository for data management
    ..registerFactory<HomeRepository>(
      () => HomeRepositoryImpl(
        serviceLocator(),
      ),
    )
    // Registers the GetAllProducts use case for fetching products
    ..registerFactory(
      () => GetAllProducts(
        serviceLocator(),
      ),
    )
    // Registers the HomeBloc for managing home-related state
    ..registerLazySingleton(
      () => HomeBloc(
        getAllProducts: serviceLocator(),
      ),
    );
}

// Initializes dependencies for the Cart feature
void _initCart() {
  serviceLocator
    // Registers CartLocalDataSource for local storage operations
    ..registerFactory<CartLocalDataSource>(
      () => CartLocalDataSourceImpl(),
    )
    ..registerFactory<CartRepository>(
        () => CartRepositoryImpl(serviceLocator()))
    // Registers use cases for adding and removing products from the cart
    ..registerFactory(() => AddProductToCart(serviceLocator()))
    ..registerFactory(() => RemoveProductFromCart(serviceLocator()))
    ..registerFactory(() => GetProductsInCart(serviceLocator()))
    ..registerLazySingleton(() => CartBloc(
        addProductToCart: serviceLocator(),
        getProductsInCart: serviceLocator(),
        removeProductFromCart: serviceLocator()))
    // Registers CartService for business logic and service-related operations
    ..registerLazySingleton(
        () => CartService(serviceLocator(), serviceLocator()));
}

// Initializes dependencies for the Navigation feature
void _initNavigation() {
  serviceLocator.registerLazySingleton(() => NavigationBloc(serviceLocator()));
}
