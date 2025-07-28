import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'app_button.dart';
import '../../../tokens/app_spacing.dart';
import '../../../tokens/app_typography.dart';
import '../../../tokens/app_radius.dart';
import '../../../tokens/app_density.dart';
import '../../playground/widgets/showcase_section.dart';

@RoutePage()
class ButtonShowcasePage extends StatelessWidget {
  const ButtonShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Button Components',
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
              title: 'Button Variants',
              description: 'Different styles of buttons for various use cases',
              children: [
                _buildVariantRow('Primary', () => AppButton.primary(child: const Text('Primary'), onPressed: () {})),
                _buildVariantRow('Secondary', () => AppButton.secondary(child: const Text('Secondary'), onPressed: () {})),
                _buildVariantRow('Ghost', () => AppButton.ghost(child: const Text('Ghost'), onPressed: () {})),
                _buildVariantRow('Outline', () => AppButton.outline(child: const Text('Outline'), onPressed: () {})),
                _buildVariantRow('Destructive', () => AppButton.destructive(child: const Text('Destructive'), onPressed: () {})),
                _buildVariantRow('Link', () => AppButton.link(child: const Text('Link'), onPressed: () {})),
              ],
            ),
            
            ShowcaseSection(
              title: 'Button Sizes',
              description: 'Buttons available in different sizes',
              children: [
                _buildSizeRow('Small', AppButtonSize.sm),
                _buildSizeRow('Medium', AppButtonSize.md),
                _buildSizeRow('Large', AppButtonSize.lg),
                _buildSizeRow('Compact', AppButtonSize.compact),
                _buildIconButtonRow('Icon (Square)', AppButtonSize.icon),
              ],
            ),
            
            ShowcaseSection(
              title: 'Button States',
              description: 'Different states and configurations',
              children: [
                _buildStateRow('Default', () => AppButton.primary(child: const Text('Default'), onPressed: () {})),
                _buildStateRow('Disabled', () => AppButton.primary(child: const Text('Disabled'), onPressed: null)),
                _buildStateRow('Loading', () => AppButton.primary(child: const Text('Loading'), isLoading: true, onPressed: () {})),
                _buildStateRow('Full Width', () => AppButton.primary(child: const Text('Full Width'), fullWidth: true, onPressed: () {})),
              ],
            ),
            
            ShowcaseSection(
              title: 'Buttons with Icons',
              description: 'Buttons with leading and trailing icons',
              children: [
                _buildIconRow('Leading Icon', () => AppButton.primary(
                  child: const Text('Leading'),
                  icon: Icons.star,
                  onPressed: () {},
                )),
                _buildIconRow('Trailing Icon', () => AppButton.primary(
                  child: const Text('Trailing'),
                  trailingIcon: Icons.arrow_forward,
                  onPressed: () {},
                )),
                _buildIconRow('Both Icons', () => AppButton.primary(
                  child: const Text('Both'),
                  icon: Icons.star,
                  trailingIcon: Icons.arrow_forward,
                  onPressed: () {},
                )),
                _buildIconRow('Icon Only', () => AppButton.primary(
                  child: const Text(''),
                  size: AppButtonSize.icon,
                  icon: Icons.favorite,
                  onPressed: () {},
                )),
              ],
            ),
            
            ShowcaseSection(
              title: 'Icon Buttons',
              description: 'Square and rounded icon buttons in different variants',
              children: [
                _buildSpecializedRow('Square Primary', () => AppButton.icon(
                  icon: Icons.favorite,
                  onPressed: () {},
                  variant: AppButtonVariant.primary,
                )),
                _buildSpecializedRow('Square Secondary', () => AppButton.icon(
                  icon: Icons.settings,
                  onPressed: () {},
                  variant: AppButtonVariant.secondary,
                )),
                _buildSpecializedRow('Square Outline', () => AppButton.icon(
                  icon: Icons.edit,
                  onPressed: () {},
                  variant: AppButtonVariant.outline,
                )),
                _buildSpecializedRow('Rounded Primary', () => AppButton.iconRounded(
                  icon: Icons.add,
                  onPressed: () {},
                  variant: AppButtonVariant.primary,
                )),
                _buildSpecializedRow('Rounded Ghost', () => AppButton.iconRounded(
                  icon: Icons.close,
                  onPressed: () {},
                  variant: AppButtonVariant.ghost,
                )),
                _buildSpecializedRow('Rounded Destructive', () => AppButton.iconRounded(
                  icon: Icons.delete,
                  onPressed: () {},
                  variant: AppButtonVariant.destructive,
                )),
              ],
            ),
            
            ShowcaseSection(
              title: 'Compact Buttons',
              description: 'Small buttons for badges, labels, and status indicators',
              children: [
                _buildSpecializedRow('Badge', () => AppButton.compact(
                  child: const Text('NEW'),
                  onPressed: () {},
                  variant: AppButtonVariant.secondary,
                )),
                _buildSpecializedRow('Status Label', () => AppButton.compact(
                  child: const Text('Active'),
                  onPressed: () {},
                  variant: AppButtonVariant.ghost,
                  icon: Icons.circle,
                )),
                _buildSpecializedRow('Count Badge', () => AppButton.compact(
                  child: const Text('3'),
                  onPressed: () {},
                  variant: AppButtonVariant.primary,
                )),
              ],
            ),
            
            ShowcaseSection(
              title: 'Custom Properties',
              description: 'Buttons with custom properties',
              children: [
                _buildCustomRow('Custom Radius', () => AppButton.primary(
                  child: const Text('Rounded'),
                  borderRadius: AppRadius.xl,
                  onPressed: () {},
                )),
                _buildCustomRow('Compact Density', () => AppButton.primary(
                  child: const Text('Compact'),
                  density: AppDensity.compact,
                  onPressed: () {},
                )),
                _buildCustomRow('Comfortable Density', () => AppButton.primary(
                  child: const Text('Comfortable'),
                  density: AppDensity.comfortable,
                  onPressed: () {},
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVariantRow(String label, AppButton Function() buttonBuilder) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTextStyle.labelMedium.style,
            ),
          ),
          AppSpacing.md.gapH,
          buttonBuilder(),
          const Spacer(),
          buttonBuilder().onPressed == null 
              ? Text('Disabled', style: AppTextStyle.bodySmall.style)
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildSizeRow(String label, AppButtonSize size) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTextStyle.labelMedium.style,
            ),
          ),
          AppSpacing.md.gapH,
          AppButton.primary(
            child: Text(label),
            size: size,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildIconButtonRow(String label, AppButtonSize size) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTextStyle.labelMedium.style,
            ),
          ),
          AppSpacing.md.gapH,
          AppButton.icon(
            icon: Icons.star,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildStateRow(String label, AppButton Function() buttonBuilder) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyle.labelMedium.style,
          ),
          AppSpacing.xs.gapV,
          buttonBuilder(),
        ],
      ),
    );
  }

  Widget _buildIconRow(String label, AppButton Function() buttonBuilder) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: AppTextStyle.labelMedium.style,
            ),
          ),
          AppSpacing.md.gapH,
          buttonBuilder(),
        ],
      ),
    );
  }

  Widget _buildSpecializedRow(String label, AppButton Function() buttonBuilder) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: AppTextStyle.labelMedium.style,
            ),
          ),
          AppSpacing.md.gapH,
          buttonBuilder(),
        ],
      ),
    );
  }

  Widget _buildCustomRow(String label, AppButton Function() buttonBuilder) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: AppTextStyle.labelMedium.style,
            ),
          ),
          AppSpacing.md.gapH,
          buttonBuilder(),
        ],
      ),
    );
  }
}