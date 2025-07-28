import 'package:flutter/material.dart';

import '../../services/interaction_feedback_service.dart';
import '../../theme/app_theme_extension.dart';
import '../../tokens/app_colors.dart';
import '../../tokens/app_density.dart';
import '../../tokens/app_radius.dart';
import '../../tokens/app_shadows.dart';
import '../../tokens/app_shapes.dart';
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
  final FeedbackType? feedbackType;
  final String? loadingText;

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
    this.feedbackType,
    this.loadingText,
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
    FeedbackType? feedbackType,
    String? loadingText,
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
      feedbackType: feedbackType,
      loadingText: loadingText,
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
    FeedbackType? feedbackType,
    String? loadingText,
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
      feedbackType: feedbackType,
      loadingText: loadingText,
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
    FeedbackType? feedbackType,
    String? loadingText,
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
      feedbackType: feedbackType,
      loadingText: loadingText,
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
    FeedbackType? feedbackType,
    String? loadingText,
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
      feedbackType: feedbackType,
      loadingText: loadingText,
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
    FeedbackType? feedbackType,
    String? loadingText,
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
      feedbackType: feedbackType,
      loadingText: loadingText,
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
    String? loadingText,
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
    String? loadingText,
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
      feedbackType: FeedbackType.impact,
      loadingText: loadingText,
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
    String? loadingText,
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
      feedbackType: FeedbackType.impact,
      loadingText: loadingText,
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
    FeedbackType? feedbackType,
    String? loadingText,
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
      feedbackType: feedbackType,
      loadingText: loadingText,
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

    // Determine the shape based on radius
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

    EdgeInsets padding;
    double minHeight;
    TextStyle textStyle;

    // Size-based properties
    switch (widget.size) {
      case AppButtonSize.sm:
        padding = AppSpacing.sm.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        );
        minHeight = effectiveDensity.buttonMinHeight * 0.8;
        textStyle = AppTextStyle.labelMedium.style;
        break;
      case AppButtonSize.md:
        padding = effectiveDensity.buttonPaddingEdgeInsets;
        minHeight = effectiveDensity.buttonMinHeight;
        textStyle = AppTextStyle.labelLarge.style;
        break;
      case AppButtonSize.lg:
        padding = AppSpacing.lg.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md,
        );
        minHeight = effectiveDensity.buttonMinHeight * 1.2;
        textStyle = AppTextStyle.labelLarge.style;
        break;
      case AppButtonSize.icon:
        padding = effectiveDensity.iconButtonPadding;
        minHeight = effectiveDensity.buttonMinHeight;
        textStyle = AppTextStyle.labelLarge.style;
        break;
      case AppButtonSize.compact:
        padding = AppSpacing.xs.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        );
        minHeight = effectiveDensity.buttonMinHeight * 0.7;
        textStyle = AppTextStyle.labelSmall.style;
        break;
    }

    // Variant-based properties
    Color backgroundColor;
    Color foregroundColor;
    Color? overlayColor;
    BorderSide? side;

    switch (widget.variant) {
      case AppButtonVariant.primary:
        backgroundColor = theme.colorScheme.primary;
        foregroundColor = theme.colorScheme.onPrimary;
        overlayColor = theme.colorScheme.onPrimary.withValues(alpha: 0.1);
        break;

      case AppButtonVariant.secondary:
        backgroundColor = theme.colorScheme.surfaceContainerHighest;
        foregroundColor = theme.colorScheme.onSurface;
        overlayColor = theme.colorScheme.onSurface.withValues(alpha: 0.1);
        side = BorderSide(color: appTheme.border);
        break;

      case AppButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        foregroundColor = theme.colorScheme.onSurface;
        overlayColor = theme.colorScheme.onSurface.withValues(alpha: 0.08);
        break;

      case AppButtonVariant.destructive:
        backgroundColor = AppColors.error.materialSwatch[500]!;
        foregroundColor = Colors.white;
        overlayColor = Colors.white.withValues(alpha: 0.1);
        break;

      case AppButtonVariant.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = theme.colorScheme.primary;
        overlayColor = theme.colorScheme.primary.withValues(alpha: 0.05);
        side = BorderSide(color: theme.colorScheme.primary, width: 1.5);
        break;

      case AppButtonVariant.link:
        backgroundColor = Colors.transparent;
        foregroundColor = theme.colorScheme.primary;
        overlayColor = theme.colorScheme.primary.withValues(alpha: 0.1);
        break;
    }

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return appTheme.disabled.withValues(alpha: 0.12);
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
      shape: WidgetStateProperty.all(shape.outlinedBorder),
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
      if (widget.loadingText != null) {
        // Show loading text with spinner
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: iconSize * 0.8,
              height: iconSize * 0.8,
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
            ),
            AppSpacing.xs.gapH,
            Text(widget.loadingText!),
          ],
        );
      } else {
        // Show only spinner
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

  VoidCallback? get _wrappedOnPressed {
    if (widget.onPressed == null) return null;
    return () {
      final feedbackType = widget.feedbackType ?? FeedbackType.impact;
      feedbackService.haptic(feedbackType);
      widget.onPressed!();
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme = context.appTheme;
    final radius = widget.borderRadius ?? appTheme.defaultRadius;

    // Determine the shape based on radius
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

    Widget button;

    if (widget.variant == AppButtonVariant.link) {
      button = TextButton(
        onPressed: _wrappedOnPressed,
        style: _getButtonStyle(context),
        child: _buildContent(context),
      );
    } else {
      button = Container(
        decoration:
            widget.variant == AppButtonVariant.primary ||
                widget.variant == AppButtonVariant.secondary ||
                widget.variant == AppButtonVariant.destructive
            ? ShapeDecoration(
                shape: shape.shapeBorder,
                shadows: _isHovered
                    ? AppShadows.md.shadows
                    : AppShadows.sm.shadows,
              )
            : null,
        child: ElevatedButton(
          onPressed: _wrappedOnPressed,
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
