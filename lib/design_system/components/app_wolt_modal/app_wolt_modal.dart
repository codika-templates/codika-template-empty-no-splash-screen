import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../theme/app_theme_extension.dart';
import '../../tokens/app_radius.dart';
import '../../tokens/app_shapes.dart';
import 'app_wolt_modal_config.dart';
import 'app_wolt_modal_page.dart';

/// Professional modal component that adapts between dialog and bottom sheet
/// based on screen size, built on top of Wolt Modal Sheet
class AppWoltModal {
  /// Show a single-page modal with adaptive behavior
  static Future<T?> show<T>({
    required BuildContext context,
    required WoltModalSheetPage page,
    AppWoltModalConfig config = const AppWoltModalConfig(),
    ValueNotifier<int>? pageIndexNotifier,
  }) {
    return _showModal<T>(
      context: context,
      pages: [page],
      config: config,
      pageIndexNotifier: pageIndexNotifier,
    );
  }

  /// Show a multi-page modal with navigation support
  static Future<T?> showPages<T>({
    required BuildContext context,
    required List<WoltModalSheetPage> pages,
    AppWoltModalConfig config = const AppWoltModalConfig(),
    ValueNotifier<int>? pageIndexNotifier,
    int initialPageIndex = 0,
  }) {
    return _showModal<T>(
      context: context,
      pages: pages,
      config: config,
      pageIndexNotifier: pageIndexNotifier,
      initialPageIndex: initialPageIndex,
    );
  }

  /// Show a simple dialog/bottom sheet with title and content
  static Future<T?> simple<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    Widget? primaryAction,
    Widget? secondaryAction,
    List<Widget> additionalActions = const [],
    AppWoltModalConfig config = const AppWoltModalConfig(),
  }) {
    final page = AppWoltModalPage.simple(
      id: 'simple_modal',
      title: title,
      content: content,
      primaryAction: primaryAction,
      secondaryAction: secondaryAction,
    );

    return show<T>(
      context: context,
      page: page,
      config: config,
    );
  }

  /// Show a form modal optimized for input collection
  static Future<T?> form<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    Widget? primaryAction,
    Widget? secondaryAction,
    List<Widget> additionalActions = const [],
    AppWoltModalConfig? config,
  }) {
    final page = AppWoltModalPage.form(
      id: 'form_modal',
      title: title,
      content: content,
      primaryAction: primaryAction,
      secondaryAction: secondaryAction,
      additionalActions: additionalActions,
    );

    return show<T>(
      context: context,
      page: page,
      config: config ?? AppWoltModalConfig.form,
    );
  }

  /// Show a confirmation modal
  static Future<T?> confirmation<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool isDestructive = false,
    AppWoltModalConfig? config,
  }) {
    final page = AppWoltModalPage.confirmation(
      id: 'confirmation_modal',
      title: title,
      content: content,
      onConfirm: onConfirm,
      onCancel: onCancel ?? () => Navigator.of(context).pop(),
      confirmText: confirmText,
      cancelText: cancelText,
      isDestructive: isDestructive,
    );

    return show<T>(
      context: context,
      page: page,
      config: config ?? AppWoltModalConfig.dialog,
    );
  }

  /// Show a loading modal
  static Future<T?> loading<T>({
    required BuildContext context,
    required String title,
    String? subtitle,
    Widget? customLoadingWidget,
    VoidCallback? onCancel,
    AppWoltModalConfig? config,
  }) {
    final page = AppWoltModalPage.loading(
      id: 'loading_modal',
      title: title,
      subtitle: subtitle,
      customLoadingWidget: customLoadingWidget,
      onCancel: onCancel,
    );

    return show<T>(
      context: context,
      page: page,
      config: config ?? AppWoltModalConfig.persistent,
    );
  }

  /// Show a multi-step workflow modal
  static Future<T?> workflow<T>({
    required BuildContext context,
    required List<WoltModalSheetPage> pages,
    AppWoltModalConfig? config,
    ValueNotifier<int>? pageIndexNotifier,
  }) {
    return showPages<T>(
      context: context,
      pages: pages,
      config: config ?? const AppWoltModalConfig(),
      pageIndexNotifier: pageIndexNotifier,
    );
  }

  /// Internal method to show the modal with Wolt Modal Sheet
  static Future<T?> _showModal<T>({
    required BuildContext context,
    required List<WoltModalSheetPage> pages,
    required AppWoltModalConfig config,
    ValueNotifier<int>? pageIndexNotifier,
    int initialPageIndex = 0,
  }) {
    final theme = Theme.of(context);
    final appTheme = context.appTheme;
    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size;

    // Determine shape
    final radius = config.borderRadius ?? appTheme.defaultRadius;
    final AppShape shape = _mapRadiusToShape(radius);

    return WoltModalSheet.show<T>(
      context: context,
      pageIndexNotifier: pageIndexNotifier ??= ValueNotifier(initialPageIndex),
      pageListBuilder: (context) => pages,
      modalTypeBuilder: config.modalType != null 
        ? (context) => config.modalType!
        : (context) {
            if (screenSize.width >= config.mobileBreakpoint) {
              return WoltModalType.dialog();
            } else {
              return WoltModalType.bottomSheet();
            }
          },
      barrierDismissible: config.barrierDismissible,
      enableDrag: config.enableDrag,
      useSafeArea: config.useSafeArea,
      modalDecorator: (child) => _buildModalDecorator(
        child: child,
        theme: theme,
        appTheme: appTheme,
        shape: shape,
        config: config,
      ),
    );
  }

  /// Build the modal decorator that applies our design system styling
  static Widget _buildModalDecorator({
    required Widget child,
    required ThemeData theme,
    required AppThemeExtension appTheme,
    required AppShape shape,
    required AppWoltModalConfig config,
  }) {
    return Container(
      decoration: ShapeDecoration(
        color: config.backgroundColor ?? theme.colorScheme.surface,
        shape: shape.shapeBorder,
      ),
      child: ClipPath(
        clipper: ShapeBorderClipper(shape: shape.shapeBorder),
        child: child,
      ),
    );
  }

  /// Map AppRadius to AppShape
  static AppShape _mapRadiusToShape(AppRadius radius) {
    switch (radius) {
      case AppRadius.none:
        return AppShape.none;
      case AppRadius.xs:
        return AppShape.xs;
      case AppRadius.sm:
        return AppShape.sm;
      case AppRadius.md:
        return AppShape.md;
      case AppRadius.lg:
        return AppShape.lg;
      case AppRadius.xl:
        return AppShape.xl;
      case AppRadius.xxl:
      case AppRadius.xxxl:
        return AppShape.xl; // Map to largest available
      case AppRadius.pill:
        return AppShape.pill;
    }
  }

  /// Helper methods for navigation within modals
  
  /// Show next page in multi-page modal
  static void showNext(BuildContext context) {
    WoltModalSheet.of(context).showNext();
  }

  /// Show previous page in multi-page modal
  static void showPrevious(BuildContext context) {
    WoltModalSheet.of(context).showPrevious();
  }

  /// Show specific page by index (basic implementation - may need adjustment based on actual API)
  static void showAtIndex(BuildContext context, int index) {
    // Basic implementation - actual API may vary for 0.11.0
    // This method may need to be adjusted based on the actual API
    // For now just using the basic navigation methods
  }

  /// Add a new page to the modal (simplified implementation)
  static void addPage(
    BuildContext context,
    WoltModalSheetPage page, {
    bool showPage = true,
  }) {
    // Basic implementation - actual API may vary
    // This method may need to be adjusted based on the actual 0.11.0 API
    // For now, just commenting out the unsupported method calls
  }

  /// Remove a page from the modal (simplified implementation)
  static void removePage(BuildContext context, String pageId) {
    // Basic implementation - actual API may vary
    // This method may need to be adjusted based on the actual 0.11.0 API
  }

  /// Update the current page (basic implementation)
  static void updateCurrentPage(
    BuildContext context,
    WoltModalSheetPage page,
  ) {
    // Basic implementation - may need adjustment based on actual API
    // The actual method name and signature may differ in 0.11.0
  }

  /// Close the modal
  static void close<T>(BuildContext context, [T? result]) {
    Navigator.of(context).pop(result);
  }
}

/// Extension to easily access Wolt Modal Sheet context
extension AppWoltModalContext on BuildContext {
  /// Get the current modal sheet context
  WoltModalSheetState? get woltModal {
    try {
      return WoltModalSheet.of(this);
    } catch (e) {
      return null;
    }
  }

  /// Show next page (if in a multi-page modal)
  void showNextPage() {
    woltModal?.showNext();
  }

  /// Show previous page (if in a multi-page modal)
  void showPreviousPage() {
    woltModal?.showPrevious();
  }

  /// Close the current modal
  void closeModal<T>([T? result]) {
    Navigator.of(this).pop(result);
  }
}