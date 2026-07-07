import 'package:flutter/material.dart';

import 'breakpoints.dart';

typedef ResponsiveWidgetBuilder =
    Widget Function(BuildContext context, BoxConstraints constraints);

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    required this.mobile,
    this.tablet,
    this.desktop,
    this.largeDesktop,
    super.key,
  });

  final ResponsiveWidgetBuilder mobile;
  final ResponsiveWidgetBuilder? tablet;
  final ResponsiveWidgetBuilder? desktop;
  final ResponsiveWidgetBuilder? largeDesktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return switch (responsiveLayoutFor(constraints.maxWidth)) {
          ResponsiveLayout.mobile => mobile(context, constraints),
          ResponsiveLayout.tablet => (tablet ?? mobile)(context, constraints),
          ResponsiveLayout.desktop => (desktop ?? tablet ?? mobile)(
            context,
            constraints,
          ),
          ResponsiveLayout.largeDesktop =>
            (largeDesktop ?? desktop ?? tablet ?? mobile)(context, constraints),
        };
      },
    );
  }
}
