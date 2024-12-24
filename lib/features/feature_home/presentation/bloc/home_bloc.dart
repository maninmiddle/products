import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_application/core/error/failures.dart';
import 'package:products_application/core/usecase/usecase.dart';
import 'package:products_application/features/feature_home/domain/usecases/get_all_products.dart';
import 'package:products_application/features/feature_home/presentation/bloc/home_event.dart';
import 'package:products_application/features/feature_home/presentation/bloc/home_state.dart';

/// The BLoC (Business Logic Component) for managing the home screen state.
///
/// This class handles events related to fetching product data and maintains
/// the state of the home screen using a reactive approach with the BLoC pattern
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  /// Use case for fetching all products.
  final GetAllProducts _getAllProducts;

  /// Constructor for [HomeBloc].
  ///
  /// - [getAllProducts]: The use case to fetch all products.
  HomeBloc({
    required GetAllProducts getAllProducts,
  })  : _getAllProducts = getAllProducts,
        super(HomeInitial()) {
    // Event handler for [FetchProductsEvent].
    on<FetchProductsEvent>((event, emit) async {
      emit(HomeLoading());

      // Execute the use case and handle the result.
      final result = await _getAllProducts(NoParams());

      // Handle success and failure scenarios.
      result.fold(
        (failure) => emit(HomeFailure(_mapFailureToMessage(failure))),
        (products) => emit(HomeDisplaySuccess(products)),
      );
    });
  }

  /// Maps a [Failure] object to a user-friendly error message.
  /// - [failure]: The failure object to be mapped.
  /// - Returns: A string message describing the failure.
  String _mapFailureToMessage(Failure failure) {
    return 'Failed to load';
  }
}
