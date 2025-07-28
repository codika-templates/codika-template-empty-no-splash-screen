import 'package:flutter/material.dart';

enum AppSpacing {
  none,    // 0
  xs,      // 4
  sm,      // 8
  md,      // 16
  lg,      // 24
  xl,      // 32
  xxl,     // 48
  xxxl;    // 64

  double get value {
    switch (this) {
      case AppSpacing.none:
        return 0;
      case AppSpacing.xs:
        return 4;
      case AppSpacing.sm:
        return 8;
      case AppSpacing.md:
        return 16;
      case AppSpacing.lg:
        return 24;
      case AppSpacing.xl:
        return 32;
      case AppSpacing.xxl:
        return 48;
      case AppSpacing.xxxl:
        return 64;
    }
  }

  EdgeInsets get padding => EdgeInsets.all(value);

  EdgeInsets get paddingHorizontal => EdgeInsets.symmetric(horizontal: value);

  EdgeInsets get paddingVertical => EdgeInsets.symmetric(vertical: value);

  EdgeInsets get paddingTop => EdgeInsets.only(top: value);

  EdgeInsets get paddingBottom => EdgeInsets.only(bottom: value);

  EdgeInsets get paddingLeft => EdgeInsets.only(left: value);

  EdgeInsets get paddingRight => EdgeInsets.only(right: value);

  SizedBox get gap => SizedBox(width: value, height: value);

  SizedBox get gapH => SizedBox(width: value);

  SizedBox get gapV => SizedBox(height: value);

  EdgeInsets combine({
    AppSpacing? top,
    AppSpacing? right,
    AppSpacing? bottom,
    AppSpacing? left,
  }) {
    return EdgeInsets.only(
      top: top?.value ?? 0,
      right: right?.value ?? 0,
      bottom: bottom?.value ?? 0,
      left: left?.value ?? 0,
    );
  }

  EdgeInsets symmetric({
    AppSpacing? horizontal,
    AppSpacing? vertical,
  }) {
    return EdgeInsets.symmetric(
      horizontal: horizontal?.value ?? 0,
      vertical: vertical?.value ?? 0,
    );
  }
}

class AppSpacingValues {
  static const double screenPadding = 20.0; // AppSpacing.lg
  static const double sectionPadding = 16.0; // AppSpacing.md
  static const double cardPadding = 16.0; // AppSpacing.md
  static const double buttonPadding = 16.0; // AppSpacing.md
  static const double inputPadding = 12.0; // Between sm and md
}