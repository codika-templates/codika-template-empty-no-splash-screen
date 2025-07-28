import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../tokens/app_shadows.dart';
import '../../../tokens/app_spacing.dart';
import '../../../tokens/app_typography.dart';
import '../../../tokens/app_radius.dart';
import '../../widgets/showcase_section.dart';

@RoutePage()
class ShadowsShowcasePage extends StatelessWidget {
  const ShadowsShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shadow Tokens',
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
              title: 'Shadow Scale',
              description: 'Standard shadow depths for elevation hierarchy',
              children: AppShadows.values.where((shadow) => shadow != AppShadows.inner)
                  .map((shadow) => _buildShadowDemo(context, shadow)).toList(),
            ),
            
            ShowcaseSection(
              title: 'Inner Shadow',
              description: 'Inset shadow for pressed or recessed elements',
              children: [
                _buildShadowDemo(context, AppShadows.inner),
              ],
            ),
            
            ShowcaseSection(
              title: 'Elevated Shadows',
              description: 'Alternative shadow styles for elevated components',
              children: AppShadows.values.where((shadow) => shadow != AppShadows.none)
                  .map((shadow) => _buildElevatedShadowDemo(context, shadow)).toList(),
            ),
            
            ShowcaseSection(
              title: 'Shadow Presets',
              description: 'Pre-configured shadows for common UI components',
              children: [
                _buildPresetDemo(context, 'Button', AppShadowPresets.button),
                _buildPresetDemo(context, 'Button Hover', AppShadowPresets.buttonHover),
                _buildPresetDemo(context, 'Card', AppShadowPresets.card),
                _buildPresetDemo(context, 'Card Hover', AppShadowPresets.cardHover),
                _buildPresetDemo(context, 'Dialog', AppShadowPresets.dialog),
                _buildPresetDemo(context, 'Dropdown', AppShadowPresets.dropdown),
                _buildPresetDemo(context, 'Tooltip', AppShadowPresets.tooltip),
                _buildPresetDemo(context, 'Overlay', AppShadowPresets.overlay),
              ],
            ),
            
            ShowcaseSection(
              title: 'Colored Shadows',
              description: 'Shadows with custom colors',
              children: [
                _buildColoredShadowDemo(context, 'Primary Shadow', 
                    AppShadows.lg.colored(Theme.of(context).colorScheme.primary)),
                _buildColoredShadowDemo(context, 'Error Shadow', 
                    AppShadows.md.colored(Theme.of(context).colorScheme.error)),
                _buildColoredShadowDemo(context, 'Success Shadow', 
                    AppShadows.md.colored(Colors.green)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShadowDemo(BuildContext context, AppShadows shadowEnum) {
    return Padding(
      padding: AppSpacing.lg.paddingVertical,
      child: InkWell(
        onTap: () => _copyShadowCode(context, shadowEnum.name, shadowEnum.shadows),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  shadowEnum.name.toUpperCase(),
                  style: AppTextStyle.labelMedium.style,
                ),
                const Spacer(),
                Icon(
                  Icons.copy,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
            AppSpacing.sm.gapV,
            Center(
              child: Container(
                width: 120,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: AppRadius.md.borderRadius,
                  boxShadow: shadowEnum.shadows,
                ),
                child: Center(
                  child: Text(
                    shadowEnum.name,
                    style: AppTextStyle.bodyMedium.style,
                  ),
                ),
              ),
            ),
            AppSpacing.sm.gapV,
            Text(
              _getShadowSpecs(shadowEnum.shadows),
              style: AppTextStyle.bodySmall.style.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildElevatedShadowDemo(BuildContext context, AppShadows shadowEnum) {
    return Padding(
      padding: AppSpacing.lg.paddingVertical,
      child: InkWell(
        onTap: () => _copyShadowCode(context, '${shadowEnum.name} Elevated', shadowEnum.elevatedShadows),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${shadowEnum.name.toUpperCase()} ELEVATED',
                  style: AppTextStyle.labelMedium.style,
                ),
                const Spacer(),
                Icon(
                  Icons.copy,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
            AppSpacing.sm.gapV,
            Center(
              child: Container(
                width: 120,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: AppRadius.md.borderRadius,
                  boxShadow: shadowEnum.elevatedShadows,
                ),
                child: Center(
                  child: Text(
                    shadowEnum.name,
                    style: AppTextStyle.bodyMedium.style,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPresetDemo(BuildContext context, String name, List<BoxShadow> shadows) {
    return Padding(
      padding: AppSpacing.lg.paddingVertical,
      child: InkWell(
        onTap: () => _copyShadowCode(context, name, shadows),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  name.toUpperCase(),
                  style: AppTextStyle.labelMedium.style,
                ),
                const Spacer(),
                Icon(
                  Icons.copy,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
            AppSpacing.sm.gapV,
            Center(
              child: Container(
                width: 120,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: AppRadius.md.borderRadius,
                  boxShadow: shadows,
                ),
                child: Center(
                  child: Text(
                    name,
                    style: AppTextStyle.bodySmall.style,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColoredShadowDemo(BuildContext context, String name, List<BoxShadow> shadows) {
    return Padding(
      padding: AppSpacing.lg.paddingVertical,
      child: InkWell(
        onTap: () => _copyShadowCode(context, name, shadows),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  name.toUpperCase(),
                  style: AppTextStyle.labelMedium.style,
                ),
                const Spacer(),
                Icon(
                  Icons.copy,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
            AppSpacing.sm.gapV,
            Center(
              child: Container(
                width: 120,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: AppRadius.md.borderRadius,
                  boxShadow: shadows,
                ),
                child: Center(
                  child: Text(
                    name.split(' ')[0],
                    style: AppTextStyle.bodySmall.style,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getShadowSpecs(List<BoxShadow> shadows) {
    if (shadows.isEmpty) return 'No shadow';
    
    final shadow = shadows.first;
    final offset = shadow.offset;
    return 'X: ${offset.dx.toInt()}, Y: ${offset.dy.toInt()}, Blur: ${shadow.blurRadius.toInt()}, Spread: ${shadow.spreadRadius.toInt()}';
  }

  void _copyShadowCode(BuildContext context, String name, List<BoxShadow> shadows) {
    final shadowCode = shadows.isEmpty 
        ? '[]'
        : shadows.map((shadow) => '''BoxShadow(
  color: ${_colorToString(shadow.color)},
  offset: Offset(${shadow.offset.dx}, ${shadow.offset.dy}),
  blurRadius: ${shadow.blurRadius},
  spreadRadius: ${shadow.spreadRadius},
)''').join(',\n');
    
    final fullCode = shadows.length > 1 
        ? '[\n$shadowCode\n]'
        : '[$shadowCode]';
    
    Clipboard.setData(ClipboardData(text: fullCode));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied $name shadow code to clipboard'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String _colorToString(Color color) {
    if (color == Colors.black.withOpacity(0.05)) return 'Colors.black.withOpacity(0.05)';
    if (color == Colors.black.withOpacity(0.1)) return 'Colors.black.withOpacity(0.1)';
    if (color == Colors.black.withOpacity(0.25)) return 'Colors.black.withOpacity(0.25)';
    return 'Color(0x${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()})';
  }
}