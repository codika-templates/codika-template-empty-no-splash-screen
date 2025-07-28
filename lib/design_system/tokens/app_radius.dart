import 'package:flutter/material.dart';

enum AppRadius {
  none,    // 0
  xs,      // 2
  sm,      // 4
  md,      // 6
  lg,      // 8
  xl,      // 12
  xxl,     // 16
  xxxl,    // 24
  pill;    // 999 (fully rounded)

  double get value {
    switch (this) {
      case AppRadius.none:
        return 0;
      case AppRadius.xs:
        return 2;
      case AppRadius.sm:
        return 4;
      case AppRadius.md:
        return 6;
      case AppRadius.lg:
        return 8;
      case AppRadius.xl:
        return 12;
      case AppRadius.xxl:
        return 16;
      case AppRadius.xxxl:
        return 24;
      case AppRadius.pill:
        return 999;
    }
  }

  BorderRadius get borderRadius => BorderRadius.circular(value);

  BorderRadius get topOnly => BorderRadius.vertical(
        top: Radius.circular(value),
      );

  BorderRadius get bottomOnly => BorderRadius.vertical(
        bottom: Radius.circular(value),
      );

  BorderRadius get leftOnly => BorderRadius.horizontal(
        left: Radius.circular(value),
      );

  BorderRadius get rightOnly => BorderRadius.horizontal(
        right: Radius.circular(value),
      );

  BorderRadius get topLeft => BorderRadius.only(
        topLeft: Radius.circular(value),
      );

  BorderRadius get topRight => BorderRadius.only(
        topRight: Radius.circular(value),
      );

  BorderRadius get bottomLeft => BorderRadius.only(
        bottomLeft: Radius.circular(value),
      );

  BorderRadius get bottomRight => BorderRadius.only(
        bottomRight: Radius.circular(value),
      );

  BorderRadius combine({
    AppRadius? topLeft,
    AppRadius? topRight,
    AppRadius? bottomLeft,
    AppRadius? bottomRight,
  }) {
    return BorderRadius.only(
      topLeft: Radius.circular(topLeft?.value ?? 0),
      topRight: Radius.circular(topRight?.value ?? 0),
      bottomLeft: Radius.circular(bottomLeft?.value ?? 0),
      bottomRight: Radius.circular(bottomRight?.value ?? 0),
    );
  }

  RoundedRectangleBorder get shapeBorder => RoundedRectangleBorder(
        borderRadius: borderRadius,
      );

  OutlinedBorder get buttonShape => RoundedRectangleBorder(
        borderRadius: borderRadius,
      );
}

class AppRadiusValues {
  static const double button = 8.0; // AppRadius.lg
  static const double card = 12.0; // AppRadius.xl
  static const double dialog = 16.0; // AppRadius.xxl
  static const double input = 6.0; // AppRadius.md
  static const double sheet = 24.0; // AppRadius.xxxl (top corners only)
}