import 'package:flutter/material.dart';
import '../../tokens/app_colors.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';
import '../app_loading_indicator/app_loading_indicator.dart';

/// Loading overlay component for blocking user interaction during loading states.
///
/// Provides a semi-transparent overlay with loading indicators and optional
/// messaging. Integrates with the design system's color, spacing, and typography
/// tokens. Supports multiple variants for different use cases and contexts.
enum AppLoadingOverlayVariant {
  fullScreen,
  modal,
  inline,
  global,
}

class AppLoadingOverlay extends StatelessWidget {
  const AppLoadingOverlay._({
    super.key,
    required this.variant,
    required this.isLoading,
    this.child,
    this.message,
    this.loadingIndicator,
    this.backgroundColor,
    this.overlayColor,
    this.borderRadius,
    this.padding,
    this.alignment = Alignment.center,
    this.textStyle,
  });

  /// Factory constructor for full-screen loading overlay
  factory AppLoadingOverlay.fullScreen({
    Key? key,
    required bool isLoading,
    String? message,
    Widget? loadingIndicator,
    Color? backgroundColor,
    Color? overlayColor,
    EdgeInsetsGeometry? padding,
    Alignment alignment = Alignment.center,
    TextStyle? textStyle,
    required Widget child,
  }) {
    return AppLoadingOverlay._(
      key: key,
      variant: AppLoadingOverlayVariant.fullScreen,
      isLoading: isLoading,
      child: child,
      message: message,
      loadingIndicator: loadingIndicator,
      backgroundColor: backgroundColor,
      overlayColor: overlayColor,
      padding: padding,
      alignment: alignment,
      textStyle: textStyle,
    );
  }

  /// Factory constructor for modal-style loading overlay
  factory AppLoadingOverlay.modal({
    Key? key,
    required bool isLoading,
    String? message,
    Widget? loadingIndicator,
    Color? backgroundColor,
    Color? overlayColor,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    Alignment alignment = Alignment.center,
    TextStyle? textStyle,
    required Widget child,
  }) {
    return AppLoadingOverlay._(
      key: key,
      variant: AppLoadingOverlayVariant.modal,
      isLoading: isLoading,
      child: child,
      message: message,
      loadingIndicator: loadingIndicator,
      backgroundColor: backgroundColor,
      overlayColor: overlayColor,
      borderRadius: borderRadius,
      padding: padding,
      alignment: alignment,
      textStyle: textStyle,
    );
  }

  /// Factory constructor for inline loading overlay
  factory AppLoadingOverlay.inline({
    Key? key,
    required bool isLoading,
    String? message,
    Widget? loadingIndicator,
    Color? backgroundColor,
    Color? overlayColor,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    Alignment alignment = Alignment.center,
    TextStyle? textStyle,
    required Widget child,
  }) {
    return AppLoadingOverlay._(
      key: key,
      variant: AppLoadingOverlayVariant.inline,
      isLoading: isLoading,
      child: child,
      message: message,
      loadingIndicator: loadingIndicator,
      backgroundColor: backgroundColor,
      overlayColor: overlayColor,
      borderRadius: borderRadius,
      padding: padding,
      alignment: alignment,
      textStyle: textStyle,
    );
  }

  final AppLoadingOverlayVariant variant;
  final bool isLoading;
  final Widget? child;
  final String? message;
  final Widget? loadingIndicator;
  final Color? backgroundColor;
  final Color? overlayColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Alignment alignment;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return child ?? const SizedBox.shrink();
    }

    final effectiveBackgroundColor = backgroundColor ?? 
                                    Theme.of(context).colorScheme.surface;
    final effectiveOverlayColor = overlayColor ?? 
                                 Colors.black.withValues(alpha: 0.5);
    final effectivePadding = padding ?? AppSpacing.lg.padding;
    final effectiveTextStyle = textStyle ?? AppTextStyle.bodyMedium.style;
    final effectiveLoadingIndicator = loadingIndicator ?? 
                                     AppLoadingIndicator.circular(
                                       size: AppLoadingIndicatorSize.large,
                                     );

    switch (variant) {
      case AppLoadingOverlayVariant.fullScreen:
        return _buildFullScreenOverlay(
          context,
          effectiveBackgroundColor,
          effectiveOverlayColor,
          effectivePadding,
          effectiveTextStyle,
          effectiveLoadingIndicator,
        );
      case AppLoadingOverlayVariant.modal:
        return _buildModalOverlay(
          context,
          effectiveBackgroundColor,
          effectiveOverlayColor,
          effectivePadding,
          effectiveTextStyle,
          effectiveLoadingIndicator,
        );
      case AppLoadingOverlayVariant.inline:
        return _buildInlineOverlay(
          context,
          effectiveBackgroundColor,
          effectiveOverlayColor,
          effectivePadding,
          effectiveTextStyle,
          effectiveLoadingIndicator,
        );
      case AppLoadingOverlayVariant.global:
        // Global variant is handled by static methods, return child directly
        return child ?? const SizedBox.shrink();
    }
  }

  Widget _buildFullScreenOverlay(
    BuildContext context,
    Color backgroundColor,
    Color overlayColor,
    EdgeInsetsGeometry padding,
    TextStyle textStyle,
    Widget loadingIndicator,
  ) {
    return Stack(
      children: [
        // Background content
        if (child != null) child!,
        
        // Full screen overlay
        IgnorePointer(
          ignoring: !isLoading,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            color: isLoading ? overlayColor : Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Visibility(
              visible: isLoading,
              child: Container(
                color: backgroundColor.withValues(alpha: 0.9),
                child: _buildLoadingContent(
                  padding,
                  textStyle,
                  loadingIndicator,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModalOverlay(
    BuildContext context,
    Color backgroundColor,
    Color overlayColor,
    EdgeInsetsGeometry padding,
    TextStyle textStyle,
    Widget loadingIndicator,
  ) {
    return Stack(
      children: [
        // Background content
        if (child != null) child!,
        
        // Modal overlay
        if (isLoading)
          IgnorePointer(
            child: Container(
              color: overlayColor,
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: 200,
                    maxWidth: 300,
                    minHeight: 120,
                  ),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: borderRadius ?? BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: _buildLoadingContent(
                    padding,
                    textStyle,
                    loadingIndicator,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInlineOverlay(
    BuildContext context,
    Color backgroundColor,
    Color overlayColor,
    EdgeInsetsGeometry padding,
    TextStyle textStyle,
    Widget loadingIndicator,
  ) {
    return Stack(
      children: [
        // Background content  
        if (child != null) child!,
        
        // Inline overlay
        if (isLoading)
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor.withValues(alpha: 0.95),
                borderRadius: borderRadius,
              ),
              child: _buildLoadingContent(
                padding,
                textStyle,
                loadingIndicator,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLoadingContent(
    EdgeInsetsGeometry padding,
    TextStyle textStyle,
    Widget loadingIndicator,
  ) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          loadingIndicator,
          if (message != null) ...[
            AppSpacing.lg.gapV,
            Text(
              message!,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          ],
        ],
      ),
    );
  }
}

/// Convenience widget for wrapping content with loading overlay
class AppLoadingWrapper extends StatelessWidget {
  const AppLoadingWrapper({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
    this.loadingIndicator,
    this.variant = AppLoadingOverlayVariant.inline,
  });

  final bool isLoading;
  final Widget child;
  final String? message;
  final Widget? loadingIndicator;
  final AppLoadingOverlayVariant variant;

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case AppLoadingOverlayVariant.fullScreen:
        return AppLoadingOverlay.fullScreen(
          isLoading: isLoading,
          message: message,
          loadingIndicator: loadingIndicator,
          child: child,
        );
      case AppLoadingOverlayVariant.modal:
        return AppLoadingOverlay.modal(
          isLoading: isLoading,
          message: message,
          loadingIndicator: loadingIndicator,
          child: child,
        );
      case AppLoadingOverlayVariant.inline:
        return AppLoadingOverlay.inline(
          isLoading: isLoading,
          message: message,
          loadingIndicator: loadingIndicator,
          child: child,
        );
      case AppLoadingOverlayVariant.global:
        // Global variant is handled differently via static methods
        return child;
    }
  }

}

/// Pre-built loading overlay configurations
class AppLoadingOverlayPresets {
  /// Saving state overlay
  static Widget saving({
    required bool isLoading,
    required Widget child,
    required BuildContext context,
    String message = 'Saving...',
    AppLoadingOverlayVariant variant = AppLoadingOverlayVariant.modal,
  }) {
    return AppLoadingWrapper(
      isLoading: isLoading,
      variant: variant,
      message: message,
      loadingIndicator: AppLoadingIndicator.circular(
        size: AppLoadingIndicatorSize.medium,
        color: AppColors.primary.resolve(context),
      ),
      child: child,
    );
  }

  /// Processing state overlay
  static Widget processing({
    required bool isLoading,
    required Widget child,
    String message = 'Processing...',
    AppLoadingOverlayVariant variant = AppLoadingOverlayVariant.fullScreen,
  }) {
    return AppLoadingWrapper(
      isLoading: isLoading,
      variant: variant,
      message: message,
      loadingIndicator: AppLoadingIndicator.dots(
        size: AppLoadingIndicatorSize.large,
      ),
      child: child,
    );
  }

  /// Loading content overlay
  static Widget loading({
    required bool isLoading,
    required Widget child,
    String message = 'Loading...',
    AppLoadingOverlayVariant variant = AppLoadingOverlayVariant.inline,
  }) {
    return AppLoadingWrapper(
      isLoading: isLoading,
      variant: variant,
      message: message,
      loadingIndicator: AppLoadingIndicator.pulse(
        size: AppLoadingIndicatorSize.medium,
      ),
      child: child,
    );
  }

  /// Uploading state overlay
  static Widget uploading({
    required bool isLoading,
    required Widget child,
    required BuildContext context,
    String message = 'Uploading...',
    AppLoadingOverlayVariant variant = AppLoadingOverlayVariant.modal,
  }) {
    return AppLoadingWrapper(
      isLoading: isLoading,
      variant: variant,
      message: message,
      loadingIndicator: AppLoadingIndicator.bars(
        size: AppLoadingIndicatorSize.medium,
        color: AppColors.success.resolve(context),
      ),
      child: child,
    );
  }
}

/// Global loading overlay utility
class AppGlobalLoadingOverlay {
  static OverlayEntry? _globalOverlayEntry;
  
  /// Show a global loading overlay that covers the entire app
  static void show({
    required BuildContext context,
    String? message,
    Widget? loadingIndicator,
    Color? backgroundColor,
    Color? overlayColor,
    TextStyle? textStyle,
  }) {
    hide(); // Remove any existing overlay first
    
    final overlay = Overlay.of(context);
    _globalOverlayEntry = OverlayEntry(
      builder: (context) => Material(
        color: overlayColor ?? Colors.black.withValues(alpha: 0.5),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Container(
              padding: AppSpacing.lg.padding,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  loadingIndicator ?? AppLoadingIndicator.circular(),
                  if (message != null) ...[
                    AppSpacing.md.gapV,
                    Text(
                      message,
                      style: textStyle ?? AppTextStyle.bodyMedium.style,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
    overlay.insert(_globalOverlayEntry!);
  }

  /// Hide the global loading overlay
  static void hide() {
    _globalOverlayEntry?.remove();
    _globalOverlayEntry = null;
  }
}

