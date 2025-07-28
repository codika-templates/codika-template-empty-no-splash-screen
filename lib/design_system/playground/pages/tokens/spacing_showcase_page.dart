import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../tokens/app_spacing.dart';
import '../../../tokens/app_typography.dart';
import '../../../tokens/app_radius.dart';
import '../../widgets/showcase_section.dart';

@RoutePage()
class SpacingShowcasePage extends StatelessWidget {
  const SpacingShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Spacing Tokens',
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
              title: 'Spacing Scale',
              description: 'Standard spacing values for consistent layouts',
              children: AppSpacing.values.map((spacing) => 
                _buildSpacingDemo(context, spacing)).toList(),
            ),
            
            ShowcaseSection(
              title: 'Padding Examples',
              description: 'How spacing tokens work as padding',
              children: [
                _buildPaddingExample(context, 'All Sides', AppSpacing.md.padding),
                _buildPaddingExample(context, 'Horizontal', AppSpacing.md.paddingHorizontal),
                _buildPaddingExample(context, 'Vertical', AppSpacing.md.paddingVertical),
                _buildPaddingExample(context, 'Top Only', AppSpacing.md.paddingTop),
              ],
            ),
            
            ShowcaseSection(
              title: 'Gap Examples',
              description: 'Spacing between elements',
              children: [
                _buildGapExample(context, 'Horizontal Gap', true),
                _buildGapExample(context, 'Vertical Gap', false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpacingDemo(BuildContext context, AppSpacing spacing) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: InkWell(
        onTap: () {
          Clipboard.setData(ClipboardData(text: 'AppSpacing.${spacing.name}'));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Copied AppSpacing.${spacing.name} to clipboard'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: Row(
          children: [
            SizedBox(
              width: 80,
              child: Text(
                spacing.name.toUpperCase(),
                style: AppTextStyle.labelMedium.style,
              ),
            ),
            AppSpacing.md.gapH,
            SizedBox(
              width: 60,
              child: Text(
                '${spacing.value.toInt()}px',
                style: AppTextStyle.bodyMedium.style,
              ),
            ),
            AppSpacing.md.gapH,
            Container(
              width: spacing.value,
              height: 20,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: AppRadius.xs.borderRadius,
              ),
            ),
            AppSpacing.md.gapH,
            Icon(
              Icons.copy,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaddingExample(BuildContext context, String name, EdgeInsets padding) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: AppTextStyle.labelMedium.style,
          ),
          AppSpacing.xs.gapV,
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                style: BorderStyle.solid,
              ),
              borderRadius: AppRadius.sm.borderRadius,
            ),
            child: Container(
              padding: padding,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: AppRadius.xs.borderRadius,
                ),
                child: Center(
                  child: Text(
                    'Content with $name padding',
                    style: AppTextStyle.bodySmall.style.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGapExample(BuildContext context, String name, bool horizontal) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: AppTextStyle.labelMedium.style,
          ),
          AppSpacing.xs.gapV,
          horizontal
              ? Row(
                  children: [
                    _buildGapBox(context),
                    AppSpacing.md.gapH,
                    _buildGapBox(context),
                    AppSpacing.md.gapH,
                    _buildGapBox(context),
                  ],
                )
              : Column(
                  children: [
                    _buildGapBox(context),
                    AppSpacing.md.gapV,
                    _buildGapBox(context),
                    AppSpacing.md.gapV,
                    _buildGapBox(context),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildGapBox(BuildContext context) {
    return Container(
      width: 60,
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: AppRadius.xs.borderRadius,
      ),
      child: Center(
        child: Text(
          'Box',
          style: AppTextStyle.bodySmall.style.copyWith(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ),
      ),
    );
  }
}