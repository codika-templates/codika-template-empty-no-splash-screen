import 'package:flutter/material.dart';

import '../tokens/app_spacing.dart';
import '../tokens/app_typography.dart';
import 'app_card/app_card.dart';

/// ShowcaseCard for displaying individual component examples with child content
class ShowcaseCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;

  const ShowcaseCard({
    super.key,
    required this.title,
    required this.description,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      variant: AppCardVariant.outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyle.titleMedium.style,
              ),
              AppSpacing.xs.gapV,
              Text(
                description,
                style: AppTextStyle.bodySmall.style.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          
          AppSpacing.lg.gapV,
          
          // Content
          child,
        ],
      ),
    );
  }
}