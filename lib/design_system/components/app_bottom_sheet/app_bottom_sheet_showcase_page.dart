import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../playground/widgets/showcase_section.dart';
import '../../tokens/app_radius.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';
import '../app_button/app_button.dart';
import 'app_bottom_sheet.dart';

@RoutePage()
class BottomSheetShowcasePage extends StatefulWidget {
  const BottomSheetShowcasePage({super.key});

  @override
  State<BottomSheetShowcasePage> createState() =>
      _BottomSheetShowcasePageState();
}

class _BottomSheetShowcasePageState extends State<BottomSheetShowcasePage> {
  bool _isProcessing = false;

  Future<void> _simulateProcess() async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BottomSheet Components',
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
              title: 'Basic Bottom Sheets',
              description: 'Simple bottom sheets with different configurations',
              children: [
                _buildBottomSheetButton(
                  'Simple Bottom Sheet',
                  'Basic bottom sheet with title and content',
                  () => _showSimpleBottomSheet(),
                ),
                _buildBottomSheetButton(
                  'Bottom Sheet with Actions',
                  'Bottom sheet with primary and secondary actions',
                  () => _showBottomSheetWithActions(),
                ),
                _buildBottomSheetButton(
                  'No Slide Indicator',
                  'Bottom sheet without drag handle',
                  () => _showBottomSheetNoIndicator(),
                ),
                _buildBottomSheetButton(
                  'With Close Button',
                  'Bottom sheet with close button in header',
                  () => _showBottomSheetWithClose(),
                ),
                _buildBottomSheetButton(
                  'Custom Header',
                  'Bottom sheet with custom header widget',
                  () => _showCustomHeaderBottomSheet(),
                ),
              ],
            ),
            ShowcaseSection(
              title: 'Factory Constructors',
              description: 'Pre-configured bottom sheets for common use cases',
              children: [
                _buildBottomSheetButton(
                  'Scrollable Bottom Sheet',
                  'Full height scrollable bottom sheet',
                  () => _showScrollableBottomSheet(),
                ),
                _buildBottomSheetButton(
                  'Form Bottom Sheet',
                  'Optimized for form inputs with keyboard handling',
                  () => _showFormBottomSheet(),
                ),
                _buildBottomSheetButton(
                  'Menu Bottom Sheet',
                  'List-style menu presentation',
                  () => _showMenuBottomSheet(),
                ),
                _buildBottomSheetButton(
                  'Confirmation Bottom Sheet',
                  'Save/cancel or delete confirmation',
                  () => _showConfirmationBottomSheet(false),
                ),
                _buildBottomSheetButton(
                  'Destructive Confirmation',
                  'Destructive action confirmation',
                  () => _showConfirmationBottomSheet(true),
                ),
              ],
            ),
            ShowcaseSection(
              title: 'Content Variations',
              description: 'Bottom sheets with different content types',
              children: [
                _buildBottomSheetButton(
                  'Long Content',
                  'Bottom sheet with scrollable long content',
                  () => _showLongContentBottomSheet(),
                ),
                _buildBottomSheetButton(
                  'List Content',
                  'Bottom sheet containing list items',
                  () => _showListBottomSheet(),
                ),
                _buildBottomSheetButton(
                  'Loading States',
                  'Bottom sheet with loading button states',
                  () => _showLoadingBottomSheet(),
                ),
                _buildBottomSheetButton(
                  'Empty State',
                  'Bottom sheet with no actions',
                  () => _showEmptyBottomSheet(),
                ),
              ],
            ),
            ShowcaseSection(
              title: 'Styling Variations',
              description: 'Bottom sheets with different styling options',
              children: [
                _buildBottomSheetButton(
                  'Sharp Corners',
                  'Bottom sheet with minimal border radius',
                  () => _showStyledBottomSheet(AppRadius.sm),
                ),
                _buildBottomSheetButton(
                  'Large Rounded',
                  'Bottom sheet with large border radius',
                  () => _showStyledBottomSheet(AppRadius.xl),
                ),
                _buildBottomSheetButton(
                  'Custom Background',
                  'Bottom sheet with custom background color',
                  () => _showCustomBackgroundBottomSheet(),
                ),
                _buildBottomSheetButton(
                  'Fixed Height',
                  'Bottom sheet with custom height constraint',
                  () => _showFixedHeightBottomSheet(),
                ),
              ],
            ),
            ShowcaseSection(
              title: 'Behavioral Variations',
              description: 'Bottom sheets with different behaviors',
              children: [
                _buildBottomSheetButton(
                  'Non-Dismissible',
                  'Bottom sheet that requires action to close',
                  () => _showNonDismissibleBottomSheet(),
                ),
                _buildBottomSheetButton(
                  'No Drag',
                  'Bottom sheet without drag-to-dismiss',
                  () => _showNoDragBottomSheet(),
                ),
                _buildBottomSheetButton(
                  'Persistent Modal',
                  'Persistent bottom sheet presentation',
                  () => _showPersistentBottomSheet(),
                ),
                _buildBottomSheetButton(
                  'Multiple Actions',
                  'Bottom sheet with multiple action buttons',
                  () => _showMultipleActionsBottomSheet(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheetButton(
    String title,
    String description,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyle.labelLarge.style),
                AppSpacing.xs.gapV,
                Text(
                  description,
                  style: AppTextStyle.bodySmall.style.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.md.gapH,
          AppButton.primary(onPressed: onPressed, child: const Text('Show')),
        ],
      ),
    );
  }

  // Basic bottom sheet examples
  void _showSimpleBottomSheet() {
    AppBottomSheet.show(
      context: context,
      bottomSheet: AppBottomSheet(
        title: 'Simple Bottom Sheet',
        content: const Text(
          'This is a basic bottom sheet with just a title and content. '
          'You can close it by swiping down, tapping outside, or using the back gesture.',
        ),
      ),
    );
  }

  void _showBottomSheetWithActions() {
    AppBottomSheet.show(
      context: context,
      bottomSheet: AppBottomSheet(
        title: 'Bottom Sheet with Actions',
        content: const Text(
          'This bottom sheet includes both primary and secondary actions in the footer. '
          'The actions adapt to mobile and desktop layouts automatically.',
        ),
        actions: AppBottomSheetActions(
          primary: AppButton.primary(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Primary action pressed')),
              );
            },
            child: const Text('Save'),
          ),
          secondary: AppButton.secondary(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ),
      ),
    );
  }

  void _showBottomSheetNoIndicator() {
    AppBottomSheet.show(
      context: context,
      bottomSheet: AppBottomSheet(
        title: 'No Slide Indicator',
        content: const Text(
          'This bottom sheet has no slide indicator and drag is disabled. '
          'You must tap outside or use actions to close it.',
        ),
        config: const AppBottomSheetConfig(
          enableDrag: false,
          showSlideIndicator: false,
        ),
        actions: AppBottomSheetActions(
          primary: AppButton.primary(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ),
      ),
    );
  }

  void _showBottomSheetWithClose() {
    AppBottomSheet.show(
      context: context,
      bottomSheet: AppBottomSheet(
        title: 'With Close Button',
        content: const Text(
          'This bottom sheet has a close button in the header for easy dismissal. '
          'The close button uses the app button system for consistency.',
        ),
        config: const AppBottomSheetConfig(showCloseButton: true),
      ),
    );
  }

  void _showCustomHeaderBottomSheet() {
    AppBottomSheet.show(
      context: context,
      bottomSheet: AppBottomSheet(
        header: Row(
          children: [
            Container(
              padding: AppSpacing.xs.padding,
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppRadius.sm.value),
              ),
              child: const Icon(Icons.star, color: Colors.blue, size: 20),
            ),
            AppSpacing.sm.gapH,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Custom Header', style: AppTextStyle.titleMedium.style),
                  Text(
                    'With icon and subtitle',
                    style: AppTextStyle.bodySmall.style.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        content: const Text(
          'This bottom sheet uses a custom header widget with an icon and subtitle. '
          'Custom headers give you full control over the header layout and styling.',
        ),
        config: const AppBottomSheetConfig(showCloseButton: true),
      ),
    );
  }

  // Factory constructor examples
  void _showScrollableBottomSheet() {
    AppBottomSheet.showScrollable(
      context: context,
      bottomSheet: AppBottomSheet.scrollable(
        title: 'Scrollable Bottom Sheet',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This is a full-height scrollable bottom sheet.',
              style: AppTextStyle.bodyLarge.style.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            AppSpacing.md.gapV,
            ...List.generate(
              20,
              (index) => Padding(
                padding: AppSpacing.sm.paddingVertical,
                child: Container(
                  padding: AppSpacing.md.padding,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppRadius.sm.value),
                  ),
                  child: Text(
                    'Scrollable item ${index + 1}: This demonstrates how the content '
                    'scrolls smoothly while maintaining the header and footer positions.',
                    style: AppTextStyle.bodyMedium.style,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: AppBottomSheetActions(
          primary: AppButton.primary(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ),
      ),
    );
  }

  void _showFormBottomSheet() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();

    AppBottomSheet.show(
      context: context,
      bottomSheet: AppBottomSheet.form(
        title: 'Form Bottom Sheet',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please fill in your information:',
              style: AppTextStyle.bodyMedium.style,
            ),
            AppSpacing.lg.gapV,
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            AppSpacing.md.gapV,
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        primaryAction: AppButton.primary(
          onPressed: () {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Form submitted')),
            );
          },
          child: const Text('Submit'),
        ),
        secondaryAction: AppButton.secondary(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  void _showMenuBottomSheet() {
    AppBottomSheet.show(
      context: context,
      bottomSheet: AppBottomSheet.menu(
        title: 'Menu Options',
        content: Column(
          children: [
            _buildMenuOption(Icons.share, 'Share', () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Share selected')),
              );
            }),
            _buildMenuOption(Icons.bookmark, 'Bookmark', () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Bookmarked')),
              );
            }),
            _buildMenuOption(Icons.copy, 'Copy Link', () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Link copied')),
              );
            }),
            _buildMenuOption(Icons.report, 'Report', () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Report submitted')),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOption(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm.value),
      ),
    );
  }

  void _showConfirmationBottomSheet(bool isDestructive) {
    AppBottomSheet.show(
      context: context,
      bottomSheet: AppBottomSheet.confirmation(
        title: isDestructive ? 'Delete Item' : 'Save Changes',
        content: Text(
          isDestructive
              ? 'Are you sure you want to delete this item? This action cannot be undone.'
              : 'Do you want to save your changes before closing?',
        ),
        onConfirm: () {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(isDestructive ? 'Item deleted' : 'Changes saved'),
            ),
          );
        },
        onCancel: () => Navigator.of(context).pop(),
        confirmText: isDestructive ? 'Delete' : 'Save',
        cancelText: 'Cancel',
        isDestructive: isDestructive,
      ),
    );
  }

  // Content variation examples
  void _showLongContentBottomSheet() {
    AppBottomSheet.show(
      context: context,
      bottomSheet: AppBottomSheet(
        title: 'Long Content Bottom Sheet',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: AppSpacing.sm.padding,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppRadius.sm.value),
              ),
              child: Text(
                'This bottom sheet contains a lot of content that requires scrolling.',
                style: AppTextStyle.bodySmall.style.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            AppSpacing.md.gapV,
            ...List.generate(
              10,
              (index) => Padding(
                padding: AppSpacing.xs.paddingVertical,
                child: Text(
                  'Content paragraph ${index + 1}: Lorem ipsum dolor sit amet, '
                  'consectetur adipiscing elit. Sed do eiusmod tempor incididunt '
                  'ut labore et dolore magna aliqua. Ut enim ad minim veniam, '
                  'quis nostrud exercitation ullamco laboris.',
                  style: AppTextStyle.bodyMedium.style,
                ),
              ),
            ),
          ],
        ),
        actions: AppBottomSheetActions(
          primary: AppButton.primary(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ),
      ),
    );
  }

  void _showListBottomSheet() {
    AppBottomSheet.show(
      context: context,
      bottomSheet: AppBottomSheet(
        title: 'List Content',
        content: Column(
          children: List.generate(
            8,
            (index) => ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text('List Item ${index + 1}'),
              subtitle: Text('Description for item ${index + 1}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selected item ${index + 1}')),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showLoadingBottomSheet() {
    AppBottomSheet.show(
      context: context,
      bottomSheet: AppBottomSheet(
        title: 'Process Data',
        content: const Text(
          'Click the process button to see the loading state in action.',
        ),
        actions: AppBottomSheetActions(
          primary: AppButton.primary(
            isLoading: _isProcessing,
            loadingText: 'Processing...',
            onPressed: _isProcessing
                ? null
                : () async {
                    await _simulateProcess();
                    if (mounted) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing completed')),
                      );
                    }
                  },
            child: const Text('Process'),
          ),
          secondary: AppButton.secondary(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ),
      ),
    );
  }

  void _showEmptyBottomSheet() {
    AppBottomSheet.show(
      context: context,
      bottomSheet: AppBottomSheet(
        title: 'Information',
        content: const Text(
          'This bottom sheet has no actions. You can close it by swiping down '
          'or tapping outside.',
        ),
      ),
    );
  }

  // Styling variation examples
  void _showStyledBottomSheet(AppRadius radius) {
    AppBottomSheet.show(
      context: context,
      bottomSheet: AppBottomSheet(
        title: 'Styled Bottom Sheet',
        content: Text(
          'This bottom sheet uses ${_getRadiusName(radius)} border radius for its corners.',
        ),
        config: AppBottomSheetConfig(borderRadius: radius),
        actions: AppBottomSheetActions(
          primary: AppButton.primary(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ),
      ),
    );
  }

  String _getRadiusName(AppRadius radius) {
    switch (radius) {
      case AppRadius.xs:
        return 'extra small';
      case AppRadius.sm:
        return 'small';
      case AppRadius.md:
        return 'medium';
      case AppRadius.lg:
        return 'large';
      case AppRadius.xl:
        return 'extra large';
      case AppRadius.xxl:
        return 'extra x large';
      case AppRadius.xxxl:
        return 'extra xx large';
      case AppRadius.pill:
        return 'pill';
      case AppRadius.none:
        return 'no';
    }
  }

  void _showCustomBackgroundBottomSheet() {
    AppBottomSheet.show(
      context: context,
      bottomSheet: AppBottomSheet(
        title: 'Custom Background',
        content: const Text(
          'This bottom sheet has a custom background color that differs from the theme default.',
        ),
        config: AppBottomSheetConfig(
          backgroundColor: Colors.blue.shade50,
        ),
        actions: AppBottomSheetActions(
          primary: AppButton.primary(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ),
      ),
    );
  }

  void _showFixedHeightBottomSheet() {
    AppBottomSheet.show(
      context: context,
      bottomSheet: AppBottomSheet(
        title: 'Fixed Height',
        content: const Text(
          'This bottom sheet has a fixed maximum height constraint. '
          'Even with more content, it won\'t exceed this height.',
        ),
        config: const AppBottomSheetConfig(maxHeight: 300),
        actions: AppBottomSheetActions(
          primary: AppButton.primary(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ),
      ),
    );
  }

  // Behavioral variation examples
  void _showNonDismissibleBottomSheet() {
    AppBottomSheet.show(
      context: context,
      bottomSheet: AppBottomSheet(
        title: 'Non-Dismissible',
        content: const Text(
          'This bottom sheet cannot be dismissed by tapping outside or swiping. '
          'You must use one of the action buttons to close it.',
        ),
        config: const AppBottomSheetConfig(
          isDismissible: false,
          enableDrag: false,
        ),
        actions: AppBottomSheetActions(
          primary: AppButton.primary(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
          secondary: AppButton.secondary(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ),
      ),
    );
  }

  void _showNoDragBottomSheet() {
    AppBottomSheet.show(
      context: context,
      bottomSheet: AppBottomSheet(
        title: 'No Drag Gesture',
        content: const Text(
          'This bottom sheet disables the drag-to-dismiss gesture but can still be '
          'dismissed by tapping outside.',
        ),
        config: const AppBottomSheetConfig(enableDrag: false),
        actions: AppBottomSheetActions(
          primary: AppButton.primary(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ),
      ),
    );
  }

  void _showPersistentBottomSheet() {
    AppBottomSheet.showPersistent(
      context: context,
      bottomSheet: AppBottomSheet(
        title: 'Persistent Bottom Sheet',
        content: const Text(
          'This is a persistent bottom sheet that cannot be dismissed by any gesture. '
          'It requires explicit action to close.',
        ),
        config: const AppBottomSheetConfig(showCloseButton: true),
        actions: AppBottomSheetActions(
          primary: AppButton.primary(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ),
      ),
    );
  }

  void _showMultipleActionsBottomSheet() {
    AppBottomSheet.show(
      context: context,
      bottomSheet: AppBottomSheet(
        title: 'Multiple Actions',
        content: const Text(
          'This bottom sheet has multiple action buttons to demonstrate how they '
          'are laid out on different screen sizes.',
        ),
        actions: AppBottomSheetActions(
          primary: AppButton.primary(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Save'),
          ),
          secondary: AppButton.secondary(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          additional: [
            AppButton.ghost(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Draft'),
            ),
            AppButton.outline(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Preview'),
            ),
          ],
        ),
      ),
    );
  }
}
