import 'package:flutter/material.dart';

import '../../tokens/app_radius.dart';
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

  /// Icon to display above the title
  final IconData? icon;

  /// Icon color
  final Color? iconColor;

  /// Icon size
  final double? iconSize;

  /// Custom background color
  final Color? backgroundColor;

  const AppDialogConfig({
    this.barrierDismissible = true,
    this.showCloseButton = true,
    this.maxWidth = 600,
    this.maxHeight,
    this.borderRadius,
    this.fullScreenOnMobile = false,
    this.mobileBreakpoint = 600,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.backgroundColor,
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
/// Built with pure Flutter widgets for minimal dependencies
class AppDialog extends StatefulWidget {
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
    Key? key,
    this.title,
    this.header,
    required this.content,
    this.actions,
    this.footer,
    this.config = const AppDialogConfig(),
    this.onClose,
  })  : assert(
          (title != null && header == null) ||
              (title == null && header != null) ||
              (title == null && header == null),
          'Cannot provide both title and header. Use one or the other.',
        ),
        super(key: key);

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
      actions: (primaryAction != null ||
              secondaryAction != null ||
              additionalActions.isNotEmpty)
          ? AppDialogActions(
              primary: primaryAction,
              secondary: secondaryAction,
              additional: additionalActions,
            )
          : null,
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
            : AppButton.primary(
                onPressed: onConfirm,
                child: Text(confirmText),
              ),
        secondary: AppButton.secondary(
          onPressed: onCancel,
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
          onPressed: onAction,
          child: Text(actionText),
        ),
      ),
      config: config,
    );
  }

  /// Factory constructor for icon dialogs
  factory AppDialog.withIcon({
    Key? key,
    required IconData icon,
    required String title,
    required Widget content,
    Widget? primaryAction,
    Widget? secondaryAction,
    Color? iconColor,
    double? iconSize,
    AppDialogConfig? config,
    VoidCallback? onClose,
  }) {
    return AppDialog(
      key: key,
      title: title,
      content: content,
      actions: (primaryAction != null || secondaryAction != null)
          ? AppDialogActions(
              primary: primaryAction,
              secondary: secondaryAction,
            )
          : null,
      config: AppDialogConfig(
        icon: icon,
        iconColor: iconColor,
        iconSize: iconSize,
        barrierDismissible: config?.barrierDismissible ?? true,
        showCloseButton: config?.showCloseButton ?? true,
        maxWidth: config?.maxWidth,
        maxHeight: config?.maxHeight,
        borderRadius: config?.borderRadius,
        fullScreenOnMobile: config?.fullScreenOnMobile ?? false,
        mobileBreakpoint: config?.mobileBreakpoint ?? 600,
        backgroundColor: config?.backgroundColor,
      ),
      onClose: onClose,
    );
  }

  /// Show the dialog
  static Future<T?> show<T>({
    required BuildContext context,
    required AppDialog dialog,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: dialog.config.barrierDismissible,
      builder: (context) => dialog,
    );
  }

  @override
  State<AppDialog> createState() => _AppDialogState();
}

class _AppDialogState extends State<AppDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size;
    final isMobile = screenSize.width < widget.config.mobileBreakpoint;

    // Determine if we should use full screen on mobile
    final useFullScreen = isMobile && widget.config.fullScreenOnMobile;

    if (useFullScreen) {
      return _buildFullScreenDialog(context, theme, isMobile);
    } else {
      return _buildStandardDialog(context, theme, isMobile, screenSize);
    }
  }

  Widget _buildFullScreenDialog(BuildContext context, ThemeData theme, bool isMobile) {
    return Scaffold(
      backgroundColor: widget.config.backgroundColor ?? theme.colorScheme.surface,
      appBar: AppBar(
        title: widget.title != null ? Text(widget.title!) : null,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: widget.config.showCloseButton
            ? AppButton.icon(
                icon: Icons.close,
                onPressed: widget.onClose ?? () => Navigator.of(context).pop(),
                variant: AppButtonVariant.ghost,
                borderRadius: AppRadius.xs,
              )
            : null,
      ),
      body: Column(
        children: [
          if (widget.header != null) widget.header!,
          Expanded(
            child: SingleChildScrollView(
              padding: AppSpacing.lg.padding,
              child: _buildContent(context, theme, isMobile),
            ),
          ),
          if (widget.actions != null || widget.footer != null)
            _buildFooter(context, theme, isMobile),
        ],
      ),
    );
  }

  Widget _buildStandardDialog(BuildContext context, ThemeData theme, bool isMobile, Size screenSize) {
    final radius = widget.config.borderRadius ?? AppRadius.md;
    final shape = AppShape.fromRadius(radius);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(isMobile ? AppSpacing.md.value : AppSpacing.xl.value),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: widget.config.maxWidth ?? (isMobile ? double.infinity : 600),
          maxHeight: widget.config.maxHeight ?? screenSize.height * 0.8,
        ),
        decoration: ShapeDecoration(
          color: widget.config.backgroundColor ?? theme.colorScheme.surface,
          shape: shape.shapeBorder,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context, theme, isMobile),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg.value,
                  vertical: AppSpacing.md.value,
                ),
                child: _buildContent(context, theme, isMobile),
              ),
            ),
            if (widget.actions != null || widget.footer != null)
              _buildFooter(context, theme, isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme, bool isMobile) {
    if (widget.header != null) {
      return widget.header!;
    }

    if (widget.title == null && widget.config.icon == null && !widget.config.showCloseButton) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg.value,
        AppSpacing.lg.value,
        widget.config.showCloseButton ? AppSpacing.md.value : AppSpacing.lg.value,
        AppSpacing.md.value,
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTitleWithIcon(context, theme, isMobile),
          ),
          if (widget.config.showCloseButton)
            AppButton.icon(
              icon: Icons.close,
              onPressed: widget.onClose ?? () => Navigator.of(context).pop(),
              variant: AppButtonVariant.ghost,
              borderRadius: AppRadius.xs,
            ),
        ],
      ),
    );
  }

  Widget _buildTitleWithIcon(BuildContext context, ThemeData theme, bool isMobile) {
    final hasIcon = widget.config.icon != null;
    final hasTitle = widget.title != null;

    if (!hasIcon && !hasTitle) {
      return const SizedBox.shrink();
    }

    // On mobile, stack icon above title (vertical)
    // On desktop, place icon next to title (horizontal)
    if (isMobile && hasIcon) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasIcon)
            Icon(
              widget.config.icon,
              size: widget.config.iconSize ?? 32,
              color: widget.config.iconColor ?? theme.colorScheme.primary,
            ),
          if (hasIcon && hasTitle) AppSpacing.sm.gapV,
          if (hasTitle)
            Text(
              widget.title!,
              style: AppTextStyle.headlineSmall.style.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
        ],
      );
    } else {
      return Row(
        children: [
          if (hasIcon) ...[
            Icon(
              widget.config.icon,
              size: widget.config.iconSize ?? 24,
              color: widget.config.iconColor ?? theme.colorScheme.primary,
            ),
            AppSpacing.md.gapH,
          ],
          if (hasTitle)
            Expanded(
              child: Text(
                widget.title!,
                style: AppTextStyle.headlineSmall.style.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      );
    }
  }

  Widget _buildContent(BuildContext context, ThemeData theme, bool isMobile) {
    return widget.content;
  }

  Widget _buildFooter(BuildContext context, ThemeData theme, bool isMobile) {
    if (widget.footer != null) {
      return Container(
        padding: AppSpacing.md.padding,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: theme.colorScheme.outline.withValues(alpha: 0.12),
              width: 1,
            ),
          ),
        ),
        child: widget.footer!,
      );
    }

    if (widget.actions == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: AppSpacing.md.padding,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.12),
            width: 1,
          ),
        ),
      ),
      child: _buildActions(context, theme, isMobile),
    );
  }

  Widget _buildActions(BuildContext context, ThemeData theme, bool isMobile) {
    final actions = widget.actions!;

    // Collect all action buttons
    final List<Widget> actionButtons = [];

    if (actions.secondary != null) {
      actionButtons.add(actions.secondary!);
    }
    actionButtons.addAll(actions.additional);
    if (actions.primary != null) {
      actionButtons.add(actions.primary!);
    }

    if (actionButtons.isEmpty) return const SizedBox.shrink();

    // Reverse order on mobile if specified
    if (isMobile && actions.reverseOnMobile) {
      actionButtons.reversed.toList();
    }

    return isMobile && actions.stackOnMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: actionButtons
                .map(
                  (button) => Padding(
                    padding: EdgeInsets.only(
                      bottom: button == actionButtons.last ? 0 : AppSpacing.sm.value,
                    ),
                    child: button,
                  ),
                )
                .toList(),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: actionButtons
                .map(
                  (button) => Padding(
                    padding: EdgeInsets.only(
                      left: button == actionButtons.first ? 0 : AppSpacing.sm.value,
                    ),
                    child: button,
                  ),
                )
                .toList(),
          );
  }
}