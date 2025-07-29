import 'package:flutter/material.dart';

import '../../tokens/app_radius.dart';
import '../../tokens/app_shapes.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';
import '../app_button/app_button.dart';

/// Configuration for bottom sheet behavior and appearance
class AppBottomSheetConfig {
  /// Whether the bottom sheet can be dismissed by tapping outside or back gesture
  final bool isDismissible;

  /// Whether the bottom sheet supports drag-to-dismiss gesture
  final bool enableDrag;

  /// Whether to show the slide indicator handle (automatically linked to enableDrag)
  final bool? showSlideIndicator;

  /// Whether to show the close button in the header
  final bool showCloseButton;

  /// Whether the bottom sheet should be scroll controlled (full height)
  final bool isScrollControlled;

  /// Maximum height constraint for the bottom sheet
  final double? maxHeight;

  /// Custom border radius for the top corners
  final AppRadius? borderRadius;

  /// Whether to handle bottom safe area padding
  final bool safeAreaBottom;

  /// Custom background color (defaults to theme surface)
  final Color? backgroundColor;

  /// Mobile breakpoint for responsive behavior
  final double mobileBreakpoint;

  const AppBottomSheetConfig({
    this.isDismissible = true,
    this.enableDrag = true,
    this.showSlideIndicator,
    this.showCloseButton = false,
    this.isScrollControlled = true,
    this.maxHeight,
    this.borderRadius,
    this.safeAreaBottom = true,
    this.backgroundColor,
    this.mobileBreakpoint = 600,
  });

  /// Whether to show the slide indicator (computed property)
  bool get effectiveShowSlideIndicator => showSlideIndicator ?? enableDrag;
}

/// Configuration for bottom sheet footer actions
class AppBottomSheetActions {
  /// Primary action button (typically "Save", "Submit", etc.)
  final Widget? primary;

  /// Secondary action button (typically "Cancel", "Close", etc.)
  final Widget? secondary;

  /// Additional action buttons
  final List<Widget> additional;

  /// Whether to stack buttons vertically on mobile
  final bool stackOnMobile;

  /// Button alignment (end, center, start)
  final MainAxisAlignment alignment;

  /// Whether to reverse button order on mobile (primary first on mobile)
  final bool reverseOnMobile;

  const AppBottomSheetActions({
    this.primary,
    this.secondary,
    this.additional = const [],
    this.stackOnMobile = true,
    this.alignment = MainAxisAlignment.end,
    this.reverseOnMobile = true,
  });
}

/// Professional bottom sheet component with header, scrollable content, and responsive footer  
/// Built with pure Flutter widgets for minimal dependencies
class AppBottomSheet extends StatefulWidget {
  /// Bottom sheet title (optional)
  final String? title;

  /// Custom header widget (overrides title if provided)
  final Widget? header;

  /// Main bottom sheet content (scrollable)
  final Widget content;

  /// Footer actions configuration
  final AppBottomSheetActions? actions;

  /// Custom footer widget (overrides actions if provided)
  final Widget? footer;

  /// Bottom sheet configuration
  final AppBottomSheetConfig config;

  /// Custom close callback (called when close button is pressed)
  final VoidCallback? onClose;

  const AppBottomSheet({
    Key? key,
    this.title,
    this.header,
    required this.content,
    this.actions,
    this.footer,
    this.config = const AppBottomSheetConfig(),
    this.onClose,
  })  : assert(
          (title != null && header == null) ||
              (title == null && header != null) ||
              (title == null && header == null),
          'Cannot provide both title and header. Use one or the other.',
        ),
        super(key: key);

  /// Factory constructor for simple bottom sheets with title and content
  factory AppBottomSheet.simple({
    Key? key,
    required String title,
    required Widget content,
    Widget? primaryAction,
    Widget? secondaryAction,
    List<Widget> additionalActions = const [],
    AppBottomSheetConfig config = const AppBottomSheetConfig(),
    VoidCallback? onClose,
  }) {
    return AppBottomSheet(
      key: key,
      title: title,
      content: content,
      actions: (primaryAction != null ||
              secondaryAction != null ||
              additionalActions.isNotEmpty)
          ? AppBottomSheetActions(
              primary: primaryAction,
              secondary: secondaryAction,
              additional: additionalActions,
            )
          : null,
      config: config,
      onClose: onClose,
    );
  }

  /// Factory constructor for scrollable bottom sheets with full height
  factory AppBottomSheet.scrollable({
    Key? key,
    String? title,
    Widget? header,
    required Widget content,
    AppBottomSheetActions? actions,
    Widget? footer,
    VoidCallback? onClose,
    AppBottomSheetConfig? config,
  }) {
    return AppBottomSheet(
      key: key,
      title: title,
      header: header,
      content: content,
      actions: actions,
      footer: footer,
      config: AppBottomSheetConfig(
        isDismissible: config?.isDismissible ?? true,
        enableDrag: config?.enableDrag ?? true,
        showSlideIndicator: config?.showSlideIndicator,
        showCloseButton: config?.showCloseButton ?? false,
        isScrollControlled: true,
        maxHeight: null, // Full height
        borderRadius: config?.borderRadius,
        safeAreaBottom: config?.safeAreaBottom ?? true,
        backgroundColor: config?.backgroundColor,
        mobileBreakpoint: config?.mobileBreakpoint ?? 600,
      ),
      onClose: onClose,
    );
  }

  /// Factory constructor for form bottom sheets with keyboard handling
  factory AppBottomSheet.form({
    Key? key,
    required String title,
    required Widget content,
    Widget? primaryAction,
    Widget? secondaryAction,
    VoidCallback? onClose,
    AppBottomSheetConfig? config,
  }) {
    return AppBottomSheet(
      key: key,
      title: title,
      content: content,
      actions: AppBottomSheetActions(
        primary: primaryAction,
        secondary: secondaryAction,
        stackOnMobile: true,
      ),
      config: AppBottomSheetConfig(
        isDismissible: config?.isDismissible ?? true,
        enableDrag: config?.enableDrag ?? false, // Disable drag for forms
        showSlideIndicator: false, // No indicator for forms
        showCloseButton: config?.showCloseButton ?? true,
        isScrollControlled: true,
        safeAreaBottom: true,
        borderRadius: config?.borderRadius,
        backgroundColor: config?.backgroundColor,
        mobileBreakpoint: config?.mobileBreakpoint ?? 600,
      ),
      onClose: onClose,
    );
  }

  /// Factory constructor for menu-style bottom sheets
  factory AppBottomSheet.menu({
    Key? key,
    String? title,
    required Widget content,
    VoidCallback? onClose,
    AppBottomSheetConfig? config,
  }) {
    return AppBottomSheet(
      key: key,
      title: title,
      content: content,
      config: AppBottomSheetConfig(
        isDismissible: config?.isDismissible ?? true,
        enableDrag: config?.enableDrag ?? true,
        showSlideIndicator: config?.showSlideIndicator,
        showCloseButton: config?.showCloseButton ?? false,
        isScrollControlled: false, // Fit content
        safeAreaBottom: config?.safeAreaBottom ?? true,
        borderRadius: config?.borderRadius,
        backgroundColor: config?.backgroundColor,
        mobileBreakpoint: config?.mobileBreakpoint ?? 600,
      ),
      onClose: onClose,
    );
  }

  /// Factory constructor for confirmation bottom sheets
  factory AppBottomSheet.confirmation({
    Key? key,
    required String title,
    required Widget content,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool isDestructive = false,
    AppBottomSheetConfig? config,
  }) {
    return AppBottomSheet(
      key: key,
      title: title,
      content: content,
      actions: AppBottomSheetActions(
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
        stackOnMobile: true,
      ),
      config: AppBottomSheetConfig(
        isDismissible: config?.isDismissible ?? true,
        enableDrag: config?.enableDrag ?? false,
        showSlideIndicator: false,
        showCloseButton: false, // Actions handle dismissal
        isScrollControlled: false,
        safeAreaBottom: config?.safeAreaBottom ?? true,
        borderRadius: config?.borderRadius,
        backgroundColor: config?.backgroundColor,
        mobileBreakpoint: config?.mobileBreakpoint ?? 600,
      ),
      onClose: onCancel,
    );
  }

  /// Show the bottom sheet
  static Future<T?> show<T>({
    required BuildContext context,
    required AppBottomSheet bottomSheet,
  }) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < bottomSheet.config.mobileBreakpoint;
    
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: bottomSheet.config.isDismissible,
      enableDrag: bottomSheet.config.enableDrag,
      isScrollControlled: bottomSheet.config.isScrollControlled,
      useSafeArea: bottomSheet.config.safeAreaBottom,
      backgroundColor: Colors.transparent,
      constraints: isMobile
          ? (bottomSheet.config.maxHeight != null
              ? BoxConstraints(maxHeight: bottomSheet.config.maxHeight!)
              : null)
          : const BoxConstraints(maxWidth: double.infinity),
      barrierColor: isMobile ? null : Colors.black54,
      builder: (context) => bottomSheet,
    );
  }

  /// Show scrollable bottom sheet that takes full height
  static Future<T?> showScrollable<T>({
    required BuildContext context,
    required AppBottomSheet bottomSheet,
  }) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < bottomSheet.config.mobileBreakpoint;
    
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: bottomSheet.config.isDismissible,
      enableDrag: bottomSheet.config.enableDrag,
      isScrollControlled: true,
      useSafeArea: bottomSheet.config.safeAreaBottom,
      backgroundColor: Colors.transparent,
      constraints: isMobile ? null : const BoxConstraints(maxWidth: double.infinity),
      barrierColor: isMobile ? null : Colors.black54,
      builder: (context) => bottomSheet,
    );
  }

  /// Show persistent bottom sheet that cannot be dismissed
  static Future<T?> showPersistent<T>({
    required BuildContext context,
    required AppBottomSheet bottomSheet,
  }) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < bottomSheet.config.mobileBreakpoint;
    
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: bottomSheet.config.isScrollControlled,
      useSafeArea: bottomSheet.config.safeAreaBottom,
      backgroundColor: Colors.transparent,
      constraints: isMobile
          ? (bottomSheet.config.maxHeight != null
              ? BoxConstraints(maxHeight: bottomSheet.config.maxHeight!)
              : null)
          : const BoxConstraints(maxWidth: double.infinity),
      barrierColor: isMobile ? null : Colors.black54,
      builder: (context) => _AppBottomSheetPersistentWrapper(
        child: bottomSheet,
      ),
    );
  }

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size;
    final isMobile = screenSize.width < widget.config.mobileBreakpoint;
    
    // No border radius on desktop, keep radius on mobile
    final radius = isMobile ? (widget.config.borderRadius ?? AppRadius.lg) : AppRadius.none;
    final shape = AppShape.fromRadius(radius);

    return Container(
      decoration: ShapeDecoration(
        color: widget.config.backgroundColor ?? theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius.value),
            topRight: Radius.circular(radius.value),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDragHandle(context, theme),
          _buildHeader(context, theme),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.lg.value,
                vertical: AppSpacing.md.value,
              ),
              child: _buildContent(context, theme),
            ),
          ),
          if (widget.actions != null || widget.footer != null)
            _buildFooter(context, theme),
          if (widget.config.safeAreaBottom)
            SizedBox(height: mediaQuery.padding.bottom),
        ],
      ),
    );
  }

  Widget _buildDragHandle(BuildContext context, ThemeData theme) {
    if (!widget.config.effectiveShowSlideIndicator) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.only(top: AppSpacing.sm.value),
      child: Container(
        width: 32,
        height: 4,
        decoration: BoxDecoration(
          color: theme.colorScheme.outline.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
    if (widget.header != null) {
      return widget.header!;
    }

    if (widget.title == null && !widget.config.showCloseButton) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg.value,
        widget.config.effectiveShowSlideIndicator 
          ? AppSpacing.md.value 
          : AppSpacing.lg.value,
        widget.config.showCloseButton ? AppSpacing.md.value : AppSpacing.lg.value,
        AppSpacing.md.value,
      ),
      child: Row(
        children: [
          if (widget.title != null)
            Expanded(
              child: Text(
                widget.title!,
                style: AppTextStyle.headlineSmall.style.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
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

  Widget _buildContent(BuildContext context, ThemeData theme) {
    return widget.content;
  }

  Widget _buildFooter(BuildContext context, ThemeData theme) {
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
      child: _buildActions(context, theme),
    );
  }

  Widget _buildActions(BuildContext context, ThemeData theme) {
    final actions = widget.actions!;
    final mediaQuery = MediaQuery.of(context);
    final isMobile = mediaQuery.size.width < widget.config.mobileBreakpoint;

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
            mainAxisAlignment: actions.alignment,
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

/// Wrapper for persistent bottom sheets that forces a close button
class _AppBottomSheetPersistentWrapper extends StatelessWidget {
  final AppBottomSheet child;

  const _AppBottomSheetPersistentWrapper({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Force show close button for persistent sheets
    final modifiedConfig = AppBottomSheetConfig(
      isDismissible: child.config.isDismissible,
      enableDrag: child.config.enableDrag,
      showSlideIndicator: child.config.showSlideIndicator,
      showCloseButton: true, // Force close button
      isScrollControlled: child.config.isScrollControlled,
      maxHeight: child.config.maxHeight,
      borderRadius: child.config.borderRadius,
      safeAreaBottom: child.config.safeAreaBottom,
      backgroundColor: child.config.backgroundColor,
      mobileBreakpoint: child.config.mobileBreakpoint,
    );

    return AppBottomSheet(
      title: child.title,
      header: child.header,
      content: child.content,
      actions: child.actions,
      footer: child.footer,
      config: modifiedConfig,
      onClose: child.onClose,
    );
  }
}