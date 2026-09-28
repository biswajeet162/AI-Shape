import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

/// Centers content and caps width for web / large screens.
class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({
    super.key,
    required this.child,
    this.maxWidth = 1200,
    this.padding,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
          child: child,
        ),
      ),
    );
  }
}
