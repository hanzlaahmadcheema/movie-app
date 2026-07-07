import 'package:flutter/material.dart';

import 'breakpoints.dart';

extension ResponsiveContext on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;

  bool get isMobile => screenWidth < AppBreakpoints.mobile;
  bool get isTablet =>
      screenWidth >= AppBreakpoints.mobile &&
      screenWidth < AppBreakpoints.desktop;
  bool get isDesktop => screenWidth >= AppBreakpoints.desktop;
  bool get isLargeDesktop => screenWidth >= AppBreakpoints.largeDesktop;

  ResponsiveLayout get responsiveLayout => responsiveLayoutFor(screenWidth);
}
