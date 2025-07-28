import 'package:flutter/material.dart';

enum AppTextStyle {
  displayLarge,    // 57px - Display headlines
  displayMedium,   // 45px - Display headlines
  displaySmall,    // 36px - Display headlines
  headlineLarge,   // 32px - Large headlines
  headlineMedium,  // 28px - Medium headlines
  headlineSmall,   // 24px - Small headlines
  titleLarge,      // 22px - Prominent titles
  titleMedium,     // 16px - Medium titles
  titleSmall,      // 14px - Small titles
  bodyLarge,       // 16px - Emphasized body text
  bodyMedium,      // 14px - Regular body text
  bodySmall,       // 12px - Supporting text
  labelLarge,      // 14px - Action labels (buttons)
  labelMedium,     // 12px - Feature labels
  labelSmall;      // 11px - Small labels

  TextStyle get style {
    switch (this) {
      case AppTextStyle.displayLarge:
        return const TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          height: 1.12,
        );
      
      case AppTextStyle.displayMedium:
        return const TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.16,
        );
      
      case AppTextStyle.displaySmall:
        return const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.22,
        );
      
      case AppTextStyle.headlineLarge:
        return const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.25,
        );
      
      case AppTextStyle.headlineMedium:
        return const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.29,
        );
      
      case AppTextStyle.headlineSmall:
        return const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.33,
        );
      
      case AppTextStyle.titleLarge:
        return const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          height: 1.27,
        );
      
      case AppTextStyle.titleMedium:
        return const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          height: 1.50,
        );
      
      case AppTextStyle.titleSmall:
        return const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.43,
        );
      
      case AppTextStyle.bodyLarge:
        return const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          height: 1.50,
        );
      
      case AppTextStyle.bodyMedium:
        return const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          height: 1.43,
        );
      
      case AppTextStyle.bodySmall:
        return const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          height: 1.33,
        );
      
      case AppTextStyle.labelLarge:
        return const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.43,
        );
      
      case AppTextStyle.labelMedium:
        return const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.33,
        );
      
      case AppTextStyle.labelSmall:
        return const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.45,
        );
    }
  }

  TextStyle colored(Color color) => style.copyWith(color: color);

  TextStyle bold() => style.copyWith(fontWeight: FontWeight.w700);

  TextStyle semiBold() => style.copyWith(fontWeight: FontWeight.w600);

  TextStyle medium() => style.copyWith(fontWeight: FontWeight.w500);

  TextStyle regular() => style.copyWith(fontWeight: FontWeight.w400);

  TextStyle light() => style.copyWith(fontWeight: FontWeight.w300);

  TextStyle italic() => style.copyWith(fontStyle: FontStyle.italic);

  TextStyle underline() => style.copyWith(decoration: TextDecoration.underline);

  TextStyle lineThrough() => style.copyWith(decoration: TextDecoration.lineThrough);

  TextStyle height(double height) => style.copyWith(height: height);

  TextStyle letterSpacing(double spacing) => style.copyWith(letterSpacing: spacing);
}

class AppTextTheme {
  static TextTheme get light => TextTheme(
    displayLarge: AppTextStyle.displayLarge.style,
    displayMedium: AppTextStyle.displayMedium.style,
    displaySmall: AppTextStyle.displaySmall.style,
    headlineLarge: AppTextStyle.headlineLarge.style,
    headlineMedium: AppTextStyle.headlineMedium.style,
    headlineSmall: AppTextStyle.headlineSmall.style,
    titleLarge: AppTextStyle.titleLarge.style,
    titleMedium: AppTextStyle.titleMedium.style,
    titleSmall: AppTextStyle.titleSmall.style,
    bodyLarge: AppTextStyle.bodyLarge.style,
    bodyMedium: AppTextStyle.bodyMedium.style,
    bodySmall: AppTextStyle.bodySmall.style,
    labelLarge: AppTextStyle.labelLarge.style,
    labelMedium: AppTextStyle.labelMedium.style,
    labelSmall: AppTextStyle.labelSmall.style,
  );

  static TextTheme get dark => light; // Same styles for dark theme
}

extension AppTextStyleContext on BuildContext {
  TextStyle get displayLarge => Theme.of(this).textTheme.displayLarge!;
  TextStyle get displayMedium => Theme.of(this).textTheme.displayMedium!;
  TextStyle get displaySmall => Theme.of(this).textTheme.displaySmall!;
  TextStyle get headlineLarge => Theme.of(this).textTheme.headlineLarge!;
  TextStyle get headlineMedium => Theme.of(this).textTheme.headlineMedium!;
  TextStyle get headlineSmall => Theme.of(this).textTheme.headlineSmall!;
  TextStyle get titleLarge => Theme.of(this).textTheme.titleLarge!;
  TextStyle get titleMedium => Theme.of(this).textTheme.titleMedium!;
  TextStyle get titleSmall => Theme.of(this).textTheme.titleSmall!;
  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get bodySmall => Theme.of(this).textTheme.bodySmall!;
  TextStyle get labelLarge => Theme.of(this).textTheme.labelLarge!;
  TextStyle get labelMedium => Theme.of(this).textTheme.labelMedium!;
  TextStyle get labelSmall => Theme.of(this).textTheme.labelSmall!;
}