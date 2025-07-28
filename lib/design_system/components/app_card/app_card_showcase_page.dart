import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../playground/widgets/showcase_section.dart';
import '../../tokens/app_radius.dart';
import '../../tokens/app_shadows.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';
import 'app_card.dart';
import 'app_clickable_card.dart';

@RoutePage()
class CardShowcasePage extends StatelessWidget {
  const CardShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Card Components',
          style: AppTextStyle.headlineMedium.style,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.lg.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShowcaseSection(
              title: 'Base Card Variants',
              description: 'Different visual styles for non-interactive cards',
              children: [
                _buildVariantRow('Elevated', AppCardVariant.elevated),
                _buildVariantRow('Outlined', AppCardVariant.outlined),
                _buildVariantRow('Filled', AppCardVariant.filled),
              ],
            ),

            ShowcaseSection(
              title: 'Clickable Cards',
              description: 'Interactive cards with hover and press effects',
              children: [
                _buildClickableRow(
                  context,
                  'Clickable Elevated',
                  AppCardVariant.elevated,
                ),
                _buildClickableRow(
                  context,
                  'Clickable Outlined',
                  AppCardVariant.outlined,
                ),
                _buildClickableRow(context, 'Clickable Filled', AppCardVariant.filled),
              ],
            ),

            ShowcaseSection(
              title: 'Card Sizes',
              description: 'Cards with different dimensions',
              children: [
                _buildSizeRow('Small Card', 200, 120),
                _buildSizeRow('Medium Card', 300, 180),
                _buildSizeRow('Large Card', 400, 240),
              ],
            ),

            ShowcaseSection(
              title: 'Custom Properties',
              description: 'Cards with custom styling',
              children: [
                _buildCustomRow('Custom Radius', borderRadius: AppRadius.xl),
                _buildCustomRow(
                  'Custom Shadow',
                  shadows: AppShadows.lg.shadows,
                ),
                _buildCustomRow(
                  'Custom Background',
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                ),
              ],
            ),

            ShowcaseSection(
              title: 'Card Content Examples',
              description: 'Real-world card usage patterns',
              children: [
                _buildContentExample(context, 'User Profile Card'),
                _buildContentExample(context, 'Product Card'),
                _buildContentExample(context, 'Article Card'),
              ],
            ),

            ShowcaseSection(
              title: 'Interactive States',
              description: 'Different interaction states for clickable cards',
              children: [
                _buildInteractiveRow(context, 'Normal', true),
                _buildInteractiveRow(context, 'Disabled', false),
                _buildInteractiveRow(context, 'Without Ripple', true, showRipple: false),
                _buildInteractiveRow(
                  context,
                  'Without Hover',
                  true,
                  showHoverEffect: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVariantRow(String label, AppCardVariant variant) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyle.labelMedium.style),
          AppSpacing.xs.gapV,
          AppCard(
            variant: variant,
            width: 300,
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Card Title', style: AppTextStyle.titleMedium.style),
                AppSpacing.xs.gapV,
                Text(
                  'This is a $label card showing the basic styling and appearance.',
                  style: AppTextStyle.bodySmall.style,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClickableRow(BuildContext context, String label, AppCardVariant variant) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyle.labelMedium.style),
          AppSpacing.xs.gapV,
          AppClickableCard(
            variant: variant,
            width: 300,
            height: 120,
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('$label tapped!')));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Interactive Card',
                      style: AppTextStyle.titleMedium.style,
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
                AppSpacing.xs.gapV,
                Text(
                  'Click me to see the interaction! Hover for preview effects.',
                  style: AppTextStyle.bodySmall.style,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSizeRow(String label, double width, double height) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label (${width.toInt()}x${height.toInt()})',
            style: AppTextStyle.labelMedium.style,
          ),
          AppSpacing.xs.gapV,
          AppCard(
            variant: AppCardVariant.elevated,
            width: width,
            height: height,
            child: Center(
              child: Text(
                '${width.toInt()} × ${height.toInt()}',
                style: AppTextStyle.bodyMedium.style,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomRow(
    String label, {
    AppRadius? borderRadius,
    List<BoxShadow>? shadows,
    Color? backgroundColor,
  }) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyle.labelMedium.style),
          AppSpacing.xs.gapV,
          AppCard(
            variant: AppCardVariant.elevated,
            width: 280,
            height: 100,
            borderRadius: borderRadius,
            shadows: shadows,
            backgroundColor: backgroundColor,
            child: Center(
              child: Text(label, style: AppTextStyle.bodyMedium.style),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentExample(BuildContext context, String type) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(type, style: AppTextStyle.labelMedium.style),
          AppSpacing.xs.gapV,
          AppClickableCard(
            variant: AppCardVariant.elevated,
            width: 320,
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('$type clicked!')));
            },
            child: _buildCardContent(context, type),
          ),
        ],
      ),
    );
  }

  Widget _buildCardContent(BuildContext context, String type) {
    switch (type) {
      case 'User Profile Card':
        return Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                'JD',
                style: AppTextStyle.labelLarge.style.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            AppSpacing.md.gapH,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('John Doe', style: AppTextStyle.titleMedium.style),
                  AppSpacing.xs.gapV,
                  Text(
                    'Software Engineer • 5 years experience',
                    style: AppTextStyle.bodySmall.style,
                  ),
                ],
              ),
            ),
          ],
        );

      case 'Product Card':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: AppRadius.sm.borderRadius,
              ),
              child: Icon(
                Icons.image,
                size: 40,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            AppSpacing.sm.gapV,
            Text('Premium Widget', style: AppTextStyle.titleMedium.style),
            AppSpacing.xs.gapV,
            Text(
              '\$29.99',
              style: AppTextStyle.titleSmall.style.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );

      case 'Article Card':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Getting Started with Flutter',
              style: AppTextStyle.titleMedium.style,
            ),
            AppSpacing.sm.gapV,
            Text(
              'Learn the basics of Flutter development with this comprehensive guide for beginners.',
              style: AppTextStyle.bodySmall.style,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            AppSpacing.sm.gapV,
            Row(
              children: [
                Text(
                  'TUTORIAL',
                  style: AppTextStyle.labelSmall.style.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const Spacer(),
                Text('5 min read', style: AppTextStyle.labelSmall.style),
              ],
            ),
          ],
        );

      default:
        return Text(
          'Sample content for $type',
          style: AppTextStyle.bodyMedium.style,
        );
    }
  }

  Widget _buildInteractiveRow(
    BuildContext context,
    String label,
    bool hasCallback, {
    bool showRipple = true,
    bool showHoverEffect = true,
  }) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyle.labelMedium.style),
          AppSpacing.xs.gapV,
          AppClickableCard(
            variant: AppCardVariant.outlined,
            width: 280,
            height: 80,
            showRipple: showRipple,
            showHoverEffect: showHoverEffect,
            onTap:
                hasCallback
                    ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$label interaction!')),
                      );
                    }
                    : null,
            child: Center(
              child: Text(
                hasCallback ? 'Tap me!' : 'Disabled',
                style: AppTextStyle.bodyMedium.style.copyWith(
                  color:
                      hasCallback
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.38),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
