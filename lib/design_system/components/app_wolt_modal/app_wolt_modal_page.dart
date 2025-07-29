import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';
import '../app_button/app_button.dart';

/// Actions configuration for modal pages
class AppWoltModalPageActions {
  /// Primary action button (typically "Save", "Submit", etc.)
  final Widget? primary;

  /// Secondary action button (typically "Cancel", "Close", etc.)
  final Widget? secondary;

  /// Additional action buttons
  final List<Widget> additional;

  /// Whether to stack buttons vertically on mobile
  final bool stackOnMobile;

  /// Button alignment (end, center, start, spaceBetween, spaceEvenly)
  final MainAxisAlignment alignment;

  const AppWoltModalPageActions({
    this.primary,
    this.secondary,
    this.additional = const [],
    this.stackOnMobile = true,
    this.alignment = MainAxisAlignment.end,
  });
}

/// Extension on WoltModalSheetPage to provide design system integration
class AppWoltModalPage {
  /// Create a standard page with our design system styling
  static WoltModalSheetPage standard({
    required String id,
    String? title,
    Widget? titleWidget,
    required Widget content,
    AppWoltModalPageActions? actions,
    Widget? leadingNavBarWidget,
    Widget? trailingNavBarWidget,
    bool isTopBarLayerAlwaysVisible = false,
    Widget? topBarTitle,
    bool hasTopBarLayer = false,
    Color? backgroundColor,
    bool enableDrag = true,
    VoidCallback? onBackPressed,
    ScrollController? scrollController,
    EdgeInsets? contentPadding,
  }) {
    return WoltModalSheetPage(
      id: id,
      backgroundColor: backgroundColor,
      hasTopBarLayer: hasTopBarLayer,
      topBarTitle: topBarTitle,
      isTopBarLayerAlwaysVisible: isTopBarLayerAlwaysVisible,
      leadingNavBarWidget: leadingNavBarWidget,
      trailingNavBarWidget: trailingNavBarWidget,
      child: _buildPageContent(
        title: title,
        titleWidget: titleWidget,
        content: content,
        actions: actions,
        onBackPressed: onBackPressed,
        contentPadding: contentPadding,
      ),
    );
  }

  /// Create a scrollable page with sliver content
  static SliverWoltModalSheetPage scrollable({
    required String id,
    String? title,
    Widget? titleWidget,
    required List<Widget> slivers,
    AppWoltModalPageActions? actions,
    Widget? leadingNavBarWidget,
    Widget? trailingNavBarWidget,
    bool isTopBarLayerAlwaysVisible = false,
    Widget? topBarTitle,
    bool hasTopBarLayer = false,
    Color? backgroundColor,
    VoidCallback? onBackPressed,
    EdgeInsets? contentPadding,
  }) {
    return SliverWoltModalSheetPage(
      id: id,
      backgroundColor: backgroundColor,
      hasTopBarLayer: hasTopBarLayer,
      topBarTitle: topBarTitle,
      isTopBarLayerAlwaysVisible: isTopBarLayerAlwaysVisible,
      leadingNavBarWidget: leadingNavBarWidget,
      trailingNavBarWidget: trailingNavBarWidget,
      mainContentSliversBuilder: (context) => [
        SliverToBoxAdapter(
          child: _buildPageContent(
            title: title,
            titleWidget: titleWidget,
            content: Column(children: slivers),
            actions: actions,
            onBackPressed: onBackPressed,
            contentPadding: contentPadding,
          ),
        ),
      ],
    );
  }

  /// Create a form page optimized for inputs
  static WoltModalSheetPage form({
    required String id,
    required String title,
    required Widget content,
    Widget? primaryAction,
    Widget? secondaryAction,
    List<Widget> additionalActions = const [],
    VoidCallback? onBackPressed,
    bool showBackButton = false,
    EdgeInsets? contentPadding,
  }) {
    return standard(
      id: id,
      title: title,
      content: content,
      actions: (primaryAction != null || 
                secondaryAction != null || 
                additionalActions.isNotEmpty)
          ? AppWoltModalPageActions(
              primary: primaryAction,
              secondary: secondaryAction,
              additional: additionalActions,
              stackOnMobile: true,
            )
          : null,
      leadingNavBarWidget: showBackButton ? _buildBackButton(onBackPressed) : null,
      enableDrag: false,
      contentPadding: contentPadding,
    );
  }

  /// Create a simple content page
  static WoltModalSheetPage simple({
    required String id,
    required String title,
    required Widget content,
    Widget? primaryAction,
    Widget? secondaryAction,
    VoidCallback? onBackPressed,
    bool showBackButton = false,
    EdgeInsets? contentPadding,
  }) {
    return standard(
      id: id,
      title: title,
      content: content,
      actions: (primaryAction != null || secondaryAction != null)
          ? AppWoltModalPageActions(
              primary: primaryAction,
              secondary: secondaryAction,
            )
          : null,
      leadingNavBarWidget: showBackButton ? _buildBackButton(onBackPressed) : null,
      contentPadding: contentPadding,
    );
  }

  /// Create a confirmation page
  static WoltModalSheetPage confirmation({
    required String id,
    required String title,
    required Widget content,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool isDestructive = false,
    VoidCallback? onBackPressed,
    bool showBackButton = false,
  }) {
    return standard(
      id: id,
      title: title,
      content: content,
      actions: AppWoltModalPageActions(
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
      leadingNavBarWidget: showBackButton ? _buildBackButton(onBackPressed) : null,
      enableDrag: false,
    );
  }

  /// Create a loading page
  static WoltModalSheetPage loading({
    required String id,
    required String title,
    String? subtitle,
    Widget? customLoadingWidget,
    VoidCallback? onCancel,
  }) {
    return standard(
      id: id,
      title: title,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (customLoadingWidget != null) 
            customLoadingWidget
          else ...[
            const CircularProgressIndicator(),
            AppSpacing.lg.gapV,
          ],
          if (subtitle != null) ...[
            Text(
              subtitle,
              style: AppTextStyle.bodyMedium.style,
              textAlign: TextAlign.center,
            ),
            AppSpacing.lg.gapV,
          ],
        ],
      ),
      actions: onCancel != null
          ? AppWoltModalPageActions(
              secondary: AppButton.secondary(
                onPressed: onCancel,
                child: const Text('Cancel'),
              ),
            )
          : null,
      enableDrag: false,
    );
  }

  /// Build the main content structure for a page
  static Widget _buildPageContent({
    String? title,
    Widget? titleWidget,
    required Widget content,
    AppWoltModalPageActions? actions,
    VoidCallback? onBackPressed,
    EdgeInsets? contentPadding,
  }) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        final isMobile = MediaQuery.of(context).size.width < 600;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title section
            if (title != null || titleWidget != null)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg.value,
                  vertical: AppSpacing.md.value,
                ),
                child: titleWidget ??
                    Text(
                      title!,
                      style: AppTextStyle.headlineSmall.style.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                    ),
              ),

            // Content section
            Flexible(
              child: Padding(
                padding: contentPadding ?? 
                    EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg.value,
                      vertical: AppSpacing.md.value,
                    ),
                child: content,
              ),
            ),

            // Actions section
            if (actions != null) _buildActions(context, actions, isMobile),
          ],
        );
      },
    );
  }

  /// Build the actions footer
  static Widget _buildActions(
    BuildContext context,
    AppWoltModalPageActions actions,
    bool isMobile,
  ) {
    final theme = Theme.of(context);

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
      child: isMobile && actions.stackOnMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: actionButtons
                  .map(
                    (button) => Padding(
                      padding: EdgeInsets.only(
                        bottom: button == actionButtons.last
                            ? 0
                            : AppSpacing.sm.value,
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
                        left: button == actionButtons.first
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

  /// Build back button for navigation
  static Widget _buildBackButton(VoidCallback? onPressed) {
    return AppButton.icon(
      icon: Icons.arrow_back,
      onPressed: onPressed,
      variant: AppButtonVariant.ghost,
    );
  }
}