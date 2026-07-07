import 'package:flutter/material.dart';

import 'responsive_context.dart';

class AdaptiveContainer extends StatelessWidget {
  const AdaptiveContainer({
    required this.child,
    this.maxWidth = 1440,
    this.padding,
    super.key,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding:
              padding ??
              EdgeInsets.symmetric(horizontal: context.isMobile ? 16 : 32),
          child: child,
        ),
      ),
    );
  }
}
