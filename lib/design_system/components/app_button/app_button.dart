import 'package:flutter/material.dart';

import '../../theme/app_theme_extension.dart';
import '../../tokens/app_colors.dart';
import '../../tokens/app_density.dart';
import '../../tokens/app_radius.dart';
import '../../tokens/app_shadows.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';

enum AppButtonVariant { primary, secondary, ghost, destructive, outline, link }

enum AppButtonSize { sm, md, lg, icon, compact }

class AppButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final AppDensity? density;
  final bool isLoading;
  final bool fullWidth;
  final IconData? icon;
  final IconData? trailingIcon;
  final AppRadius? borderRadius;

  const AppButton._({
    required this.child,
    required this.variant,
    this.onPressed,
    this.size = AppButtonSize.md,
    this.density,
    this.isLoading = false,
    this.fullWidth = false,
    this.icon,
    this.trailingIcon,
    this.borderRadius,
    super.key,
  }) : assert(
         size != AppButtonSize.icon || icon != null,
         'Icon buttons (AppButtonSize.icon) must have an icon provided',
       );

  // Factory constructors for different variants
  factory AppButton.primary({
    Key? key,
    required Widget child,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.md,
    AppDensity? density,
    bool isLoading = false,
    bool fullWidth = false,
    IconData? icon,
    IconData? trailingIcon,
    AppRadius? borderRadius,
  }) {
    return AppButton._(
      key: key,
      onPressed: onPressed,
      variant: AppButtonVariant.primary,
      size: size,
      density: density,
      isLoading: isLoading,
      fullWidth: fullWidth,
      icon: icon,
      trailingIcon: trailingIcon,
      borderRadius: borderRadius,
      child: child,
    );
  }

  factory AppButton.secondary({
    Key? key,
    required Widget child,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.md,
    AppDensity? density,
    bool isLoading = false,
    bool fullWidth = false,
    IconData? icon,
    IconData? trailingIcon,
    AppRadius? borderRadius,
  }) {
    return AppButton._(
      key: key,
      onPressed: onPressed,
      variant: AppButtonVariant.secondary,
      size: size,
      density: density,
      isLoading: isLoading,
      fullWidth: fullWidth,
      icon: icon,
      trailingIcon: trailingIcon,
      borderRadius: borderRadius,
      child: child,
    );
  }

  factory AppButton.ghost({
    Key? key,
    required Widget child,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.md,
    AppDensity? density,
    bool isLoading = false,
    bool fullWidth = false,
    IconData? icon,
    IconData? trailingIcon,
    AppRadius? borderRadius,
  }) {
    return AppButton._(
      key: key,
      onPressed: onPressed,
      variant: AppButtonVariant.ghost,
      size: size,
      density: density,
      isLoading: isLoading,
      fullWidth: fullWidth,
      icon: icon,
      trailingIcon: trailingIcon,
      borderRadius: borderRadius,
      child: child,
    );
  }

  factory AppButton.destructive({
    Key? key,
    required Widget child,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.md,
    AppDensity? density,
    bool isLoading = false,
    bool fullWidth = false,
    IconData? icon,
    IconData? trailingIcon,
    AppRadius? borderRadius,
  }) {
    return AppButton._(
      key: key,
      onPressed: onPressed,
      variant: AppButtonVariant.destructive,
      size: size,
      density: density,
      isLoading: isLoading,
      fullWidth: fullWidth,
      icon: icon,
      trailingIcon: trailingIcon,
      borderRadius: borderRadius,
      child: child,
    );
  }

  factory AppButton.outline({
    Key? key,
    required Widget child,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.md,
    AppDensity? density,
    bool isLoading = false,
    bool fullWidth = false,
    IconData? icon,
    IconData? trailingIcon,
    AppRadius? borderRadius,
  }) {
    return AppButton._(
      key: key,
      onPressed: onPressed,
      variant: AppButtonVariant.outline,
      size: size,
      density: density,
      isLoading: isLoading,
      fullWidth: fullWidth,
      icon: icon,
      trailingIcon: trailingIcon,
      borderRadius: borderRadius,
      child: child,
    );
  }

  factory AppButton.link({
    Key? key,
    required Widget child,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.md,
    AppDensity? density,
    bool isLoading = false,
    bool fullWidth = false,
    IconData? icon,
    IconData? trailingIcon,
  }) {
    return AppButton._(
      key: key,
      onPressed: onPressed,
      variant: AppButtonVariant.link,
      size: size,
      density: density,
      isLoading: isLoading,
      fullWidth: fullWidth,
      icon: icon,
      trailingIcon: trailingIcon,
      child: child,
    );
  }

  // Icon button factory constructor
  factory AppButton.icon({
    Key? key,
    required IconData icon,
    required VoidCallback? onPressed,
    AppButtonVariant variant = AppButtonVariant.primary,
    AppDensity? density,
    bool isLoading = false,
    AppRadius? borderRadius,
  }) {
    return AppButton._(
      key: key,
      onPressed: onPressed,
      variant: variant,
      size: AppButtonSize.icon,
      density: density,
      isLoading: isLoading,
      fullWidth: false,
      icon: icon,
      borderRadius: borderRadius,
      child: const SizedBox.shrink(), // Empty child for icon buttons
    );
  }

  // Rounded (circular) icon button factory constructor
  factory AppButton.iconRounded({
    Key? key,
    required IconData icon,
    required VoidCallback? onPressed,
    AppButtonVariant variant = AppButtonVariant.primary,
    AppDensity? density,
    bool isLoading = false,
  }) {
    return AppButton._(
      key: key,
      onPressed: onPressed,
      variant: variant,
      size: AppButtonSize.icon,
      density: density,
      isLoading: isLoading,
      fullWidth: false,
      icon: icon,
      borderRadius: AppRadius.pill, // Perfectly circular
      child: const SizedBox.shrink(), // Empty child for icon buttons
    );
  }

  // Compact button factory constructor for badges/labels
  factory AppButton.compact({
    Key? key,
    required Widget child,
    required VoidCallback? onPressed,
    AppButtonVariant variant = AppButtonVariant.secondary,
    AppDensity? density,
    bool isLoading = false,
    IconData? icon,
    AppRadius? borderRadius,
  }) {
    return AppButton._(
      key: key,
      onPressed: onPressed,
      variant: variant,
      size: AppButtonSize.compact,
      density: density,
      isLoading: isLoading,
      fullWidth: false,
      icon: icon,
      borderRadius: borderRadius,
      child: child,
    );
  }

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme = context.appTheme;
    final effectiveDensity = widget.density ?? appTheme.density;
    final radius = widget.borderRadius ?? appTheme.defaultRadius;

    EdgeInsets padding;
    double minHeight;
    TextStyle textStyle;
    double iconSize;

    // Size-based properties
    switch (widget.size) {
      case AppButtonSize.sm:
        padding = AppSpacing.sm.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        );
        minHeight = effectiveDensity.buttonMinHeight * 0.8;
        textStyle = AppTextStyle.labelMedium.style;
        iconSize = effectiveDensity.buttonIconSize * 0.8;
        break;
      case AppButtonSize.md:
        padding = effectiveDensity.buttonPaddingEdgeInsets;
        minHeight = effectiveDensity.buttonMinHeight;
        textStyle = AppTextStyle.labelLarge.style;
        iconSize = effectiveDensity.buttonIconSize;
        break;
      case AppButtonSize.lg:
        padding = AppSpacing.lg.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md,
        );
        minHeight = effectiveDensity.buttonMinHeight * 1.2;
        textStyle = AppTextStyle.labelLarge.style;
        iconSize = effectiveDensity.buttonIconSize * 1.2;
        break;
      case AppButtonSize.icon:
        padding = effectiveDensity.iconButtonPadding;
        minHeight = effectiveDensity.buttonMinHeight;
        textStyle = AppTextStyle.labelLarge.style;
        iconSize = effectiveDensity.buttonIconSize;
        break;
      case AppButtonSize.compact:
        padding = AppSpacing.xs.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        );
        minHeight = effectiveDensity.buttonMinHeight * 0.7;
        textStyle = AppTextStyle.labelSmall.style;
        iconSize = effectiveDensity.buttonIconSize * 0.7;
        break;
    }

    // Variant-based properties
    Color backgroundColor;
    Color foregroundColor;
    Color? overlayColor;
    BorderSide? side;
    List<BoxShadow>? boxShadow;

    switch (widget.variant) {
      case AppButtonVariant.primary:
        backgroundColor = theme.colorScheme.primary;
        foregroundColor = theme.colorScheme.onPrimary;
        overlayColor = theme.colorScheme.onPrimary.withOpacity(0.1);
        boxShadow = AppShadows.sm.shadows;
        break;

      case AppButtonVariant.secondary:
        backgroundColor = theme.colorScheme.surfaceContainerHighest;
        foregroundColor = theme.colorScheme.onSurface;
        overlayColor = theme.colorScheme.onSurface.withOpacity(0.1);
        side = BorderSide(color: appTheme.border);
        boxShadow = AppShadows.sm.shadows;
        break;

      case AppButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        foregroundColor = theme.colorScheme.onSurface;
        overlayColor = theme.colorScheme.onSurface.withOpacity(0.08);
        break;

      case AppButtonVariant.destructive:
        backgroundColor = AppColors.error.materialSwatch[500]!;
        foregroundColor = Colors.white;
        overlayColor = Colors.white.withOpacity(0.1);
        boxShadow = AppShadows.sm.shadows;
        break;

      case AppButtonVariant.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = theme.colorScheme.primary;
        overlayColor = theme.colorScheme.primary.withOpacity(0.05);
        side = BorderSide(color: theme.colorScheme.primary, width: 1.5);
        break;

      case AppButtonVariant.link:
        backgroundColor = Colors.transparent;
        foregroundColor = theme.colorScheme.primary;
        overlayColor = theme.colorScheme.primary.withOpacity(0.1);
        break;
    }

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return appTheme.disabled.withOpacity(0.12);
        }
        if (states.contains(WidgetState.hovered)) {
          return backgroundColor == Colors.transparent
              ? overlayColor
              : Color.alphaBlend(
                overlayColor ?? Colors.transparent,
                backgroundColor,
              );
        }
        return backgroundColor;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return appTheme.disabled;
        }
        return foregroundColor;
      }),
      overlayColor: WidgetStateProperty.all(overlayColor),
      side: side != null ? WidgetStateProperty.all(side) : null,
      shape: WidgetStateProperty.all(radius.buttonShape),
      padding: WidgetStateProperty.all(padding),
      minimumSize: WidgetStateProperty.all(
        widget.size == AppButtonSize.icon
            ? Size(minHeight, minHeight) // Square for icon buttons
            : widget.fullWidth
            ? Size(double.infinity, minHeight)
            : Size(0, minHeight),
      ),
      textStyle: WidgetStateProperty.all(textStyle),
      elevation: WidgetStateProperty.all(0),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
    );
  }

  Widget _buildContent(BuildContext context) {
    final effectiveDensity = widget.density ?? context.appTheme.density;
    final iconSize = effectiveDensity.buttonIconSize;

    if (widget.isLoading) {
      return SizedBox(
        width: iconSize,
        height: iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            widget.variant == AppButtonVariant.primary ||
                    widget.variant == AppButtonVariant.secondary ||
                    widget.variant == AppButtonVariant.destructive
                ? Colors.white
                : Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    }

    if (widget.size == AppButtonSize.icon) {
      return Icon(widget.icon, size: iconSize);
    }

    final children = <Widget>[];

    if (widget.icon != null) {
      children.add(Icon(widget.icon, size: iconSize));
      children.add(AppSpacing.xs.gapH);
    }

    children.add(widget.child);

    if (widget.trailingIcon != null) {
      children.add(AppSpacing.xs.gapH);
      children.add(Icon(widget.trailingIcon, size: iconSize));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget button;

    if (widget.variant == AppButtonVariant.link) {
      button = TextButton(
        onPressed: widget.onPressed,
        style: _getButtonStyle(context),
        child: _buildContent(context),
      );
    } else {
      button = Container(
        decoration:
            widget.variant == AppButtonVariant.primary ||
                    widget.variant == AppButtonVariant.secondary ||
                    widget.variant == AppButtonVariant.destructive
                ? BoxDecoration(
                  borderRadius:
                      (widget.borderRadius ?? context.appTheme.defaultRadius)
                          .borderRadius,
                  boxShadow:
                      _isHovered
                          ? AppShadows.md.shadows
                          : AppShadows.sm.shadows,
                )
                : null,
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: _getButtonStyle(context),
          child: _buildContent(context),
        ),
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => _animationController.forward(),
        onTapUp: (_) => _animationController.reverse(),
        onTapCancel: () => _animationController.reverse(),
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(scale: _scaleAnimation.value, child: button);
          },
        ),
      ),
    );
  }
}
