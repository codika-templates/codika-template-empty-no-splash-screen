import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../tokens/app_colors.dart';
import '../../../tokens/app_spacing.dart';
import '../../../tokens/app_typography.dart';
import '../../../tokens/app_radius.dart';
import '../../widgets/showcase_section.dart';

@RoutePage()
class ColorsShowcasePage extends StatelessWidget {
  const ColorsShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Color Tokens',
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
              title: 'Color Swatches',
              description: 'All available color palettes with their shade variations',
              children: [
                _buildColorSwatch(context, 'Primary', AppColors.primary),
                _buildColorSwatch(context, 'Secondary', AppColors.secondary),
                _buildColorSwatch(context, 'Neutral', AppColors.neutral),
                _buildColorSwatch(context, 'Error', AppColors.error),
                _buildColorSwatch(context, 'Warning', AppColors.warning),
                _buildColorSwatch(context, 'Success', AppColors.success),
                _buildColorSwatch(context, 'Info', AppColors.info),
              ],
            ),
            
            ShowcaseSection(
              title: 'Theme Colors',
              description: 'Current theme color scheme',
              children: [
                _buildThemeColor(context, 'Primary', 
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.onPrimary),
                _buildThemeColor(context, 'Secondary', 
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.onSecondary),
                _buildThemeColor(context, 'Surface', 
                    Theme.of(context).colorScheme.surface,
                    Theme.of(context).colorScheme.onSurface),
                _buildThemeColor(context, 'Background', 
                    Theme.of(context).colorScheme.surface,
                    Theme.of(context).colorScheme.onSurface),
                _buildThemeColor(context, 'Error', 
                    Theme.of(context).colorScheme.error,
                    Theme.of(context).colorScheme.onError),
              ],
            ),
            
            ShowcaseSection(
              title: 'Semantic Colors',
              description: 'Context-specific color usage',
              children: [
                _buildSemanticColor(context, 'Border', AppColors.neutral.border(context)),
                _buildSemanticColor(context, 'Divider', AppColors.neutral.divider(context)),
                _buildSemanticColor(context, 'Disabled', AppColors.neutral.disabled(context)),
                _buildSemanticColor(context, 'Overlay', AppColors.neutral.overlay(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorSwatch(BuildContext context, String name, AppColors colorEnum) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppSpacing.sm.paddingBottom,
          child: Text(
            name,
            style: AppTextStyle.titleSmall.style,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: AppRadius.md.borderRadius,
            border: Border.all(color: Theme.of(context).colorScheme.outline),
          ),
          child: Row(
            children: [50, 100, 200, 300, 400, 500, 600, 700, 800, 900]
                .map((shade) => _buildColorTile(
                      context,
                      colorEnum.shade(shade),
                      '$shade',
                      colorEnum.shade(shade),
                    ))
                .toList(),
          ),
        ),
        AppSpacing.md.gapV,
      ],
    );
  }

  Widget _buildColorTile(BuildContext context, Color color, String label, Color colorValue) {
    final isLight = color.computeLuminance() > 0.5;
    final textColor = isLight ? Colors.black : Colors.white;
    
    return Expanded(
      child: InkWell(
        onTap: () {
          final hex = '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
          Clipboard.setData(ClipboardData(text: hex));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Copied $hex to clipboard'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: color,
            borderRadius: label == '50' 
                ? BorderRadius.only(
                    topLeft: AppRadius.md.borderRadius.topLeft,
                    bottomLeft: AppRadius.md.borderRadius.bottomLeft,
                  )
                : label == '900'
                    ? BorderRadius.only(
                        topRight: AppRadius.md.borderRadius.topRight,
                        bottomRight: AppRadius.md.borderRadius.bottomRight,
                      )
                    : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: AppTextStyle.labelSmall.style.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '#${color.value.toRadixString(16).substring(2).toUpperCase()}',
                style: AppTextStyle.labelSmall.style.copyWith(
                  color: textColor.withOpacity(0.8),
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeColor(BuildContext context, String name, Color color, Color onColor) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: InkWell(
        onTap: () {
          final hex = '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
          Clipboard.setData(ClipboardData(text: hex));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Copied $hex to clipboard'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: AppRadius.md.borderRadius,
            border: Border.all(color: Theme.of(context).colorScheme.outline),
          ),
          child: Padding(
            padding: AppSpacing.md.paddingHorizontal,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: AppTextStyle.titleSmall.style.copyWith(color: onColor),
                      ),
                      Text(
                        '#${color.value.toRadixString(16).substring(2).toUpperCase()}',
                        style: AppTextStyle.bodySmall.style.copyWith(
                          color: onColor.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.copy,
                  color: onColor.withOpacity(0.5),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSemanticColor(BuildContext context, String name, Color color) {
    final isLight = color.computeLuminance() > 0.5;
    final textColor = isLight ? Colors.black : Colors.white;
    
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: InkWell(
        onTap: () {
          final hex = '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
          Clipboard.setData(ClipboardData(text: hex));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Copied $hex to clipboard'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: AppRadius.md.borderRadius,
            border: Border.all(color: Theme.of(context).colorScheme.outline),
          ),
          child: Padding(
            padding: AppSpacing.md.paddingHorizontal,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        name,
                        style: AppTextStyle.titleSmall.style.copyWith(color: textColor),
                      ),
                      AppSpacing.md.gapH,
                      Text(
                        '#${color.value.toRadixString(16).substring(2).toUpperCase()}',
                        style: AppTextStyle.bodySmall.style.copyWith(
                          color: textColor.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.copy,
                  color: textColor.withOpacity(0.5),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}