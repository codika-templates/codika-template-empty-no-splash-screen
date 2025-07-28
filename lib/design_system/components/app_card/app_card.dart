import 'package:flutter/material.dart';

import '../../tokens/app_spacing.dart';
import '../../tokens/app_radius.dart';
import '../../tokens/app_shadows.dart';
import '../../theme/app_theme_extension.dart';

enum AppCardVariant { elevated, outlined, filled }

/// Base card component for the design system
class AppCard extends StatelessWidget {
  final Widget child;
  final AppCardVariant variant;
  final EdgeInsets? padding;
  final AppRadius? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final List<BoxShadow>? shadows;
  final double? width;
  final double? height;

  const AppCard({
    super.key,
    required this.child,
    this.variant = AppCardVariant.elevated,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.shadows,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme = theme.extension<AppThemeExtension>()!;
    
    final effectivePadding = padding ?? AppSpacing.md.padding;
    final effectiveRadius = borderRadius ?? appTheme.defaultRadius;
    
    Color cardBackgroundColor;
    Border? border;
    List<BoxShadow> cardShadows;
    
    switch (variant) {
      case AppCardVariant.elevated:
        cardBackgroundColor = backgroundColor ?? theme.colorScheme.surface;
        border = null;
        cardShadows = shadows ?? AppShadows.sm.shadows;
        break;
      case AppCardVariant.outlined:
        cardBackgroundColor = backgroundColor ?? theme.colorScheme.surface;
        border = Border.all(color: borderColor ?? appTheme.border);
        cardShadows = shadows ?? [];
        break;
      case AppCardVariant.filled:
        cardBackgroundColor = backgroundColor ?? theme.colorScheme.surfaceContainerHighest;
        border = null;
        cardShadows = shadows ?? [];
        break;
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: effectiveRadius.borderRadius,
        border: border,
        boxShadow: cardShadows,
      ),
      child: Padding(
        padding: effectivePadding,
        child: child,
      ),
    );
  }
}