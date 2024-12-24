import 'package:flutter/material.dart';

/// Displays a [SnackBar] with the provided [content] in the given [context].
/// If a [SnackBar] is already visible, it hides the current one before showing
/// the new one.
void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
}
