import 'package:flutter/material.dart';
import '../../../core/extensions/build_context_extensions.dart';

import '../../../core/themes/app_theme_factory.dart';

class InputLabel extends StatelessWidget {
  final String label;
  final bool hasError;
  const InputLabel({
    super.key,
    required this.label,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      overflow: TextOverflow.ellipsis,
      style: context.textTheme.bodyMedium?.copyWith(
        fontWeight: context.textTheme.fontWeightLight,
      ),
    );
  }
}
