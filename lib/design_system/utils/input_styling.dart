import 'package:flutter/material.dart';

import '../theme/app_theme_extension.dart';
import '../tokens/app_colors.dart';
import '../tokens/app_density.dart';
import '../tokens/app_radius.dart';
import '../tokens/app_spacing.dart';
import '../tokens/app_typography.dart';
import '../components/app_text_field/app_text_field.dart';

/// Utility class for creating consistent input decorations across text fields and dropdowns
class AppInputStyling {
  /// Creates an InputDecoration that matches the design system
  static InputDecoration buildDecoration({
    required BuildContext context,
    required AppTextFieldVariant variant,
    required AppTextFieldSize size,
    required AppTextFieldState state,
    AppDensity? density,
    AppRadius? borderRadius,
    String? hintText,
    String? labelText,
    String? errorText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? prefixText,
    String? suffixText,
    Color? fillColor,
    Color? focusColor,
    Color? hoverColor,
    bool animateLabel = true,
    bool showCounter = false,
    bool isHovered = false,
  }) {
    final theme = Theme.of(context);
    final appTheme = context.appTheme;
    final effectiveDensity = density ?? appTheme.density;
    final radius = borderRadius ?? appTheme.defaultRadius;

    // Size-based properties
    final sizeConfig = _getSizeConfiguration(size, effectiveDensity);
    
    // State-based colors
    final colorConfig = _getColorConfiguration(
      context, 
      state, 
      theme, 
      appTheme,
      fillColor: fillColor,
      focusColor: focusColor,
      hoverColor: hoverColor,
    );

    // Variant-specific borders
    final borderConfig = _getBorderConfiguration(
      variant, 
      radius, 
      colorConfig,
    );

    return InputDecoration(
      labelText: animateLabel ? labelText : null,
      hintText: hintText,
      errorText: errorText,
      prefixIcon: prefixIcon != null
          ? Padding(
              padding: EdgeInsets.only(left: AppSpacing.sm.value),
              child: Transform.scale(
                scale: 0.85,
                child: prefixIcon,
              ),
            )
          : null,
      suffixIcon: suffixIcon != null
          ? Padding(
              padding: EdgeInsets.only(right: AppSpacing.sm.value),
              child: Transform.scale(
                scale: 0.85,
                child: suffixIcon,
              ),
            )
          : null,
      prefixText: prefixText,
      suffixText: suffixText,
      contentPadding: sizeConfig.contentPadding,
      border: borderConfig.border,
      enabledBorder: borderConfig.border,
      focusedBorder: borderConfig.focusedBorder,
      errorBorder: borderConfig.errorBorder,
      focusedErrorBorder: borderConfig.focusedErrorBorder,
      disabledBorder: borderConfig.border,
      filled: colorConfig.fillColor != null,
      fillColor: colorConfig.fillColor,
      hoverColor: isHovered ? colorConfig.hoverColor : null,
      labelStyle: sizeConfig.labelStyle.copyWith(color: colorConfig.labelColor),
      hintStyle: sizeConfig.hintStyle.copyWith(color: colorConfig.hintColor),
      errorStyle: sizeConfig.helperStyle.copyWith(
        color: AppColors.error.materialSwatch[500]!,
      ),
      prefixIconConstraints: BoxConstraints(
        minWidth: sizeConfig.iconSize + AppSpacing.md.value,
        minHeight: sizeConfig.iconSize,
      ),
      suffixIconConstraints: BoxConstraints(
        minWidth: sizeConfig.iconSize + AppSpacing.md.value,
        minHeight: sizeConfig.iconSize,
      ),
      counterText: showCounter ? null : '',
      errorMaxLines: 2,
      floatingLabelBehavior:
          animateLabel
              ? FloatingLabelBehavior.auto
              : FloatingLabelBehavior.never,
    );
  }

  /// Creates a TextStyle for input text based on size and state
  static TextStyle buildTextStyle({
    required BuildContext context,
    required AppTextFieldSize size,
    required AppTextFieldState state,
  }) {
    final theme = Theme.of(context);

    TextStyle baseStyle;
    switch (size) {
      case AppTextFieldSize.sm:
        baseStyle = AppTextStyle.bodySmall.style;
        break;
      case AppTextFieldSize.md:
        baseStyle = AppTextStyle.bodyMedium.style;
        break;
      case AppTextFieldSize.lg:
        baseStyle = AppTextStyle.bodyLarge.style;
        break;
    }

    Color textColor;
    switch (state) {
      case AppTextFieldState.disabled:
        textColor = context.appTheme.disabled;
        break;
      default:
        textColor = theme.colorScheme.onSurface;
        break;
    }

    return baseStyle.copyWith(color: textColor);
  }

  /// Creates content padding based on size and density
  static EdgeInsets buildContentPadding({
    required AppTextFieldSize size,
    AppDensity? density,
  }) {
    final sizeConfig = _getSizeConfiguration(size, density ?? AppDensity.standard);
    return sizeConfig.contentPadding;
  }

  /// Gets size-based configuration
  static _SizeConfiguration _getSizeConfiguration(
    AppTextFieldSize size, 
    AppDensity density,
  ) {
    switch (size) {
      case AppTextFieldSize.sm:
        return _SizeConfiguration(
          contentPadding: AppSpacing.sm.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          iconSize: density.buttonIconSize * 0.9,
          labelStyle: AppTextStyle.labelMedium.style,
          hintStyle: AppTextStyle.bodySmall.style,
          helperStyle: AppTextStyle.bodySmall.style,
        );
      case AppTextFieldSize.md:
        return _SizeConfiguration(
          contentPadding: AppSpacing.md.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          iconSize: density.buttonIconSize,
          labelStyle: AppTextStyle.labelLarge.style,
          hintStyle: AppTextStyle.bodyMedium.style,
          helperStyle: AppTextStyle.bodySmall.style,
        );
      case AppTextFieldSize.lg:
        return _SizeConfiguration(
          contentPadding: AppSpacing.lg.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          iconSize: density.buttonIconSize * 1.1,
          labelStyle: AppTextStyle.labelLarge.style,
          hintStyle: AppTextStyle.bodyLarge.style,
          helperStyle: AppTextStyle.bodyMedium.style,
        );
    }
  }

  /// Gets state-based color configuration
  static _ColorConfiguration _getColorConfiguration(
    BuildContext context,
    AppTextFieldState state,
    ThemeData theme,
    AppThemeExtension appTheme, {
    Color? fillColor,
    Color? focusColor,
    Color? hoverColor,
  }) {
    switch (state) {
      case AppTextFieldState.normal:
        return _ColorConfiguration(
          borderColor: appTheme.border,
          fillColor: fillColor,
          focusColor: focusColor ?? theme.colorScheme.primary,
          hoverColor: hoverColor ?? theme.colorScheme.onSurface.withValues(alpha: 0.04),
          labelColor: theme.colorScheme.onSurfaceVariant,
          hintColor: theme.colorScheme.onSurfaceVariant,
        );
      case AppTextFieldState.focused:
        return _ColorConfiguration(
          borderColor: theme.colorScheme.primary,
          fillColor: fillColor,
          focusColor: theme.colorScheme.primary,
          hoverColor: hoverColor ?? theme.colorScheme.onSurface.withValues(alpha: 0.04),
          labelColor: theme.colorScheme.primary,
          hintColor: theme.colorScheme.onSurfaceVariant,
        );
      case AppTextFieldState.error:
        return _ColorConfiguration(
          borderColor: AppColors.error.materialSwatch[500]!,
          fillColor: fillColor,
          focusColor: AppColors.error.materialSwatch[500]!,
          hoverColor: AppColors.error.materialSwatch[50]!,
          labelColor: AppColors.error.materialSwatch[500]!,
          hintColor: theme.colorScheme.onSurfaceVariant,
        );
      case AppTextFieldState.disabled:
        return _ColorConfiguration(
          borderColor: appTheme.disabled,
          fillColor: appTheme.disabled.withValues(alpha: 0.04),
          focusColor: null,
          hoverColor: null,
          labelColor: appTheme.disabled,
          hintColor: appTheme.disabled,
        );
      case AppTextFieldState.success:
        return _ColorConfiguration(
          borderColor: AppColors.success.materialSwatch[500]!,
          fillColor: fillColor,
          focusColor: AppColors.success.materialSwatch[500]!,
          hoverColor: AppColors.success.materialSwatch[50]!,
          labelColor: AppColors.success.materialSwatch[500]!,
          hintColor: theme.colorScheme.onSurfaceVariant,
        );
    }
  }

  /// Gets variant-specific border configuration
  static _BorderConfiguration _getBorderConfiguration(
    AppTextFieldVariant variant,
    AppRadius radius,
    _ColorConfiguration colorConfig,
  ) {
    switch (variant) {
      case AppTextFieldVariant.outlined:
        return _BorderConfiguration(
          border: OutlineInputBorder(
            borderRadius: radius.borderRadius,
            borderSide: BorderSide(color: colorConfig.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: radius.borderRadius,
            borderSide: BorderSide(
              color: colorConfig.focusColor ?? colorConfig.borderColor, 
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: radius.borderRadius,
            borderSide: BorderSide(color: AppColors.error.materialSwatch[500]!),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: radius.borderRadius,
            borderSide: BorderSide(
              color: AppColors.error.materialSwatch[500]!,
              width: 2,
            ),
          ),
        );
      case AppTextFieldVariant.filled:
        return _BorderConfiguration(
          border: OutlineInputBorder(
            borderRadius: radius.borderRadius,
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: radius.borderRadius,
            borderSide: BorderSide(
              color: colorConfig.focusColor ?? colorConfig.borderColor, 
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: radius.borderRadius,
            borderSide: BorderSide(color: AppColors.error.materialSwatch[500]!),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: radius.borderRadius,
            borderSide: BorderSide(
              color: AppColors.error.materialSwatch[500]!,
              width: 2,
            ),
          ),
        );
      case AppTextFieldVariant.underlined:
        return _BorderConfiguration(
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: colorConfig.borderColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: colorConfig.focusColor ?? colorConfig.borderColor, 
              width: 2,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.error.materialSwatch[500]!),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.error.materialSwatch[500]!,
              width: 2,
            ),
          ),
        );
    }
  }
}

/// Internal configuration classes
class _SizeConfiguration {
  final EdgeInsets contentPadding;
  final double iconSize;
  final TextStyle labelStyle;
  final TextStyle hintStyle;
  final TextStyle helperStyle;

  _SizeConfiguration({
    required this.contentPadding,
    required this.iconSize,
    required this.labelStyle,
    required this.hintStyle,
    required this.helperStyle,
  });
}

class _ColorConfiguration {
  final Color borderColor;
  final Color? fillColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color labelColor;
  final Color hintColor;

  _ColorConfiguration({
    required this.borderColor,
    this.fillColor,
    this.focusColor,
    this.hoverColor,
    required this.labelColor,
    required this.hintColor,
  });
}

class _BorderConfiguration {
  final InputBorder border;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;

  _BorderConfiguration({
    required this.border,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
  });
}