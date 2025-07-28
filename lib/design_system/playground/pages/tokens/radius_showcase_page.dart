import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../tokens/app_radius.dart';
import '../../../tokens/app_spacing.dart';
import '../../../tokens/app_typography.dart';
import '../../widgets/showcase_section.dart';

@RoutePage()
class RadiusShowcasePage extends StatelessWidget {
  const RadiusShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Radius Tokens',
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
              title: 'Radius Scale',
              description: 'Standard border radius values for consistent rounded corners',
              children: AppRadius.values.map((radius) => 
                _buildRadiusDemo(context, radius)).toList(),
            ),
            
            ShowcaseSection(
              title: 'Directional Radius',
              description: 'Border radius applied to specific corners',
              children: [
                _buildDirectionalDemo(context, 'Top Only', AppRadius.lg.topOnly),
                _buildDirectionalDemo(context, 'Bottom Only', AppRadius.lg.bottomOnly),
                _buildDirectionalDemo(context, 'Left Only', AppRadius.lg.leftOnly),
                _buildDirectionalDemo(context, 'Right Only', AppRadius.lg.rightOnly),
                _buildDirectionalDemo(context, 'Top Left', AppRadius.lg.topLeft),
                _buildDirectionalDemo(context, 'Top Right', AppRadius.lg.topRight),
                _buildDirectionalDemo(context, 'Bottom Left', AppRadius.lg.bottomLeft),
                _buildDirectionalDemo(context, 'Bottom Right', AppRadius.lg.bottomRight),
              ],
            ),
            
            ShowcaseSection(
              title: 'Combined Radius',
              description: 'Different radius values for each corner',
              children: [
                _buildCombinedDemo(context, 'Mixed Corners', AppRadius.lg.combine(
                  topLeft: AppRadius.xs,
                  topRight: AppRadius.xl,
                  bottomLeft: AppRadius.xl,
                  bottomRight: AppRadius.xs,
                )),
                _buildCombinedDemo(context, 'Alternating', AppRadius.lg.combine(
                  topLeft: AppRadius.xxl,
                  topRight: AppRadius.none,
                  bottomLeft: AppRadius.none,
                  bottomRight: AppRadius.xxl,
                )),
              ],
            ),
            
            ShowcaseSection(
              title: 'Component Shapes',
              description: 'Radius tokens as shape borders for components',
              children: [
                _buildShapeDemo(context, 'Button Shape', AppRadius.lg.buttonShape),
                _buildShapeDemo(context, 'Card Shape', AppRadius.xl.shapeBorder),
                _buildShapeDemo(context, 'Pill Shape', AppRadius.pill.shapeBorder),
              ],
            ),
            
            ShowcaseSection(
              title: 'Common Use Cases',
              description: 'Typical applications of different radius values',
              children: [
                _buildUseCaseDemo(context, 'Input Field', AppRadius.md, 'Text fields and form inputs'),
                _buildUseCaseDemo(context, 'Button', AppRadius.lg, 'Standard buttons and CTAs'),
                _buildUseCaseDemo(context, 'Card', AppRadius.xl, 'Cards and containers'),
                _buildUseCaseDemo(context, 'Dialog', AppRadius.xxl, 'Modals and dialogs'),
                _buildUseCaseDemo(context, 'Sheet', AppRadius.xxxl, 'Bottom sheets (top corners)'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadiusDemo(BuildContext context, AppRadius radiusEnum) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: InkWell(
        onTap: () => _copyRadiusCode(context, radiusEnum.name, radiusEnum),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              child: Text(
                radiusEnum.name.toUpperCase(),
                style: AppTextStyle.labelMedium.style,
              ),
            ),
            AppSpacing.md.gapH,
            SizedBox(
              width: 60,
              child: Text(
                radiusEnum == AppRadius.pill ? 'Pill' : '${radiusEnum.value.toInt()}px',
                style: AppTextStyle.bodyMedium.style,
              ),
            ),
            AppSpacing.md.gapH,
            Container(
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: radiusEnum.borderRadius,
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                ),
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

  Widget _buildDirectionalDemo(BuildContext context, String name, BorderRadius borderRadius) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: InkWell(
        onTap: () => _copyBorderRadiusCode(context, name, borderRadius),
        child: Row(
          children: [
            SizedBox(
              width: 120,
              child: Text(
                name,
                style: AppTextStyle.labelMedium.style,
              ),
            ),
            AppSpacing.md.gapH,
            Container(
              width: 80,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: borderRadius,
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                ),
              ),
              child: Center(
                child: Text(
                  name.split(' ')[0],
                  style: AppTextStyle.bodySmall.style.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
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

  Widget _buildCombinedDemo(BuildContext context, String name, BorderRadius borderRadius) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: InkWell(
        onTap: () => _copyBorderRadiusCode(context, name, borderRadius),
        child: Row(
          children: [
            SizedBox(
              width: 120,
              child: Text(
                name,
                style: AppTextStyle.labelMedium.style,
              ),
            ),
            AppSpacing.md.gapH,
            Container(
              width: 100,
              height: 60,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                borderRadius: borderRadius,
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                ),
              ),
              child: Center(
                child: Text(
                  name,
                  style: AppTextStyle.bodySmall.style.copyWith(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                  textAlign: TextAlign.center,
                ),
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

  Widget _buildShapeDemo(BuildContext context, String name, ShapeBorder shape) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: InkWell(
        onTap: () => _copyShapeCode(context, name, shape),
        child: Row(
          children: [
            SizedBox(
              width: 120,
              child: Text(
                name,
                style: AppTextStyle.labelMedium.style,
              ),
            ),
            AppSpacing.md.gapH,
            Material(
              shape: shape,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: SizedBox(
                width: 100,
                height: 50,
                child: Center(
                  child: Text(
                    name.split(' ')[0],
                    style: AppTextStyle.bodySmall.style,
                  ),
                ),
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

  Widget _buildUseCaseDemo(BuildContext context, String name, AppRadius radius, String description) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: InkWell(
        onTap: () => _copyRadiusCode(context, name, radius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  name,
                  style: AppTextStyle.labelMedium.style,
                ),
                const Spacer(),
                Text(
                  '${radius.value.toInt()}px',
                  style: AppTextStyle.bodySmall.style.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                AppSpacing.xs.gapH,
                Icon(
                  Icons.copy,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
            AppSpacing.xs.gapV,
            Text(
              description,
              style: AppTextStyle.bodySmall.style.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            AppSpacing.sm.gapV,
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: radius.borderRadius,
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                ),
              ),
              child: Center(
                child: Text(
                  name,
                  style: AppTextStyle.bodyMedium.style,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _copyRadiusCode(BuildContext context, String name, AppRadius radius) {
    final code = 'AppRadius.${radius.name}.borderRadius';
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied $name radius code to clipboard'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _copyBorderRadiusCode(BuildContext context, String name, BorderRadius borderRadius) {
    // This is a simplified representation - in practice you'd inspect the BorderRadius
    final code = 'BorderRadius.circular(${_extractRadiusValue(borderRadius)})';
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied $name border radius code to clipboard'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _copyShapeCode(BuildContext context, String name, ShapeBorder shape) {
    final code = shape.runtimeType.toString();
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied $name shape code to clipboard'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  double _extractRadiusValue(BorderRadius borderRadius) {
    // Simple extraction - get the topLeft radius value
    return borderRadius.topLeft.x;
  }
}