import 'package:codika_template_empty_no_splash_screen/design_system/components/cards/app_card.dart';
import 'package:flutter/material.dart';

import '../../components/cards/app_clickable_card.dart';
import '../../theme/app_theme_extension.dart';
import '../../tokens/app_radius.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';

class ShowcaseCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;
  final bool isComingSoon;

  const ShowcaseCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
    this.isComingSoon = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme = theme.extension<AppThemeExtension>()!;

    return AppClickableCard(
      onTap: isComingSoon ? null : onTap,
      variant: AppCardVariant.outlined,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color: isComingSoon ? appTheme.disabled : theme.colorScheme.primary,
          ),
          AppSpacing.sm.gapV,
          Text(
            title,
            style: AppTextStyle.titleMedium.style.copyWith(
              color:
                  isComingSoon
                      ? appTheme.disabled
                      : theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          AppSpacing.xs.gapV,
          Text(
            description,
            style: AppTextStyle.bodySmall.style.copyWith(
              color:
                  isComingSoon
                      ? appTheme.disabled
                      : theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (isComingSoon) ...[
            AppSpacing.xs.gapV,
            Container(
              padding: AppSpacing.xs.symmetric(horizontal: AppSpacing.sm),
              decoration: BoxDecoration(
                color: appTheme.disabled.withOpacity(0.1),
                borderRadius: AppRadius.sm.borderRadius,
              ),
              child: Text(
                'Coming Soon',
                style: AppTextStyle.labelSmall.style.copyWith(
                  color: appTheme.disabled,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
