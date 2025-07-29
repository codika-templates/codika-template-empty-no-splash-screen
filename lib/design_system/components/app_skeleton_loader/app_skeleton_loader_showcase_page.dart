import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../playground/widgets/showcase_section.dart';
import '../../tokens/app_colors.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';
import 'app_skeleton_loader.dart';

@RoutePage()
class AppSkeletonLoaderShowcasePage extends StatefulWidget {
  const AppSkeletonLoaderShowcasePage({super.key});

  @override
  State<AppSkeletonLoaderShowcasePage> createState() =>
      _AppSkeletonLoaderShowcasePageState();
}

class _AppSkeletonLoaderShowcasePageState
    extends State<AppSkeletonLoaderShowcasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Skeleton Loader Components',
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
              title: 'Basic Skeleton Elements',
              children: [
                _buildSkeletonExample(
                  'Container Skeleton',
                  AppSkeletonLoader.container(
                    width: double.infinity,
                    height: 40.0,
                  ),
                ),
                _buildSkeletonExample(
                  'Text Line Skeleton',
                  AppSkeletonLoader.text(width: 200.0, height: 16.0),
                ),
                _buildSkeletonExample(
                  'Circle Skeleton',
                  AppSkeletonLoader.circle(diameter: 60.0),
                ),
                _buildSkeletonExample(
                  'Custom Colored Skeleton',
                  AppSkeletonLoader.container(
                    width: double.infinity,
                    height: 30.0,
                    baseColor: AppColors.primary.resolve(context, shade: 50),
                    highlightColor: AppColors.primary.resolve(
                      context,
                      shade: 100,
                    ),
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Pre-built Patterns',
              children: [
                _buildSkeletonExample(
                  'List Item Pattern',
                  AppSkeletonPatterns.listItem(
                    hasAvatar: true,
                    hasSubtitle: true,
                  ),
                ),
                _buildSkeletonExample(
                  'List Item (No Avatar)',
                  AppSkeletonPatterns.listItem(
                    hasAvatar: false,
                    hasSubtitle: true,
                  ),
                ),
                _buildSkeletonExample(
                  'Profile Pattern',
                  AppSkeletonPatterns.profile(),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Card Patterns',
              children: [
                _buildSkeletonExample(
                  'Card with Image',
                  AppSkeletonPatterns.card(hasImage: true, textLines: 2),
                ),
                _buildSkeletonExample(
                  'Card without Image',
                  AppSkeletonPatterns.card(hasImage: false, textLines: 3),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Article Pattern',
              children: [
                _buildSkeletonExample(
                  'Article with Image',
                  AppSkeletonPatterns.article(hasImage: true, paragraphs: 2),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Skeleton Groups',
              children: [
                _buildSkeletonExample(
                  'Multiple Text Lines',
                  AppSkeletonGroup(
                    spacing: 12.0,
                    children: [
                      AppSkeletonLoader.text(
                        width: double.infinity,
                        height: 16.0,
                      ),
                      AppSkeletonLoader.text(
                        width: double.infinity,
                        height: 16.0,
                      ),
                      AppSkeletonLoader.text(width: 150.0, height: 16.0),
                    ],
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Different Sizes',
              children: [
                Card(
                  child: Padding(
                    padding: AppSpacing.lg.padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Text Size Variations',
                          style: AppTextStyle.labelLarge.style,
                        ),
                        AppSpacing.md.gapV,
                        ...[12.0, 16.0, 20.0, 24.0].map((height) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${height.toInt()}px',
                                style: AppTextStyle.labelSmall.style,
                              ),
                              AppSpacing.xs.gapV,
                              AppSkeletonLoader.text(
                                width: 200.0,
                                height: height,
                              ),
                              AppSpacing.md.gapV,
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Circle Size Variations',
              children: [
                Card(
                  child: Padding(
                    padding: AppSpacing.lg.padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Circle Diameters',
                          style: AppTextStyle.labelLarge.style,
                        ),
                        AppSpacing.md.gapV,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [24.0, 40.0, 60.0, 80.0].map((diameter) {
                            return Column(
                              children: [
                                AppSkeletonLoader.circle(diameter: diameter),
                                AppSpacing.sm.gapV,
                                Text(
                                  '${diameter.toInt()}px',
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
              title: 'Real Content Comparison',
              children: [
                Card(
                  child: Padding(
                    padding: AppSpacing.lg.padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Skeleton vs Real Content',
                          style: AppTextStyle.labelLarge.style,
                        ),
                        AppSpacing.md.gapV,
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Skeleton',
                                    style: AppTextStyle.labelMedium.style,
                                  ),
                                  AppSpacing.sm.gapV,
                                  AppSkeletonPatterns.listItem(),
                                ],
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 80,
                              color: Theme.of(context).dividerColor,
                              margin: AppSpacing.md.paddingHorizontal,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Real Content',
                                    style: AppTextStyle.labelMedium.style,
                                  ),
                                  AppSpacing.sm.gapV,
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: AppColors.primary
                                            .resolve(context),
                                        child: const Text('JD'),
                                      ),
                                      AppSpacing.md.gapH,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'John Doe',
                                              style:
                                                  AppTextStyle.bodyMedium.style,
                                            ),
                                            Text(
                                              'Software Developer',
                                              style:
                                                  AppTextStyle.bodySmall.style,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
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

  Widget _buildSkeletonExample(String label, Widget skeleton) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.labelMedium.style),
        AppSpacing.xs.gapV,
        Container(
          width: double.infinity,
          padding: AppSpacing.md.padding,
          decoration: BoxDecoration(
            border: Border.all(
              color: context.borderColor.withValues(alpha: 0.2),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: skeleton,
        ),
        AppSpacing.md.gapV,
      ],
    );
  }
}
