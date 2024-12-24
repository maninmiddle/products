import 'package:flutter/material.dart';
import 'package:products_application/core/theme/app_pallete.dart';

/// [AppTheme] is a class that defines the app's theme configuration.
/// It provides a theme for the app using [ThemeData] and can be applied
/// globally across the application.
class AppTheme {
  /// [lightThemeMode] is a predefined light theme configuration for the app.
  /// It defines the primary color of the app and other visual properties like
  /// background color and density of UI components.
  ///
  /// - [primarySwatch] sets the primary color of the app to blue.
  /// - [visualDensity] adapts the density of the app's visual elements based on the platform.
  /// - [scaffoldBackgroundColor] sets the background color of the scaffold to a custom color
  /// defined in [AppPallete.backgroundColor].
  static final lightThemeMode = ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: AppPallete.backgroundColor);
}
