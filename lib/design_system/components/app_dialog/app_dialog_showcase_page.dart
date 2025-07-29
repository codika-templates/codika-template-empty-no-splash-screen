import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../playground/widgets/showcase_section.dart';
import '../../tokens/app_radius.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';
import '../app_button/app_button.dart';
import 'app_dialog.dart';

@RoutePage()
class DialogShowcasePage extends StatefulWidget {
  const DialogShowcasePage({super.key});

  @override
  State<DialogShowcasePage> createState() => _DialogShowcasePageState();
}

class _DialogShowcasePageState extends State<DialogShowcasePage> {
  bool _isProcessing = false;

  Future<void> _simulateProcess() async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isProcessing = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dialog Components',
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
              title: 'Basic Dialogs',
              description: 'Simple dialogs with different configurations',
              children: [
                _buildDialogButton(
                  'Simple Dialog',
                  'Basic dialog with title and content only',
                  () => _showSimpleDialog(),
                ),
                _buildDialogButton(
                  'Dialog with Actions',
                  'Dialog with primary and secondary actions',
                  () => _showDialogWithActions(),
                ),
                _buildDialogButton(
                  'Dialog with Icon',
                  'Dialog with icon above the title',
                  () => _showIconDialog(),
                ),
                _buildDialogButton(
                  'No Close Button',
                  'Dialog without the close button in header',
                  () => _showDialogWithoutClose(),
                ),
                _buildDialogButton(
                  'Custom Header',
                  'Dialog with custom header widget',
                  () => _showCustomHeaderDialog(),
                ),
              ],
            ),

            ShowcaseSection(
              title: 'Confirmation Dialogs',
              description: 'Pre-configured confirmation dialogs',
              children: [
                _buildDialogButton(
                  'Standard Confirmation',
                  'Typical save/cancel confirmation',
                  () => _showConfirmationDialog(false),
                ),
                _buildDialogButton(
                  'Destructive Confirmation',
                  'Delete/destructive action confirmation',
                  () => _showConfirmationDialog(true),
                ),
                _buildDialogButton(
                  'Alert Dialog',
                  'Simple alert with OK button',
                  () => _showAlertDialog(),
                ),
              ],
            ),

            ShowcaseSection(
              title: 'Content Variations',
              description: 'Dialogs with different content types',
              children: [
                _buildDialogButton(
                  'Long Content',
                  'Dialog with scrollable long content',
                  () => _showLongContentDialog(),
                ),
                _buildDialogButton(
                  'Form Dialog',
                  'Dialog containing form elements',
                  () => _showFormDialog(),
                ),
                _buildDialogButton(
                  'Loading States',
                  'Dialog with loading button states',
                  () => _showLoadingDialog(),
                ),
              ],
            ),

            ShowcaseSection(
              title: 'Styling Variations',
              description: 'Dialogs with different styling options',
              children: [
                _buildDialogButton(
                  'Large Rounded Dialog',
                  'Dialog with larger border radius',
                  () => _showStyledDialog(AppRadius.xl),
                ),
                _buildDialogButton(
                  'Sharp Dialog',
                  'Dialog with minimal border radius',
                  () => _showStyledDialog(AppRadius.xs),
                ),
                _buildDialogButton(
                  'Custom Size Dialog',
                  'Dialog with custom width/height constraints',
                  () => _showCustomSizeDialog(),
                ),
              ],
            ),

            ShowcaseSection(
              title: 'Responsive Behavior',
              description: 'Dialogs demonstrating responsive layout changes',
              children: [
                _buildDialogButton(
                  'Responsive Icon Dialog',
                  'Icon positioned next to title on desktop, above on mobile',
                  () => _showResponsiveIconDialog(),
                ),
                _buildDialogButton(
                  'Mobile Layout Test',
                  'Dialog optimized for mobile with centered title',
                  () => _showMobileLayoutDialog(),
                ),
                _buildDialogButton(
                  'Desktop Layout Test',
                  'Dialog with horizontal icon-title layout',
                  () => _showDesktopLayoutDialog(),
                ),
                _buildDialogButton(
                  'Multiple Actions',
                  'Dialog with multiple action buttons',
                  () => _showMultipleActionsDialog(),
                ),
                _buildDialogButton(
                  'Non-Dismissible',
                  'Dialog that cannot be dismissed by tapping outside',
                  () => _showNonDismissibleDialog(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogButton(
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

  // Basic dialog examples
  void _showSimpleDialog() {
    AppDialog.show(
      context: context,
      dialog: AppDialog(
        title: 'Simple Dialog',
        content: const Text(
          'This is a basic dialog with just a title and content. '
          'You can close it using the close button in the header or by tapping outside.',
        ),
      ),
    );
  }

  void _showDialogWithActions() {
    AppDialog.show(
      context: context,
      dialog: AppDialog(
        title: 'Dialog with Actions',
        content: const Text(
          'This dialog includes both primary and secondary actions in the footer. Notice the improved spacing and the dynamic dividers that appear only when content is scrolled.',
        ),
        actions: AppDialogActions(
          primary: AppButton.primary(
            onPressed: () => Navigator.of(context).pop(),
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

  void _showDialogWithoutClose() {
    AppDialog.show(
      context: context,
      dialog: AppDialog(
        title: 'No Close Button',
        content: const Text(
          'This dialog does not have a close button in the header. '
          'You must use the action buttons or tap outside to close it.',
        ),
        config: const AppDialogConfig(showCloseButton: false),
        actions: AppDialogActions(
          primary: AppButton.primary(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ),
      ),
    );
  }

  void _showIconDialog() {
    AppDialog.show(
      context: context,
      dialog: AppDialog.withIcon(
        icon: Icons.info_outline,
        title: 'Information',
        content: const Text(
          'This dialog displays an icon with responsive positioning. '
          'On desktop/tablet: icon appears next to the title. '
          'On mobile: icon appears above the centered title with proper spacing.',
        ),
        primaryAction: AppButton.primary(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Got it'),
        ),
      ),
    );
  }

  void _showCustomHeaderDialog() {
    AppDialog.show(
      context: context,
      dialog: AppDialog(
        header: Row(
          children: [
            Container(
              padding: EdgeInsets.all(AppSpacing.xs.value),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppRadius.sm.value),
              ),
              child: const Icon(Icons.star, color: Colors.amber, size: 20),
            ),
            AppSpacing.sm.gapH,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Custom Header', style: AppTextStyle.titleMedium.style),
                  Text(
                    'With subtitle and icon',
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
          'This dialog uses a custom header widget with better visual design and proper spacing.',
        ),
        actions: AppDialogActions(
          primary: AppButton.primary(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ),
      ),
    );
  }

  // Confirmation dialog examples
  void _showConfirmationDialog(bool isDestructive) {
    AppDialog.show(
      context: context,
      dialog: AppDialog.withIcon(
        icon: isDestructive ? Icons.warning_amber_outlined : Icons.save_outlined,
        iconColor: isDestructive 
            ? Theme.of(context).colorScheme.error 
            : Theme.of(context).colorScheme.primary,
        title: isDestructive ? 'Delete Item' : 'Save Changes',
        content: Text(
          isDestructive
              ? 'Are you sure you want to delete this item? This action cannot be undone.'
              : 'Do you want to save your changes before closing?',
        ),
        primaryAction: isDestructive
            ? AppButton.destructive(
                onPressed: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Item deleted')),
                  );
                },
                child: const Text('Delete'),
              )
            : AppButton.primary(
                onPressed: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Changes saved')),
                  );
                },
                child: const Text('Save'),
              ),
        secondaryAction: AppButton.secondary(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  void _showAlertDialog() {
    AppDialog.show(
      context: context,
      dialog: AppDialog.withIcon(
        icon: Icons.check_circle_outline,
        iconColor: Colors.green,
        title: 'Success',
        content: const Text(
          'This is an informational alert dialog with improved visual hierarchy. The icon and cleaner spacing make it more engaging.',
        ),
        primaryAction: AppButton.primary(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Got it'),
        ),
      ),
    );
  }

  // Content variation examples
  void _showLongContentDialog() {
    AppDialog.show(
      context: context,
      dialog: AppDialog(
        title: 'Dynamic Scroll Indicators',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(AppSpacing.sm.value),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppRadius.sm.value),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  AppSpacing.xs.gapH,
                  Expanded(
                    child: Text(
                      'Scroll to see the dividers appear/disappear dynamically',
                      style: AppTextStyle.bodySmall.style.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.md.gapV,
            Text(
              'The header and footer dividers only show when content is scrolled:',
              style: AppTextStyle.bodyLarge.style.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            AppSpacing.md.gapV,
            ...List.generate(
              15,
              (index) => Padding(
                padding: AppSpacing.xs.paddingVertical,
                child: Container(
                  padding: EdgeInsets.all(AppSpacing.md.value),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppRadius.sm.value),
                  ),
                  child: Text(
                    'Item ${index + 1}: This demonstrates how the dialog content scrolls smoothly '
                    'while the header and footer remain fixed. The dividers appear dynamically '
                    'to indicate scrollable content.',
                    style: AppTextStyle.bodyMedium.style,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: AppDialogActions(
          primary: AppButton.primary(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ),
      ),
    );
  }

  void _showFormDialog() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();

    AppDialog.show(
      context: context,
      dialog: AppDialog(
        title: 'User Information',
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
        actions: AppDialogActions(
          primary: AppButton.primary(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Information saved')),
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

  void _showLoadingDialog() {
    AppDialog.show(
      context: context,
      dialog: AppDialog(
        title: 'Process Data',
        content: const Text(
          'Click the process button to see the loading state in action.',
        ),
        actions: AppDialogActions(
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

  // Styling variation examples
  void _showStyledDialog(AppRadius radius) {
    AppDialog.show(
      context: context,
      dialog: AppDialog(
        title: 'Styled Dialog',
        content: Text(
          'This dialog uses ${_getRadiusName(radius)} border radius for its shape.',
        ),
        config: AppDialogConfig(borderRadius: radius),
        actions: AppDialogActions(
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

  void _showCustomSizeDialog() {
    AppDialog.show(
      context: context,
      dialog: AppDialog(
        title: 'Custom Size Dialog',
        content: const Text(
          'This dialog has custom maximum width and height constraints.',
        ),
        config: const AppDialogConfig(maxWidth: 400, maxHeight: 300),
        actions: AppDialogActions(
          primary: AppButton.primary(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ),
      ),
    );
  }

  // Responsive behavior examples
  void _showResponsiveIconDialog() {
    AppDialog.show(
      context: context,
      dialog: AppDialog.withIcon(
        icon: Icons.settings,
        title: 'Responsive Icon Dialog',
        content: const Text(
          'This dialog demonstrates responsive icon positioning. '
          'On desktop/tablet, the icon appears next to the title. '
          'On mobile, the icon appears above the centered title. '
          'Resize your browser window to see the layout change.',
        ),
        primaryAction: AppButton.primary(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Got it'),
        ),
        secondaryAction: AppButton.secondary(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  void _showMobileLayoutDialog() {
    AppDialog.show(
      context: context,
      dialog: AppDialog.withIcon(
        icon: Icons.phone_android,
        iconColor: Colors.green,
        title: 'Mobile Optimized',
        content: const Text(
          'This dialog is designed to demonstrate the mobile layout with:\n\n'
          '• Close button in top-right corner\n'
          '• Icon above the centered title\n'
          '• Proper spacing between elements\n'
          '• Squared close button design\n\n'
          'The layout automatically adapts based on screen size.',
        ),
        config: const AppDialogConfig(
          mobileBreakpoint: 800, // Force mobile layout for demo
        ),
        primaryAction: AppButton.primary(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ),
    );
  }

  void _showDesktopLayoutDialog() {
    AppDialog.show(
      context: context,
      dialog: AppDialog.withIcon(
        icon: Icons.computer,
        iconColor: Colors.blue,
        title: 'Desktop Optimized',
        content: const Text(
          'This dialog demonstrates the desktop layout with:\n\n'
          '• Icon positioned next to the title\n'
          '• Horizontal header layout\n'
          '• Close button on the right side\n'
          '• Efficient use of horizontal space\n\n'
          'The layout provides a clean, professional appearance.',
        ),
        config: const AppDialogConfig(
          mobileBreakpoint: 0, // Force desktop layout for demo
        ),
        primaryAction: AppButton.primary(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ),
    );
  }

  void _showMultipleActionsDialog() {
    AppDialog.show(
      context: context,
      dialog: AppDialog(
        title: 'Multiple Actions',
        content: const Text(
          'This dialog has multiple action buttons to demonstrate how they '
          'are laid out on different screen sizes.',
        ),
        actions: AppDialogActions(
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

  void _showNonDismissibleDialog() {
    AppDialog.show(
      context: context,
      dialog: AppDialog(
        title: 'Non-Dismissible Dialog',
        content: const Text(
          'This dialog cannot be dismissed by tapping outside or using the back button. '
          'You must use one of the action buttons to close it.',
        ),
        config: const AppDialogConfig(barrierDismissible: false),
        actions: AppDialogActions(
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
}
