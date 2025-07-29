import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../playground/widgets/showcase_section.dart';
import '../../tokens/app_colors.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';
import 'app_divider.dart';

@RoutePage()
class AppDividerShowcasePage extends StatefulWidget {
  const AppDividerShowcasePage({super.key});

  @override
  State<AppDividerShowcasePage> createState() => _AppDividerShowcasePageState();
}

class _AppDividerShowcasePageState extends State<AppDividerShowcasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Divider Components',
          style: AppTextStyle.headlineMedium.style,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.lg.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShowcaseSection(
              title: 'Solid Dividers',
              children: [
                _buildDividerExample('Basic Solid', AppDivider.solid()),
                _buildDividerExample(
                  'Thick Solid',
                  AppDivider.solid(
                    thickness: 2.0,
                    color: AppColors.primary.resolve(context),
                  ),
                ),
                _buildDividerExample(
                  'With Indents',
                  AppDivider.solid(thickness: 1.0, indent: 20, endIndent: 20),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Gradient Dividers',
              children: [
                _buildDividerExample('Basic Gradient', AppDivider.gradient()),
                _buildDividerExample(
                  'Subtle Gradient',
                  AppDivider.gradient(
                    gradientFadeRatio: 0.1,
                    color: AppColors.primary.resolve(context),
                  ),
                ),
                _buildDividerExample(
                  'Heavy Gradient',
                  AppDivider.gradient(
                    thickness: 2.0,
                    gradientFadeRatio: 0.7,
                    color: AppColors.secondary.resolve(context),
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Text Dividers',
              children: [
                _buildDividerExample(
                  'Simple Text',
                  AppDivider.text(text: 'OR'),
                ),
                _buildDividerExample(
                  'Custom Styled Text',
                  AppDivider.text(
                    text: 'SECTION BREAK',
                    color: AppColors.primary.resolve(context),
                    textStyle: AppTextStyle.labelSmall.style.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                _buildDividerExample(
                  'Long Text',
                  AppDivider.text(
                    text: 'Additional Information Below',
                    thickness: 1.5,
                    color: AppColors.secondary.resolve(context),
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Icon Dividers',
              children: [
                _buildDividerExample(
                  'Star Icon',
                  AppDivider.icon(
                    icon: Icons.star,
                    color: AppColors.warning.resolve(context),
                  ),
                ),
                _buildDividerExample(
                  'Diamond Icon',
                  AppDivider.icon(
                    icon: Icons.diamond,
                    thickness: 1.5,
                    color: AppColors.success.resolve(context),
                  ),
                ),
                _buildDividerExample(
                  'Custom Size',
                  AppDivider.icon(
                    icon: Icons.fiber_manual_record,
                    iconSize: 12,
                    color: AppColors.primary.resolve(context),
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Dotted Dividers',
              children: [
                _buildDividerExample('Basic Dotted', AppDivider.dotted()),
                _buildDividerExample(
                  'Thick Dotted',
                  AppDivider.dotted(
                    thickness: 3.0,
                    color: AppColors.primary.resolve(context),
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Dashed Dividers',
              children: [
                _buildDividerExample('Basic Dashed', AppDivider.dashed()),
                _buildDividerExample(
                  'Thick Dashed',
                  AppDivider.dashed(
                    thickness: 2.5,
                    color: AppColors.secondary.resolve(context),
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Vertical Dividers',
              children: [
                SizedBox(
                  height: 100,
                  child: Row(
                    children: [
                      Expanded(child: Container(color: Colors.grey[100])),
                      AppDivider.solid(
                        orientation: AppDividerOrientation.vertical,
                        thickness: 1.5,
                        color: AppColors.primary.resolve(context),
                      ),
                      Expanded(child: Container(color: Colors.grey[100])),
                      AppDivider.gradient(
                        orientation: AppDividerOrientation.vertical,
                        thickness: 1.5,
                        color: AppColors.secondary.resolve(context),
                      ),
                      Expanded(child: Container(color: Colors.grey[100])),
                      AppDivider.dotted(
                        orientation: AppDividerOrientation.vertical,
                        thickness: 1.5,
                        color: AppColors.warning.resolve(context),
                      ),
                      Expanded(child: Container(color: Colors.grey[100])),
                    ],
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Usage in Context',
              children: [
                Card(
                  child: Padding(
                    padding: AppSpacing.lg.padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User Profile',
                          style: AppTextStyle.headlineSmall.style,
                        ),
                        Text(
                          'Basic information about the user',
                          style: AppTextStyle.bodyMedium.style,
                        ),
                        AppSpacing.md.gapV,
                        AppDivider.gradient(
                          thickness: 1.0,
                          gradientFadeRatio: 0.2,
                        ),
                        AppSpacing.md.gapV,
                        Text(
                          'Settings',
                          style: AppTextStyle.headlineSmall.style,
                        ),
                        Text(
                          'Configure your preferences',
                          style: AppTextStyle.bodyMedium.style,
                        ),
                        AppSpacing.md.gapV,
                        AppDivider.text(
                          text: 'Advanced Options',
                          thickness: 1.0,
                          gradientFadeRatio: 0.3,
                        ),
                        AppSpacing.md.gapV,
                        Text(
                          'Advanced configuration options',
                          style: AppTextStyle.bodyMedium.style,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Different Backgrounds',
              children: [
                Container(
                  padding: AppSpacing.lg.padding,
                  decoration: BoxDecoration(
                    color: AppColors.primary.resolve(context, shade: 50),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Light Background',
                        style: AppTextStyle.labelLarge.style,
                      ),
                      AppSpacing.md.gapV,
                      AppDivider.gradient(thickness: 2, gradientFadeRatio: 0.2),
                      AppSpacing.md.gapV,
                      AppDivider.text(text: 'SEPARATOR', thickness: 1),
                    ],
                  ),
                ),
                AppSpacing.md.gapV,
                Container(
                  padding: AppSpacing.lg.padding,
                  decoration: BoxDecoration(
                    color: AppColors.neutral.resolve(context, shade: 800),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Dark Background',
                        style: AppTextStyle.labelLarge.style.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      AppSpacing.md.gapV,
                      AppDivider.gradient(
                        thickness: 2,
                        gradientFadeRatio: 0.2,
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                      AppSpacing.md.gapV,
                      AppDivider.text(
                        text: 'SEPARATOR',
                        thickness: 1,
                        color: Colors.white.withValues(alpha: 0.7),
                        textStyle: AppTextStyle.labelSmall.style.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDividerExample(String label, Widget divider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.labelMedium.style),
        AppSpacing.xs.gapV,
        Container(
          padding: AppSpacing.md.padding,
          decoration: BoxDecoration(
            border: Border.all(
              color: context.borderColor.withValues(alpha: 0.2),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: divider,
        ),
        AppSpacing.md.gapV,
      ],
    );
  }
}
