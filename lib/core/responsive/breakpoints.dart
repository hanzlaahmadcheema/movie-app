class AppBreakpoints {
  const AppBreakpoints._();

  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
  static const double largeDesktop = 1600;
}

enum ResponsiveLayout { mobile, tablet, desktop, largeDesktop }

ResponsiveLayout responsiveLayoutFor(double width) {
  if (width >= AppBreakpoints.largeDesktop) {
    return ResponsiveLayout.largeDesktop;
  }
  if (width >= AppBreakpoints.desktop) {
    return ResponsiveLayout.desktop;
  }
  if (width >= AppBreakpoints.mobile) {
    return ResponsiveLayout.tablet;
  }
  return ResponsiveLayout.mobile;
}
