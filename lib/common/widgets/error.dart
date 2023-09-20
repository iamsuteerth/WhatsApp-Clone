import 'package:flutter/material.dart';

// Common Error Widget
class ErrorWidgetCustom extends StatelessWidget {
  final String? error;
  const ErrorWidgetCustom({
    super.key,
    this.error,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        error == null ? 'ERROR' : error!,
      ),
    );
  }
}
