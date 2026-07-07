import 'package:flutter/material.dart';

import '../responsive/responsive_context.dart';

class AppTextStyles {
  const AppTextStyles._();

  static const String fontFamily = 'Pathway Extreme';

  static const title = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1,
  );

  static const medium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1,
  );

  static const normal = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.25,
  );

  static const small = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    height: 1.2,
  );

  static const button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1,
  );

  static const tag = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w600,
    height: 1,
  );

  static TextStyle sectionTitle(BuildContext context) {
    return title.copyWith(
      fontSize: context.isMobile ? 21 : (context.isTablet ? 26 : 30),
      height: 1.15,
    );
  }
}
