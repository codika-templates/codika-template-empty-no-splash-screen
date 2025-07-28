import 'package:flutter/material.dart';

import '../../services/interaction_feedback_service.dart';
import '../../theme/app_theme_extension.dart';
import '../../tokens/app_density.dart';
import '../../tokens/app_radius.dart';
import '../../tokens/app_shadows.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';

enum AppBottomBarVariant { standard, floating, notched }

enum AppBottomBarSize { compact, standard, comfortable }

class AppBottomBarItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final Widget? badge;
  final Color? color;
  final Color? activeColor;

  const AppBottomBarItem({
    required this.icon,
    required this.label,
    this.activeIcon,
    this.badge,
    this.color,
    this.activeColor,
  });
}

class AppBottomBar extends StatefulWidget {
  final List<AppBottomBarItem> items;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final AppBottomBarVariant variant;
  final AppBottomBarSize size;
  final AppDensity? density;
  final Color? backgroundColor;
  final Color? surfaceTintColor;
  final double? elevation;
  final AppRadius? borderRadius;
  final EdgeInsets? margin;
  final bool showLabels;
  final bool showUnselectedLabels;
  final FeedbackType? feedbackType;
  final BottomNavigationBarType? type;

  const AppBottomBar._({
    required this.items,
    required this.currentIndex,
    required this.variant,
    this.onTap,
    this.size = AppBottomBarSize.standard,
    this.density,
    this.backgroundColor,
    this.surfaceTintColor,
    this.elevation,
    this.borderRadius,
    this.margin,
    this.showLabels = true,
    this.showUnselectedLabels = true,
    this.feedbackType,
    this.type,
    super.key,
  }) : assert(items.length >= 2, 'AppBottomBar must have at least 2 items'),
       assert(
         currentIndex >= 0 && currentIndex < items.length,
         'currentIndex must be within the range of items',
       );

  // Factory constructors for different variants
  factory AppBottomBar.standard({
    Key? key,
    required List<AppBottomBarItem> items,
    required int currentIndex,
    ValueChanged<int>? onTap,
    AppBottomBarSize size = AppBottomBarSize.standard,
    AppDensity? density,
    Color? backgroundColor,
    Color? surfaceTintColor,
    double? elevation,
    bool showLabels = true,
    bool showUnselectedLabels = true,
    FeedbackType? feedbackType,
    BottomNavigationBarType? type,
  }) {
    return AppBottomBar._(
      key: key,
      items: items,
      currentIndex: currentIndex,
      onTap: onTap,
      variant: AppBottomBarVariant.standard,
      size: size,
      density: density,
      backgroundColor: backgroundColor,
      surfaceTintColor: surfaceTintColor,
      elevation: elevation,
      showLabels: showLabels,
      showUnselectedLabels: showUnselectedLabels,
      feedbackType: feedbackType,
      type: type,
    );
  }

  factory AppBottomBar.floating({
    Key? key,
    required List<AppBottomBarItem> items,
    required int currentIndex,
    ValueChanged<int>? onTap,
    AppBottomBarSize size = AppBottomBarSize.standard,
    AppDensity? density,
    Color? backgroundColor,
    Color? surfaceTintColor,
    double? elevation,
    AppRadius? borderRadius,
    EdgeInsets? margin,
    bool showLabels = true,
    bool showUnselectedLabels = false,
    FeedbackType? feedbackType,
  }) {
    return AppBottomBar._(
      key: key,
      items: items,
      currentIndex: currentIndex,
      onTap: onTap,
      variant: AppBottomBarVariant.floating,
      size: size,
      density: density,
      backgroundColor: backgroundColor,
      surfaceTintColor: surfaceTintColor,
      elevation: elevation,
      borderRadius: borderRadius,
      margin: margin,
      showLabels: showLabels,
      showUnselectedLabels: showUnselectedLabels,
      feedbackType: feedbackType,
      type: BottomNavigationBarType.fixed,
    );
  }

  factory AppBottomBar.notched({
    Key? key,
    required List<AppBottomBarItem> items,
    required int currentIndex,
    ValueChanged<int>? onTap,
    AppBottomBarSize size = AppBottomBarSize.standard,
    AppDensity? density,
    Color? backgroundColor,
    Color? surfaceTintColor,
    double? elevation,
    bool showLabels = true,
    bool showUnselectedLabels = false,
    FeedbackType? feedbackType,
  }) {
    return AppBottomBar._(
      key: key,
      items: items,
      currentIndex: currentIndex,
      onTap: onTap,
      variant: AppBottomBarVariant.notched,
      size: size,
      density: density,
      backgroundColor: backgroundColor,
      surfaceTintColor: surfaceTintColor,
      elevation: elevation,
      showLabels: showLabels,
      showUnselectedLabels: showUnselectedLabels,
      feedbackType: feedbackType,
      type: BottomNavigationBarType.fixed,
    );
  }

  // Icon-only compact variant
  factory AppBottomBar.compact({
    Key? key,
    required List<AppBottomBarItem> items,
    required int currentIndex,
    ValueChanged<int>? onTap,
    AppDensity? density,
    Color? backgroundColor,
    Color? surfaceTintColor,
    double? elevation,
    FeedbackType? feedbackType,
  }) {
    return AppBottomBar._(
      key: key,
      items: items,
      currentIndex: currentIndex,
      onTap: onTap,
      variant: AppBottomBarVariant.standard,
      size: AppBottomBarSize.compact,
      density: density,
      backgroundColor: backgroundColor,
      surfaceTintColor: surfaceTintColor,
      elevation: elevation,
      showLabels: false,
      showUnselectedLabels: false,
      feedbackType: feedbackType,
      type: BottomNavigationBarType.fixed,
    );
  }

  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  void _handleTap(int index) {
    if (widget.feedbackType != null) {
      feedbackService.haptic(widget.feedbackType!);
    }
    widget.onTap?.call(index);
  }

  List<BottomNavigationBarItem> _buildNavigationItems(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme = context.appTheme;

    return widget.items.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      final isSelected = index == widget.currentIndex;

      // Use active icon if provided and selected, otherwise use regular icon
      final effectiveIcon =
          isSelected && item.activeIcon != null ? item.activeIcon! : item.icon;

      Widget icon = Icon(effectiveIcon);

      // Add badge if provided
      if (item.badge != null) {
        icon = Badge(label: item.badge, child: icon);
      }

      return BottomNavigationBarItem(
        icon: icon,
        label: item.label,
        backgroundColor: widget.backgroundColor,
      );
    }).toList();
  }

  double _getElevation() {
    switch (widget.variant) {
      case AppBottomBarVariant.standard:
        return widget.elevation ?? 8.0;
      case AppBottomBarVariant.floating:
        return widget.elevation ?? 16.0;
      case AppBottomBarVariant.notched:
        return widget.elevation ?? 8.0;
    }
  }

  double _getIconSize() {
    final effectiveDensity = widget.density ?? context.appTheme.density;

    switch (widget.size) {
      case AppBottomBarSize.compact:
        return effectiveDensity.buttonIconSize * 0.9;
      case AppBottomBarSize.standard:
        return effectiveDensity.buttonIconSize;
      case AppBottomBarSize.comfortable:
        return effectiveDensity.buttonIconSize * 1.1;
    }
  }

  TextStyle _getTextStyle(bool isSelected) {
    switch (widget.size) {
      case AppBottomBarSize.compact:
        return AppTextStyle.labelSmall.style;
      case AppBottomBarSize.standard:
        return isSelected
            ? AppTextStyle.labelMedium.style.copyWith(
              fontWeight: FontWeight.w600,
            )
            : AppTextStyle.labelSmall.style;
      case AppBottomBarSize.comfortable:
        return isSelected
            ? AppTextStyle.labelLarge.style.copyWith(
              fontWeight: FontWeight.w600,
            )
            : AppTextStyle.labelMedium.style;
    }
  }

  Widget _buildStandardBottomBar(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme = context.appTheme;
    final iconSize = _getIconSize();

    return BottomNavigationBar(
      items: _buildNavigationItems(context),
      currentIndex: widget.currentIndex,
      onTap: _handleTap,
      type: widget.type ?? BottomNavigationBarType.fixed,
      backgroundColor: widget.backgroundColor ?? theme.colorScheme.surface,
      elevation: _getElevation(),
      selectedItemColor: theme.colorScheme.primary,
      unselectedItemColor: theme.colorScheme.onSurfaceVariant,
      showSelectedLabels: widget.showLabels,
      showUnselectedLabels: widget.showUnselectedLabels,
      selectedFontSize: widget.showLabels ? 13.0 : 0,
      unselectedFontSize: widget.showUnselectedLabels ? 12.0 : 0,
      selectedIconTheme: IconThemeData(size: iconSize),
      unselectedIconTheme: IconThemeData(size: iconSize * 0.9),
      selectedLabelStyle: _getTextStyle(true),
      unselectedLabelStyle: _getTextStyle(false),
    );
  }

  Widget _buildFloatingBottomBar(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme = context.appTheme;
    final radius = widget.borderRadius ?? AppRadius.xl;
    final margin = widget.margin ?? AppSpacing.md.padding;

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: radius.borderRadius,
        boxShadow: AppShadows.lg.shadows,
      ),
      child: ClipRRect(
        borderRadius: radius.borderRadius,
        child: _buildStandardBottomBar(context),
      ),
    );
  }

  Widget _buildNotchedBottomBar(BuildContext context) {
    return BottomAppBar(
      elevation: _getElevation(),
      color: widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
      surfaceTintColor: widget.surfaceTintColor,
      notchMargin: AppSpacing.sm.value,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            widget.items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = index == widget.currentIndex;
              final iconSize = _getIconSize();

              // Use active icon if provided and selected
              final effectiveIcon =
                  isSelected && item.activeIcon != null
                      ? item.activeIcon!
                      : item.icon;

              Widget iconWidget = Icon(
                effectiveIcon,
                size: iconSize,
                color:
                    isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurfaceVariant,
              );

              // Add badge if provided
              if (item.badge != null) {
                iconWidget = Badge(label: item.badge, child: iconWidget);
              }

              Widget child = iconWidget;

              // Add label if shown
              if (widget.showLabels ||
                  (widget.showUnselectedLabels && !isSelected)) {
                child = Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    iconWidget,
                    AppSpacing.xs.gapV,
                    Text(
                      item.label,
                      style: _getTextStyle(isSelected).copyWith(
                        color:
                            isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                );
              }

              return Expanded(
                child: InkWell(
                  onTap: () => _handleTap(index),
                  borderRadius: AppRadius.md.borderRadius,
                  child: Container(
                    padding: AppSpacing.sm.padding,
                    child: child,
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.variant) {
      case AppBottomBarVariant.standard:
        return _buildStandardBottomBar(context);
      case AppBottomBarVariant.floating:
        return _buildFloatingBottomBar(context);
      case AppBottomBarVariant.notched:
        return _buildNotchedBottomBar(context);
    }
  }
}
