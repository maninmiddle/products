import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_application/core/services/cart_service.dart';
import 'package:products_application/navigation/bloc/navigation_event.dart';
import 'package:products_application/navigation/bloc/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final CartService cartService;
  late final StreamSubscription<int> cartSubscription;

  NavigationBloc(this.cartService) : super(NavigationState(cartItemCount: 0)) {
    cartSubscription = cartService.cartCountStream.listen((cartCount) {
      log("Received cart count in NavigationBloc: $cartCount");
      add(CartCountChangedEvent(cartCount));
    });
    on<CartCountChangedEvent>((event, emit) {
      emit(NavigationState(cartItemCount: event.count));
    });
  }

  @override
  Future<void> close() {
    cartSubscription.cancel();
    return super.close();
  }
}
