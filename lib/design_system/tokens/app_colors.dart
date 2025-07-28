import 'package:flutter/material.dart';

enum AppColors {
  primary,
  secondary,
  accent,
  neutral,
  error,
  warning,
  success,
  info;

  static const _primarySwatch = {
    50: Color(0xFFF0F1FF),
    100: Color(0xFFE2E5FF),
    200: Color(0xFFC7CFFF),
    300: Color(0xFFA5B1FF),
    400: Color(0xFF8289FF),
    500: Color(0xFF6366F1),
    600: Color(0xFF4F46E5),
    700: Color(0xFF4338CA),
    800: Color(0xFF3730A3),
    900: Color(0xFF312E81),
  };

  static const _secondarySwatch = {
    50: Color(0xFFF8FAFC),
    100: Color(0xFFF1F5F9),
    200: Color(0xFFE2E8F0),
    300: Color(0xFFCBD5E0),
    400: Color(0xFF94A3B8),
    500: Color(0xFF64748B),
    600: Color(0xFF475569),
    700: Color(0xFF334155),
    800: Color(0xFF1E293B),
    900: Color(0xFF0F172A),
  };

  static const _neutralSwatch = {
    50: Color(0xFFFAFAFA),
    100: Color(0xFFF4F4F5),
    200: Color(0xFFE4E4E7),
    300: Color(0xFFD4D4D8),
    400: Color(0xFFA1A1AA),
    500: Color(0xFF71717A),
    600: Color(0xFF52525B),
    700: Color(0xFF3F3F46),
    800: Color(0xFF27272A),
    900: Color(0xFF18181B),
  };

  static const _errorSwatch = {
    50: Color(0xFFFEF2F2),
    100: Color(0xFFFEE2E2),
    200: Color(0xFFFECACA),
    300: Color(0xFFFCA5A5),
    400: Color(0xFFF87171),
    500: Color(0xFFEF4444),
    600: Color(0xFFDC2626),
    700: Color(0xFFB91C1C),
    800: Color(0xFF991B1B),
    900: Color(0xFF7F1D1D),
  };

  static const _warningSwatch = {
    50: Color(0xFFFEFBE8),
    100: Color(0xFFFEF3C7),
    200: Color(0xFFFDE68A),
    300: Color(0xFFFCD34D),
    400: Color(0xFFFBBF24),
    500: Color(0xFFF59E0B),
    600: Color(0xFFD97706),
    700: Color(0xFFB45309),
    800: Color(0xFF92400E),
    900: Color(0xFF78350F),
  };

  static const _successSwatch = {
    50: Color(0xFFECFDF5),
    100: Color(0xFFD1FAE5),
    200: Color(0xFFA7F3D0),
    300: Color(0xFF6EE7B7),
    400: Color(0xFF34D399),
    500: Color(0xFF10B981),
    600: Color(0xFF059669),
    700: Color(0xFF047857),
    800: Color(0xFF065F46),
    900: Color(0xFF064E3B),
  };

  static const _infoSwatch = {
    50: Color(0xFFEFF6FF),
    100: Color(0xFFDBEAFE),
    200: Color(0xFFBFDBFE),
    300: Color(0xFF93C5FD),
    400: Color(0xFF60A5FA),
    500: Color(0xFF3B82F6),
    600: Color(0xFF2563EB),
    700: Color(0xFF1D4ED8),
    800: Color(0xFF1E40AF),
    900: Color(0xFF1E3A8A),
  };

  Map<int, Color> get materialSwatch {
    switch (this) {
      case AppColors.primary:
        return _primarySwatch;
      case AppColors.secondary:
        return _secondarySwatch;
      case AppColors.accent:
        return _primarySwatch; // Using primary for accent
      case AppColors.neutral:
        return _neutralSwatch;
      case AppColors.error:
        return _errorSwatch;
      case AppColors.warning:
        return _warningSwatch;
      case AppColors.success:
        return _successSwatch;
      case AppColors.info:
        return _infoSwatch;
    }
  }

  Color shade(int shade) {
    return materialSwatch[shade] ?? materialSwatch[500]!;
  }

  ColorScheme get lightScheme {
    switch (this) {
      case AppColors.primary:
        return ColorScheme.light(
          primary: shade(500),
          onPrimary: Colors.white,
          primaryContainer: shade(100),
          onPrimaryContainer: shade(900),
          secondary: AppColors.secondary.shade(500),
          onSecondary: Colors.white,
          secondaryContainer: AppColors.secondary.shade(100),
          onSecondaryContainer: AppColors.secondary.shade(900),
          tertiary: AppColors.accent.shade(500),
          onTertiary: Colors.white,
          tertiaryContainer: AppColors.accent.shade(100),
          onTertiaryContainer: AppColors.accent.shade(900),
          error: AppColors.error.shade(500),
          onError: Colors.white,
          errorContainer: AppColors.error.shade(100),
          onErrorContainer: AppColors.error.shade(900),
          surface: Colors.white,
          onSurface: AppColors.neutral.shade(900),
          surfaceContainerHighest: AppColors.neutral.shade(50),
          outline: AppColors.neutral.shade(300),
          outlineVariant: AppColors.neutral.shade(200),
        );
      default:
        return lightScheme;
    }
  }

  ColorScheme get darkScheme {
    switch (this) {
      case AppColors.primary:
        return ColorScheme.dark(
          primary: shade(400),
          onPrimary: shade(900),
          primaryContainer: shade(700),
          onPrimaryContainer: shade(100),
          secondary: AppColors.secondary.shade(400),
          onSecondary: AppColors.secondary.shade(900),
          secondaryContainer: AppColors.secondary.shade(700),
          onSecondaryContainer: AppColors.secondary.shade(100),
          tertiary: AppColors.accent.shade(400),
          onTertiary: AppColors.accent.shade(900),
          tertiaryContainer: AppColors.accent.shade(700),
          onTertiaryContainer: AppColors.accent.shade(100),
          error: AppColors.error.shade(400),
          onError: AppColors.error.shade(900),
          errorContainer: AppColors.error.shade(700),
          onErrorContainer: AppColors.error.shade(100),
          surface: AppColors.neutral.shade(900),
          onSurface: AppColors.neutral.shade(100),
          surfaceContainerHighest: AppColors.neutral.shade(800),
          outline: AppColors.neutral.shade(600),
          outlineVariant: AppColors.neutral.shade(700),
        );
      default:
        return darkScheme;
    }
  }

  Color resolve(BuildContext context, {int shade = 500}) {
    final brightness = Theme.of(context).brightness;
    if (brightness == Brightness.dark) {
      // Adjust shades for dark theme (lighter shades for dark backgrounds)
      final adjustedShade = shade >= 500 ? shade - 200 : shade + 200;
      return materialSwatch[adjustedShade.clamp(50, 900)] ?? materialSwatch[shade]!;
    }
    return materialSwatch[shade] ?? materialSwatch[500]!;
  }

  Color border(BuildContext context) {
    return AppColors.neutral.resolve(context, shade: 200);
  }

  Color divider(BuildContext context) {
    return AppColors.neutral.resolve(context, shade: 100);
  }

  Color overlay(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? Colors.black.withOpacity(0.7)
        : Colors.black.withOpacity(0.5);
  }

  Color disabled(BuildContext context) {
    return AppColors.neutral.resolve(context, shade: 400);
  }

  Color focus(BuildContext context) {
    return resolve(context, shade: 200);
  }

  Color hover(BuildContext context) {
    return resolve(context, shade: 100);
  }
}

extension AppColorsContext on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  
  Color get borderColor => AppColors.neutral.border(this);
  Color get dividerColor => AppColors.neutral.divider(this);
  Color get overlayColor => AppColors.neutral.overlay(this);
  Color get disabledColor => AppColors.neutral.disabled(this);
}