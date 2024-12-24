import 'package:flutter/material.dart';
import 'package:products_application/core/model/product.dart';

/// Base class for all possible states of the home screen.
///
/// Each state represents a distinct stage in the data fetching or display
/// process.
@immutable
sealed class HomeState {}

/// Initial state of the home screen.
///
/// This state indicates that no action has been performed yet, and the screen
/// is awaiting user interaction or an event trigger.
final class HomeInitial extends HomeState {}

/// Loading state of the home screen.
final class HomeLoading extends HomeState {}

/// Failure state of the home screen.
final class HomeFailure extends HomeState {
  final String error;
  HomeFailure(this.error);
}

/// Success state for displaying products.
final class HomeDisplaySuccess extends HomeState {
  final List<Product> products;
  HomeDisplaySuccess(this.products);
}
