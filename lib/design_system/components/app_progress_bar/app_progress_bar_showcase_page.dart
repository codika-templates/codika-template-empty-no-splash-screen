import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../playground/widgets/showcase_section.dart';
import '../../tokens/app_colors.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';
import 'app_progress_bar.dart';

@RoutePage()
class AppProgressBarShowcasePage extends StatefulWidget {
  const AppProgressBarShowcasePage({super.key});

  @override
  State<AppProgressBarShowcasePage> createState() =>
      _AppProgressBarShowcasePageState();
}

class _AppProgressBarShowcasePageState
    extends State<AppProgressBarShowcasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Progress Bar Components',
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
              title: 'Linear Progress Bars',
              children: [
                _buildProgressExample(
                  'Determinate Progress (60%)',
                  AppProgressBar.linear(value: 0.6),
                ),
                _buildProgressExample(
                  'Determinate Progress (90%)',
                  AppProgressBar.linear(
                    value: 0.9,
                    thickness: 6.0,
                    progressColor: AppColors.success.resolve(context),
                  ),
                ),
                _buildProgressExample(
                  'Indeterminate Progress',
                  AppProgressBar.linear(
                    thickness: 4.0,
                    progressColor: AppColors.primary.resolve(context),
                  ),
                ),
                _buildProgressExample(
                  'Thick Progress Bar',
                  AppProgressBar.linear(
                    value: 0.75,
                    thickness: 8.0,
                    progressColor: AppColors.warning.resolve(context),
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Timer Progress Bars',
              children: [
                _buildProgressExample(
                  'Timer Progress (3 seconds)',
                  AppProgressBar.timer(
                    duration: const Duration(seconds: 3),
                    thickness: 6.0,
                    progressColor: AppColors.primary.resolve(context),
                  ),
                ),
                _buildProgressExample(
                  'Timer with Delay',
                  AppProgressBar.timer(
                    duration: const Duration(seconds: 2),
                    delay: const Duration(milliseconds: 500),
                    thickness: 4.0,
                    progressColor: AppColors.secondary.resolve(context),
                  ),
                ),
                _buildProgressExample(
                  'Fast Timer',
                  AppProgressBar.timer(
                    duration: const Duration(seconds: 1),
                    thickness: 8.0,
                    progressColor: AppColors.error.resolve(context),
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Stepped Progress Bars',
              children: [
                _buildProgressExample(
                  'Step 2 of 5',
                  AppProgressBar.stepped(
                    steps: 5,
                    currentStep: 2,
                    thickness: 6.0,
                    progressColor: AppColors.primary.resolve(context),
                  ),
                ),
                _buildProgressExample(
                  'Step 4 of 6',
                  AppProgressBar.stepped(
                    steps: 6,
                    currentStep: 4,
                    thickness: 8.0,
                    progressColor: AppColors.success.resolve(context),
                  ),
                ),
                _buildProgressExample(
                  'Almost Complete (Step 9 of 10)',
                  AppProgressBar.stepped(
                    steps: 10,
                    currentStep: 9,
                    thickness: 4.0,
                    progressColor: AppColors.warning.resolve(context),
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Vertical Progress Bars',
              children: [
                SizedBox(
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Linear (70%)',
                            style: AppTextStyle.labelSmall.style,
                          ),
                          AppSpacing.xs.gapV,
                          Expanded(
                            child: AppProgressBar.linear(
                              orientation: AppProgressBarOrientation.vertical,
                              value: 0.7,
                              thickness: 6.0,
                              progressColor: AppColors.primary.resolve(context),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Timer (2s)',
                            style: AppTextStyle.labelSmall.style,
                          ),
                          AppSpacing.xs.gapV,
                          Expanded(
                            child: AppProgressBar.timer(
                              orientation: AppProgressBarOrientation.vertical,
                              duration: const Duration(seconds: 2),
                              thickness: 6.0,
                              progressColor: AppColors.success.resolve(context),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Steps (3/5)',
                            style: AppTextStyle.labelSmall.style,
                          ),
                          AppSpacing.xs.gapV,
                          Expanded(
                            child: AppProgressBar.stepped(
                              orientation: AppProgressBarOrientation.vertical,
                              steps: 5,
                              currentStep: 3,
                              thickness: 6.0,
                              progressColor: AppColors.secondary.resolve(
                                context,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Different Thickness Examples',
              children: [
                Card(
                  child: Padding(
                    padding: AppSpacing.lg.padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thickness Variations',
                          style: AppTextStyle.labelLarge.style,
                        ),
                        AppSpacing.md.gapV,
                        ...[2.0, 4.0, 6.0, 8.0, 12.0].map((thickness) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${thickness.toInt()}px thick',
                                style: AppTextStyle.labelSmall.style,
                              ),
                              AppSpacing.xs.gapV,
                              AppProgressBar.linear(
                                value: 0.65,
                                thickness: thickness,
                                progressColor: AppColors.primary.resolve(
                                  context,
                                ),
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
              title: 'Usage in Context',
              children: [
                Card(
                  child: Padding(
                    padding: AppSpacing.lg.padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'File Upload Progress',
                          style: AppTextStyle.headlineSmall.style,
                        ),
                        AppSpacing.md.gapV,
                        Row(
                          children: [
                            Expanded(
                              child: AppProgressBar.linear(
                                value: 0.73,
                                thickness: 6.0,
                                progressColor: AppColors.success.resolve(
                                  context,
                                ),
                              ),
                            ),
                            AppSpacing.md.gapH,
                            Text('73%', style: AppTextStyle.labelMedium.style),
                          ],
                        ),
                        AppSpacing.lg.gapV,
                        Text(
                          'Onboarding Steps',
                          style: AppTextStyle.headlineSmall.style,
                        ),
                        AppSpacing.md.gapV,
                        AppProgressBar.stepped(
                          steps: 4,
                          currentStep: 2,
                          thickness: 8.0,
                          progressColor: AppColors.primary.resolve(context),
                        ),
                        AppSpacing.sm.gapV,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:
                              ['Profile', 'Settings', 'Preferences', 'Complete']
                                  .map(
                                    (step) => Text(
                                      step,
                                      style: AppTextStyle.labelSmall.style,
                                    ),
                                  )
                                  .toList(),
                        ),
                        AppSpacing.lg.gapV,
                        Text(
                          'Session Timeout',
                          style: AppTextStyle.headlineSmall.style,
                        ),
                        AppSpacing.md.gapV,
                        AppProgressBar.timer(
                          duration: const Duration(seconds: 5),
                          thickness: 4.0,
                          progressColor: AppColors.error.resolve(context),
                        ),
                        AppSpacing.xs.gapV,
                        Text(
                          'Session expires in 5 seconds',
                          style: AppTextStyle.bodySmall.style.copyWith(
                            color: AppColors.error.resolve(context),
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

  Widget _buildProgressExample(String label, Widget progressBar) {
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
          child: progressBar,
        ),
        AppSpacing.md.gapV,
      ],
    );
  }
}
