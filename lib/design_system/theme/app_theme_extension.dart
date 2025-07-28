import 'package:flutter/material.dart';
import '../tokens/app_colors.dart';
import '../tokens/app_density.dart';
import '../tokens/app_radius.dart';
import '../tokens/app_shadows.dart';
import '../tokens/app_spacing.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final Color border;
  final Color borderVariant;
  final Color divider;
  final Color overlay;
  final Color disabled;
  final Color focus;
  final Color hover;
  final Color success;
  final Color warning;
  final Color info;
  final AppDensity density;
  final AppSpacing defaultSpacing;
  final AppRadius defaultRadius;
  final AppShadows defaultShadow;

  const AppThemeExtension({
    required this.border,
    required this.borderVariant,
    required this.divider,
    required this.overlay,
    required this.disabled,
    required this.focus,
    required this.hover,
    required this.success,
    required this.warning,
    required this.info,
    required this.density,
    required this.defaultSpacing,
    required this.defaultRadius,
    required this.defaultShadow,
  });

  factory AppThemeExtension.light() {
    return AppThemeExtension(
      border: AppColors.neutral.materialSwatch[200]!,
      borderVariant: AppColors.neutral.materialSwatch[100]!,
      divider: AppColors.neutral.materialSwatch[100]!,
      overlay: Colors.black.withOpacity(0.5),
      disabled: AppColors.neutral.materialSwatch[400]!,
      focus: AppColors.primary.materialSwatch[200]!,
      hover: AppColors.neutral.materialSwatch[50]!,
      success: AppColors.success.materialSwatch[500]!,
      warning: AppColors.warning.materialSwatch[500]!,
      info: AppColors.info.materialSwatch[500]!,
      density: AppDensity.standard,
      defaultSpacing: AppSpacing.md,
      defaultRadius: AppRadius.lg,
      defaultShadow: AppShadows.sm,
    );
  }

  factory AppThemeExtension.dark() {
    return AppThemeExtension(
      border: AppColors.neutral.materialSwatch[700]!,
      borderVariant: AppColors.neutral.materialSwatch[800]!,
      divider: AppColors.neutral.materialSwatch[800]!,
      overlay: Colors.black.withOpacity(0.7),
      disabled: AppColors.neutral.materialSwatch[600]!,
      focus: AppColors.primary.materialSwatch[400]!,
      hover: AppColors.neutral.materialSwatch[800]!,
      success: AppColors.success.materialSwatch[400]!,
      warning: AppColors.warning.materialSwatch[400]!,
      info: AppColors.info.materialSwatch[400]!,
      density: AppDensity.standard,
      defaultSpacing: AppSpacing.md,
      defaultRadius: AppRadius.lg,
      defaultShadow: AppShadows.sm,
    );
  }

  @override
  AppThemeExtension copyWith({
    Color? border,
    Color? borderVariant,
    Color? divider,
    Color? overlay,
    Color? disabled,
    Color? focus,
    Color? hover,
    Color? success,
    Color? warning,
    Color? info,
    AppDensity? density,
    AppSpacing? defaultSpacing,
    AppRadius? defaultRadius,
    AppShadows? defaultShadow,
  }) {
    return AppThemeExtension(
      border: border ?? this.border,
      borderVariant: borderVariant ?? this.borderVariant,
      divider: divider ?? this.divider,
      overlay: overlay ?? this.overlay,
      disabled: disabled ?? this.disabled,
      focus: focus ?? this.focus,
      hover: hover ?? this.hover,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      density: density ?? this.density,
      defaultSpacing: defaultSpacing ?? this.defaultSpacing,
      defaultRadius: defaultRadius ?? this.defaultRadius,
      defaultShadow: defaultShadow ?? this.defaultShadow,
    );
  }

  @override
  AppThemeExtension lerp(AppThemeExtension? other, double t) {
    if (other is! AppThemeExtension) {
      return this;
    }
    return AppThemeExtension(
      border: Color.lerp(border, other.border, t)!,
      borderVariant: Color.lerp(borderVariant, other.borderVariant, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      overlay: Color.lerp(overlay, other.overlay, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
      focus: Color.lerp(focus, other.focus, t)!,
      hover: Color.lerp(hover, other.hover, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      density: t < 0.5 ? density : other.density,
      defaultSpacing: t < 0.5 ? defaultSpacing : other.defaultSpacing,
      defaultRadius: t < 0.5 ? defaultRadius : other.defaultRadius,
      defaultShadow: t < 0.5 ? defaultShadow : other.defaultShadow,
    );
  }
}

extension AppThemeContext on BuildContext {
  AppThemeExtension get appTheme {
    return Theme.of(this).extension<AppThemeExtension>()!;
  }

  // Convenience getters for common properties
  Color get borderColor => appTheme.border;
  Color get borderVariantColor => appTheme.borderVariant;
  Color get dividerColor => appTheme.divider;
  Color get overlayColor => appTheme.overlay;
  Color get disabledColor => appTheme.disabled;
  Color get focusColor => appTheme.focus;
  Color get hoverColor => appTheme.hover;
  Color get successColor => appTheme.success;
  Color get warningColor => appTheme.warning;
  Color get infoColor => appTheme.info;
  
  AppDensity get density => appTheme.density;
  AppSpacing get spacing => appTheme.defaultSpacing;
  AppRadius get radius => appTheme.defaultRadius;
  AppShadows get shadow => appTheme.defaultShadow;
}