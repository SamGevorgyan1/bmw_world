import 'package:flutter/material.dart';

SnackBar errorSnackBarWidget(BuildContext context, String message) {
  return SnackBar(
    backgroundColor: Theme.of(context).colorScheme.error,
    content: Text(
      message,
      style:Theme.of(context).textTheme.titleLarge,
    ),
  );
}
