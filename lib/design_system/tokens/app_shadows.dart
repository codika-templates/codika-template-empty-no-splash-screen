import 'package:flutter/material.dart';

enum AppShadows {
  none,
  xs,
  sm,
  md,
  lg,
  xl,
  xxl,
  inner;

  List<BoxShadow> get shadows {
    switch (this) {
      case AppShadows.none:
        return [];
      
      case AppShadows.xs:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ];
      
      case AppShadows.sm:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: -1,
          ),
        ];
      
      case AppShadows.md:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -1,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: -2,
          ),
        ];
      
      case AppShadows.lg:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 10),
            blurRadius: 15,
            spreadRadius: -3,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -4,
          ),
        ];
      
      case AppShadows.xl:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 20),
            blurRadius: 25,
            spreadRadius: -5,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 8),
            blurRadius: 10,
            spreadRadius: -6,
          ),
        ];
      
      case AppShadows.xxl:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 25),
            blurRadius: 50,
            spreadRadius: -12,
          ),
        ];
      
      case AppShadows.inner:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ];
    }
  }

  List<BoxShadow> colored(Color color, {double opacity = 0.1}) {
    return shadows.map((shadow) => shadow.copyWith(
      color: color.withOpacity(opacity),
    )).toList();
  }

  List<BoxShadow> get elevatedShadows {
    switch (this) {
      case AppShadows.none:
        return [];
      case AppShadows.xs:
      case AppShadows.sm:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ];
      case AppShadows.md:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ];
      case AppShadows.lg:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 8),
            blurRadius: 16,
            spreadRadius: 0,
          ),
        ];
      case AppShadows.xl:
      case AppShadows.xxl:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.24),
            offset: const Offset(0, 12),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ];
      case AppShadows.inner:
        return shadows;
    }
  }
}

class AppShadowPresets {
  static List<BoxShadow> get button => AppShadows.sm.shadows;
  static List<BoxShadow> get buttonHover => AppShadows.md.shadows;
  static List<BoxShadow> get card => AppShadows.sm.shadows;
  static List<BoxShadow> get cardHover => AppShadows.lg.shadows;
  static List<BoxShadow> get dialog => AppShadows.xl.shadows;
  static List<BoxShadow> get dropdown => AppShadows.lg.shadows;
  static List<BoxShadow> get tooltip => AppShadows.md.shadows;
  static List<BoxShadow> get overlay => AppShadows.xxl.shadows;
}