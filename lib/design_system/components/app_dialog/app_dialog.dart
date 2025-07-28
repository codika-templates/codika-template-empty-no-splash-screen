import 'package:flutter/material.dart';

import '../../theme/app_theme_extension.dart';
import '../../tokens/app_radius.dart';
import '../../tokens/app_shadows.dart';
import '../../tokens/app_shapes.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';
import '../app_button/app_button.dart';

/// Configuration for dialog behavior and appearance
class AppDialogConfig {
  /// Whether the dialog can be dismissed by tapping outside
  final bool barrierDismissible;

  /// Whether to show the close button in the header
  final bool showCloseButton;

  /// Maximum width of the dialog
  final double? maxWidth;

  /// Maximum height of the dialog
  final double? maxHeight;

  /// Custom border radius
  final AppRadius? borderRadius;

  /// Whether the dialog should be full screen on mobile
  final bool fullScreenOnMobile;

  /// Breakpoint for mobile layout (below this width uses mobile layout)
  final double mobileBreakpoint;

  const AppDialogConfig({
    this.barrierDismissible = true,
    this.showCloseButton = true,
    this.maxWidth = 600,
    this.maxHeight,
    this.borderRadius,
    this.fullScreenOnMobile = false,
    this.mobileBreakpoint = 600,
  });
}

/// Dialog actions configuration for responsive button layout
class AppDialogActions {
  /// Primary action button (typically "Save", "Submit", etc.)
  final Widget? primary;

  /// Secondary action button (typically "Cancel", "Close", etc.)
  final Widget? secondary;

  /// Additional action buttons
  final List<Widget> additional;

  /// Whether to reverse button order on mobile (primary first on mobile)
  final bool reverseOnMobile;

  /// Whether to stack buttons vertically on mobile
  final bool stackOnMobile;

  const AppDialogActions({
    this.primary,
    this.secondary,
    this.additional = const [],
    this.reverseOnMobile = true,
    this.stackOnMobile = true,
  });
}

/// Professional dialog component with header, scrollable content, and responsive footer
class AppDialog extends StatelessWidget {
  /// Dialog title (optional)
  final String? title;

  /// Custom header widget (overrides title if provided)
  final Widget? header;

  /// Main dialog content (scrollable)
  final Widget content;

  /// Footer actions configuration
  final AppDialogActions? actions;

  /// Custom footer widget (overrides actions if provided)
  final Widget? footer;

  /// Dialog configuration
  final AppDialogConfig config;

  /// Custom close callback (called when close button is pressed)
  final VoidCallback? onClose;

  const AppDialog({
    super.key,
    this.title,
    this.header,
    required this.content,
    this.actions,
    this.footer,
    this.config = const AppDialogConfig(),
    this.onClose,
  }) : assert(
         (title != null && header == null) ||
             (title == null && header != null) ||
             (title == null && header == null),
         'Cannot provide both title and header. Use one or the other.',
       );

  /// Factory constructor for simple dialogs with title and actions
  factory AppDialog.simple({
    Key? key,
    required String title,
    required Widget content,
    Widget? primaryAction,
    Widget? secondaryAction,
    List<Widget> additionalActions = const [],
    AppDialogConfig config = const AppDialogConfig(),
    VoidCallback? onClose,
  }) {
    return AppDialog(
      key: key,
      title: title,
      content: content,
      actions: AppDialogActions(
        primary: primaryAction,
        secondary: secondaryAction,
        additional: additionalActions,
      ),
      config: config,
      onClose: onClose,
    );
  }

  /// Factory constructor for confirmation dialogs
  factory AppDialog.confirmation({
    Key? key,
    required String title,
    required Widget content,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool isDestructive = false,
    AppDialogConfig config = const AppDialogConfig(),
  }) {
    return AppDialog(
      key: key,
      title: title,
      content: content,
      actions: AppDialogActions(
        primary: isDestructive
            ? AppButton.destructive(
                onPressed: onConfirm,
                child: Text(confirmText),
              )
            : AppButton.primary(onPressed: onConfirm, child: Text(confirmText)),
        secondary: AppButton.secondary(
          onPressed: onCancel ?? () => Navigator.of(AppDialog._context!).pop(),
          child: Text(cancelText),
        ),
      ),
      config: config,
      onClose: onCancel,
    );
  }

  /// Factory constructor for alert dialogs
  factory AppDialog.alert({
    Key? key,
    required String title,
    required Widget content,
    String actionText = 'OK',
    VoidCallback? onAction,
    AppDialogConfig config = const AppDialogConfig(),
  }) {
    return AppDialog(
      key: key,
      title: title,
      content: content,
      actions: AppDialogActions(
        primary: AppButton.primary(
          onPressed: onAction ?? () => Navigator.of(AppDialog._context!).pop(),
          child: Text(actionText),
        ),
      ),
      config: config,
    );
  }

  static BuildContext? _context;

  /// Show the dialog
  static Future<T?> show<T>({
    required BuildContext context,
    required AppDialog dialog,
  }) {
    _context = context;
    return showDialog<T>(
      context: context,
      barrierDismissible: dialog.config.barrierDismissible,
      builder: (context) => dialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme = context.appTheme;
    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size;
    final isMobile = screenSize.width < config.mobileBreakpoint;

    // Determine dialog dimensions
    final effectiveMaxWidth =
        config.maxWidth ?? (isMobile ? screenSize.width * 0.95 : 600);
    final effectiveMaxHeight = config.maxHeight ?? screenSize.height * 0.9;

    // Determine shape
    final radius = config.borderRadius ?? appTheme.defaultRadius;
    final AppShape shape = radius == AppRadius.xs
        ? AppShape.xs
        : radius == AppRadius.sm
        ? AppShape.sm
        : radius == AppRadius.md
        ? AppShape.md
        : radius == AppRadius.lg
        ? AppShape.lg
        : radius == AppRadius.xl
        ? AppShape.xl
        : radius == AppRadius.pill
        ? AppShape.pill
        : AppShape.md;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.all(
        isMobile && config.fullScreenOnMobile ? 0 : AppSpacing.lg.value,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: effectiveMaxWidth,
          maxHeight: effectiveMaxHeight,
        ),
        child: Container(
          decoration: ShapeDecoration(
            color: theme.colorScheme.surface,
            shape: shape.shapeBorder,
            shadows: AppShadows.xl.shadows,
          ),
          child: ClipPath(
            clipper: ShapeBorderClipper(shape: shape.shapeBorder),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Section
                if (header != null || title != null || config.showCloseButton)
                  _buildHeader(context, theme, isMobile),

                // Content Section (Scrollable)
                Flexible(child: _buildContent(context, theme)),

                // Footer Section
                if (footer != null || actions != null)
                  _buildFooter(context, theme, isMobile),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme, bool isMobile) {
    return Container(
      padding: AppSpacing.lg.padding,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Header content
          Expanded(
            child:
                header ??
                (title != null
                    ? Text(
                        title!,
                        style: AppTextStyle.headlineSmall.style.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                      )
                    : const SizedBox.shrink()),
          ),

          // Close button
          if (config.showCloseButton)
            AppButton.icon(
              icon: Icons.close,
              onPressed: onClose ?? () => Navigator.of(context).pop(),
              variant: AppButtonVariant.ghost,
              borderRadius: AppRadius.pill,
            ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, ThemeData theme) {
    return SingleChildScrollView(
      padding: AppSpacing.lg.padding,
      child: content,
    );
  }

  Widget _buildFooter(BuildContext context, ThemeData theme, bool isMobile) {
    if (footer != null) {
      return Container(
        padding: AppSpacing.lg.padding,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
        ),
        child: footer!,
      );
    }

    if (actions == null) return const SizedBox.shrink();

    // Collect all action buttons
    final List<Widget> actionButtons = [];

    if (actions!.secondary != null) actionButtons.add(actions!.secondary!);
    actionButtons.addAll(actions!.additional);
    if (actions!.primary != null) actionButtons.add(actions!.primary!);

    // On mobile, potentially reverse order and stack
    List<Widget> orderedButtons = actionButtons;
    if (isMobile && actions!.reverseOnMobile) {
      orderedButtons = actionButtons.reversed.toList();
    }

    return Container(
      padding: AppSpacing.lg.padding,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: isMobile && actions!.stackOnMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: orderedButtons
                  .map(
                    (button) => Padding(
                      padding: EdgeInsets.only(
                        bottom: button == orderedButtons.last
                            ? 0
                            : AppSpacing.sm.value,
                      ),
                      child: button,
                    ),
                  )
                  .toList(),
            )
          : Row(
              mainAxisAlignment: isMobile
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.end,
              children: orderedButtons
                  .map(
                    (button) => Padding(
                      padding: EdgeInsets.only(
                        left: button == orderedButtons.first
                            ? 0
                            : AppSpacing.sm.value,
                      ),
                      child: button,
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
