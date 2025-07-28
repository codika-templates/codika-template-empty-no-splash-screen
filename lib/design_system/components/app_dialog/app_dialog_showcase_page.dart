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
              description: 'Dialogs demonstrating responsive layout',
              children: [
                _buildDialogButton(
                  'Mobile Responsive',
                  'Dialog that adapts to mobile screens',
                  () => _showResponsiveDialog(),
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
          'This dialog includes both primary and secondary actions in the footer.',
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

  void _showCustomHeaderDialog() {
    AppDialog.show(
      context: context,
      dialog: AppDialog(
        header: Row(
          children: [
            const Icon(Icons.star, color: Colors.amber),
            AppSpacing.sm.gapH,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Custom Header', style: AppTextStyle.titleLarge.style),
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
          'This dialog uses a custom header widget instead of just a title string.',
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
      dialog: AppDialog.confirmation(
        title: isDestructive ? 'Delete Item' : 'Save Changes',
        content: Text(
          isDestructive
              ? 'Are you sure you want to delete this item? This action cannot be undone.'
              : 'Do you want to save your changes before closing?',
        ),
        confirmText: isDestructive ? 'Delete' : 'Save',
        cancelText: 'Cancel',
        isDestructive: isDestructive,
        onConfirm: () {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(isDestructive ? 'Item deleted' : 'Changes saved'),
            ),
          );
        },
      ),
    );
  }

  void _showAlertDialog() {
    AppDialog.show(
      context: context,
      dialog: AppDialog.alert(
        title: 'Information',
        content: const Text(
          'This is an informational alert dialog. It only has one action button.',
        ),
        actionText: 'Got it',
      ),
    );
  }

  // Content variation examples
  void _showLongContentDialog() {
    AppDialog.show(
      context: context,
      dialog: AppDialog(
        title: 'Long Scrollable Content',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This dialog contains a lot of content that will scroll:',
              style: AppTextStyle.bodyLarge.style,
            ),
            AppSpacing.md.gapV,
            ...List.generate(
              20,
              (index) => Padding(
                padding: AppSpacing.sm.paddingVertical,
                child: Text(
                  'Content line ${index + 1}: This is a long line of text that demonstrates '
                  'how the dialog content scrolls when there is too much content to fit '
                  'in the available space. Only the content area scrolls, while the '
                  'header and footer remain fixed.',
                  style: AppTextStyle.bodyMedium.style,
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
  void _showResponsiveDialog() {
    AppDialog.show(
      context: context,
      dialog: AppDialog(
        title: 'Responsive Dialog',
        content: const Text(
          'This dialog demonstrates responsive behavior. On mobile devices, '
          'the buttons will be stacked vertically and potentially reordered. '
          'Try resizing your browser window or viewing on different devices.',
        ),
        actions: AppDialogActions(
          primary: AppButton.primary(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Primary Action'),
          ),
          secondary: AppButton.secondary(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Secondary'),
          ),
          reverseOnMobile: true,
          stackOnMobile: true,
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
