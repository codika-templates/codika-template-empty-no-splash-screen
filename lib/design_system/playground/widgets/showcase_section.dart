import 'package:flutter/material.dart';

import '../../theme/app_theme_extension.dart';
import '../../tokens/app_shadows.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';

class ShowcaseSection extends StatelessWidget {
  final String title;
  final String? description;
  final List<Widget> children;

  const ShowcaseSection({
    super.key,
    required this.title,
    this.description,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme = theme.extension<AppThemeExtension>()!;

    return Container(
      margin: AppSpacing.lg.paddingBottom,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: appTheme.defaultRadius.borderRadius,
        border: Border.all(color: appTheme.border),
        boxShadow: AppShadows.sm.shadows,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: AppSpacing.md.padding,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.only(
                topLeft: appTheme.defaultRadius.borderRadius.topLeft,
                topRight: appTheme.defaultRadius.borderRadius.topRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.titleMedium.style.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                if (description != null) ...[
                  AppSpacing.xs.gapV,
                  Text(
                    description!,
                    style: AppTextStyle.bodySmall.style.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: AppSpacing.md.padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
