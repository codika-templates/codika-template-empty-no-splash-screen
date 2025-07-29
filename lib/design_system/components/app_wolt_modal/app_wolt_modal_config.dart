import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../tokens/app_radius.dart';

/// Configuration for app wolt modal behavior and appearance
class AppWoltModalConfig {
  /// Whether the modal can be dismissed by tapping outside or back gesture
  final bool barrierDismissible;

  /// Custom border radius for the modal corners
  final AppRadius? borderRadius;

  /// Custom background color (defaults to theme surface)
  final Color? backgroundColor;

  /// Mobile breakpoint for responsive behavior
  final double mobileBreakpoint;

  /// Whether to enable drag to dismiss on mobile
  final bool enableDrag;

  /// Custom animation duration for page transitions
  final Duration? pageTransitionDuration;

  /// Whether to show close button in navigation bar
  final bool showCloseButton;

  /// Custom modal type override (overrides responsive behavior)
  final WoltModalType? modalType;

  /// Whether to use safe area for the modal
  final bool useSafeArea;

  /// Custom minimum dialog width (for dialog mode)
  final double? minDialogWidth;

  /// Custom maximum dialog width (for dialog mode)
  final double? maxDialogWidth;

  /// Custom minimum page height
  final double? minPageHeight;

  /// Custom maximum page height
  final double? maxPageHeight;

  const AppWoltModalConfig({
    this.barrierDismissible = true,
    this.borderRadius,
    this.backgroundColor,
    this.mobileBreakpoint = 600,
    this.enableDrag = true,
    this.pageTransitionDuration,
    this.showCloseButton = true,
    this.modalType,
    this.useSafeArea = true,
    this.minDialogWidth,
    this.maxDialogWidth,
    this.minPageHeight,
    this.maxPageHeight,
  });

  /// Create a copy of this config with some fields replaced
  AppWoltModalConfig copyWith({
    bool? barrierDismissible,
    AppRadius? borderRadius,
    Color? backgroundColor,
    double? mobileBreakpoint,
    bool? enableDrag,
    Duration? pageTransitionDuration,
    bool? showCloseButton,
    WoltModalType? modalType,
    bool? useSafeArea,
    double? minDialogWidth,
    double? maxDialogWidth,
    double? minPageHeight,
    double? maxPageHeight,
  }) {
    return AppWoltModalConfig(
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
      borderRadius: borderRadius ?? this.borderRadius,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      mobileBreakpoint: mobileBreakpoint ?? this.mobileBreakpoint,
      enableDrag: enableDrag ?? this.enableDrag,
      pageTransitionDuration: pageTransitionDuration ?? this.pageTransitionDuration,
      showCloseButton: showCloseButton ?? this.showCloseButton,
      modalType: modalType ?? this.modalType,
      useSafeArea: useSafeArea ?? this.useSafeArea,
      minDialogWidth: minDialogWidth ?? this.minDialogWidth,
      maxDialogWidth: maxDialogWidth ?? this.maxDialogWidth,
      minPageHeight: minPageHeight ?? this.minPageHeight,
      maxPageHeight: maxPageHeight ?? this.maxPageHeight,
    );
  }

  /// Configuration optimized for form inputs
  static const AppWoltModalConfig form = AppWoltModalConfig(
    enableDrag: false,
    showCloseButton: true,
    useSafeArea: true,
  );

  /// Configuration optimized for simple dialogs
  static const AppWoltModalConfig dialog = AppWoltModalConfig(
    barrierDismissible: true,
    enableDrag: false,
    showCloseButton: false,
  );

  /// Configuration optimized for bottom sheets
  static const AppWoltModalConfig sheet = AppWoltModalConfig(
    barrierDismissible: true,
    enableDrag: true,
    showCloseButton: false,
  );

  /// Configuration for non-dismissible modals
  static const AppWoltModalConfig persistent = AppWoltModalConfig(
    barrierDismissible: false,
    enableDrag: false,
    showCloseButton: true,
  );
}