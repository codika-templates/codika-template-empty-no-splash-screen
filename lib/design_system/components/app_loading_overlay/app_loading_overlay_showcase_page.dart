import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../playground/widgets/showcase_section.dart';
import '../../tokens/app_colors.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';
import '../app_loading_indicator/app_loading_indicator.dart';
import 'app_loading_overlay.dart';

@RoutePage()
class AppLoadingOverlayShowcasePage extends StatefulWidget {
  const AppLoadingOverlayShowcasePage({super.key});

  @override
  State<AppLoadingOverlayShowcasePage> createState() =>
      _AppLoadingOverlayShowcasePageState();
}

class _AppLoadingOverlayShowcasePageState
    extends State<AppLoadingOverlayShowcasePage> {
  bool _isFullScreenLoading = false;
  bool _isModalLoading = false;
  bool _isInlineLoading = false;
  bool _isSavingLoading = false;
  bool _isProcessingLoading = false;
  bool _isGlobalLoading = false;

  void _simulateLoading(Function(bool) setLoading) async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setLoading(false);
  }

  void _simulateGlobalLoading() async {
    setState(() => _isGlobalLoading = true);
    AppGlobalLoadingOverlay.show(
      context: context,
      message: 'Loading global data...',
      loadingIndicator: AppLoadingIndicator.circular(
        size: AppLoadingIndicatorSize.large,
        color: AppColors.primary.resolve(context),
      ),
    );
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      AppGlobalLoadingOverlay.hide();
      setState(() => _isGlobalLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Loading Overlay Components',
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
              title: 'Full Screen Overlay',
              children: [
                _buildOverlayExample(
                  'Full Screen Loading (Active)',
                  AppLoadingOverlay.fullScreen(
                    isLoading: _isFullScreenLoading,
                    message: 'Loading application data...',
                    child: Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.red.shade300,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: _isFullScreenLoading
                              ? null
                              : () => _simulateLoading(
                                  (loading) => setState(
                                    () => _isFullScreenLoading = loading,
                                  ),
                                ),
                          child: Text(
                            _isFullScreenLoading
                                ? 'Loading...'
                                : 'Test Full Screen Loading',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Modal Overlay',
              children: [
                _buildOverlayExample(
                  'Modal Loading (Active)',
                  AppLoadingOverlay.modal(
                    isLoading: _isModalLoading,
                    message: 'Saving changes...',
                    loadingIndicator: AppLoadingIndicator.circular(
                      size: AppLoadingIndicatorSize.medium,
                      color: AppColors.success.resolve(context),
                    ),
                    child: Container(
                      height: 120,
                      width: double.infinity,
                      padding: AppSpacing.md.padding,
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.red.shade300,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Form Area',
                            style: AppTextStyle.headlineSmall.style,
                          ),
                          AppSpacing.sm.gapV,
                          ElevatedButton(
                            onPressed: _isModalLoading
                                ? null
                                : () => _simulateLoading(
                                    (loading) => setState(
                                      () => _isModalLoading = loading,
                                    ),
                                  ),
                            child: Text(
                              _isModalLoading
                                  ? 'Saving...'
                                  : 'Test Modal Loading',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Inline Overlay',
              children: [
                _buildOverlayExample(
                  'Inline Loading (Active)',
                  SizedBox(
                    height: 150,
                    child: AppLoadingOverlay.inline(
                      isLoading: _isInlineLoading,
                      message: 'Loading content...',
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.red.shade300,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image,
                                size: 48,
                                color: Colors.red.shade600,
                              ),
                              AppSpacing.sm.gapV,
                              Text(
                                'Content Area',
                                style: AppTextStyle.bodyMedium.style.copyWith(
                                  color: Colors.red.shade700,
                                ),
                              ),
                              AppSpacing.sm.gapV,
                              ElevatedButton(
                                onPressed: _isInlineLoading
                                    ? null
                                    : () => _simulateLoading(
                                        (loading) => setState(
                                          () => _isInlineLoading = loading,
                                        ),
                                      ),
                                child: Text(
                                  _isInlineLoading
                                      ? 'Loading...'
                                      : 'Test Inline Loading',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Global Overlay',
              children: [
                _buildOverlayExample(
                  'Global Loading (Covers Entire App)',
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade300, width: 2),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Global Overlay Demo',
                            style: AppTextStyle.headlineSmall.style,
                          ),
                          AppSpacing.sm.gapV,
                          ElevatedButton(
                            onPressed: _isGlobalLoading
                                ? null
                                : () => _simulateGlobalLoading(),
                            child: Text(
                              _isGlobalLoading
                                  ? 'Loading Globally...'
                                  : 'Test Global Loading',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Pre-built Presets',
              children: [
                _buildOverlayExample(
                  'Saving Preset (Active)',
                  SizedBox(
                    height: 120,
                    child: AppLoadingOverlayPresets.saving(
                      isLoading: _isSavingLoading,
                      context: context,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.red.shade300,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: _isSavingLoading
                                ? null
                                : () => _simulateLoading(
                                    (loading) => setState(
                                      () => _isSavingLoading = loading,
                                    ),
                                  ),
                            child: Text(
                              _isSavingLoading
                                  ? 'Saving...'
                                  : 'Test Saving Preset',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                _buildOverlayExample(
                  'Processing Preset (Active)',
                  SizedBox(
                    height: 120,
                    child: AppLoadingOverlayPresets.processing(
                      isLoading: _isProcessingLoading,
                      variant: AppLoadingOverlayVariant.inline,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.red.shade300,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: _isProcessingLoading
                                ? null
                                : () => _simulateLoading(
                                    (loading) => setState(
                                      () => _isProcessingLoading = loading,
                                    ),
                                  ),
                            child: Text(
                              _isProcessingLoading
                                  ? 'Processing...'
                                  : 'Test Processing Preset',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            ShowcaseSection(
              title: 'Usage Guidelines',
              children: [
                Card(
                  child: Padding(
                    padding: AppSpacing.lg.padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'When to Use Each Variant',
                          style: AppTextStyle.labelLarge.style,
                        ),
                        AppSpacing.md.gapV,
                        _buildGuidanceItem(
                          'Full Screen',
                          'Use for app-wide loading states, initial data loading, or when the entire interface is unavailable.',
                          Icons.fullscreen,
                          context,
                        ),
                        _buildGuidanceItem(
                          'Modal',
                          'Use for form submissions, saving states, or when you need to clearly communicate a specific action.',
                          Icons.crop_din,
                          context,
                        ),
                        _buildGuidanceItem(
                          'Inline',
                          'Use for specific content areas, widgets, or when loading doesn\'t affect the entire interface.',
                          Icons.view_compact,
                          context,
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

  Widget _buildOverlayExample(String label, Widget overlay) {
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
          child: overlay,
        ),
        AppSpacing.md.gapV,
      ],
    );
  }

  Widget _buildGuidanceItem(
    String title,
    String description,
    IconData icon,
    BuildContext context,
  ) {
    return Padding(
      padding: AppSpacing.md.paddingVertical,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: AppColors.primary.resolve(context)),
          AppSpacing.md.gapH,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.labelMedium.style.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppSpacing.xs.gapV,
                Text(description, style: AppTextStyle.bodySmall.style),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
