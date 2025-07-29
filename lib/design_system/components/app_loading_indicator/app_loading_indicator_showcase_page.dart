import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../playground/widgets/showcase_section.dart';
import '../../tokens/app_colors.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';
import 'app_loading_indicator.dart';

@RoutePage()
class AppLoadingIndicatorShowcasePage extends StatefulWidget {
  const AppLoadingIndicatorShowcasePage({super.key});

  @override
  State<AppLoadingIndicatorShowcasePage> createState() =>
      _AppLoadingIndicatorShowcasePageState();
}

class _AppLoadingIndicatorShowcasePageState
    extends State<AppLoadingIndicatorShowcasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Loading Indicator Components',
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
              title: 'Circular Indicators',
              children: [
                _buildIndicatorExample(
                  'Default Circular',
                  AppLoadingIndicator.circular(),
                ),
                _buildIndicatorExample(
                  'Large Circular',
                  AppLoadingIndicator.circular(
                    size: AppLoadingIndicatorSize.large,
                  ),
                ),
                _buildIndicatorExample(
                  'Colored Circular',
                  AppLoadingIndicator.circular(
                    size: AppLoadingIndicatorSize.medium,
                    color: AppColors.primary.resolve(context),
                  ),
                ),
                _buildIndicatorExample(
                  'Thick Stroke',
                  AppLoadingIndicator.circular(
                    size: AppLoadingIndicatorSize.large,
                    strokeWidth: 4.0,
                    color: AppColors.success.resolve(context),
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Dots Indicators',
              children: [
                _buildIndicatorExample(
                  'Default Dots',
                  AppLoadingIndicator.dots(),
                ),
                _buildIndicatorExample(
                  'Large Dots',
                  AppLoadingIndicator.dots(
                    size: AppLoadingIndicatorSize.extraLarge,
                  ),
                ),
                _buildIndicatorExample(
                  'Colored Dots',
                  AppLoadingIndicator.dots(
                    size: AppLoadingIndicatorSize.medium,
                    color: AppColors.warning.resolve(context),
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Pulse Indicators',
              children: [
                _buildIndicatorExample(
                  'Default Pulse',
                  AppLoadingIndicator.pulse(),
                ),
                _buildIndicatorExample(
                  'Large Pulse',
                  AppLoadingIndicator.pulse(
                    size: AppLoadingIndicatorSize.extraLarge,
                  ),
                ),
                _buildIndicatorExample(
                  'Colored Pulse',
                  AppLoadingIndicator.pulse(
                    size: AppLoadingIndicatorSize.medium,
                    color: AppColors.error.resolve(context),
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Bars Indicators',
              children: [
                _buildIndicatorExample(
                  'Default Bars',
                  AppLoadingIndicator.bars(),
                ),
                _buildIndicatorExample(
                  'Large Bars',
                  AppLoadingIndicator.bars(
                    size: AppLoadingIndicatorSize.extraLarge,
                  ),
                ),
                _buildIndicatorExample(
                  'Colored Bars',
                  AppLoadingIndicator.bars(
                    size: AppLoadingIndicatorSize.medium,
                    color: AppColors.secondary.resolve(context),
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Size Comparison',
              children: [
                Card(
                  child: Padding(
                    padding: AppSpacing.lg.padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'All Sizes - Circular',
                          style: AppTextStyle.labelLarge.style,
                        ),
                        AppSpacing.md.gapV,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: AppLoadingIndicatorSize.values.map((size) {
                            return Column(
                              children: [
                                AppLoadingIndicator.circular(size: size),
                                AppSpacing.sm.gapV,
                                Text(
                                  size.name,
                                  style: AppTextStyle.labelSmall.style,
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
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
                          'Loading States',
                          style: AppTextStyle.headlineSmall.style,
                        ),
                        AppSpacing.md.gapV,
                        Row(
                          children: [
                            AppLoadingIndicator.circular(
                              size: AppLoadingIndicatorSize.small,
                            ),
                            AppSpacing.md.gapH,
                            Text(
                              'Saving changes...',
                              style: AppTextStyle.bodyMedium.style,
                            ),
                          ],
                        ),
                        AppSpacing.lg.gapV,
                        Center(
                          child: Column(
                            children: [
                              AppLoadingIndicator.dots(
                                size: AppLoadingIndicatorSize.large,
                              ),
                              AppSpacing.md.gapV,
                              Text(
                                'Loading content...',
                                style: AppTextStyle.bodyLarge.style,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicatorExample(String label, Widget indicator) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.labelMedium.style),
        AppSpacing.xs.gapV,
        Container(
          height: 80,
          padding: AppSpacing.md.padding,
          decoration: BoxDecoration(
            border: Border.all(
              color: context.borderColor.withValues(alpha: 0.2),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(child: indicator),
        ),
        AppSpacing.md.gapV,
      ],
    );
  }
}
