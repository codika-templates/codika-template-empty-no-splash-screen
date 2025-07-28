import 'package:flutter/material.dart';

import '../../services/interaction_feedback_service.dart';
import '../../theme/app_theme_extension.dart';
import '../../tokens/app_radius.dart';
import '../../tokens/app_shadows.dart';
import 'app_card.dart';

/// Clickable card component with proper web interaction support
class AppClickableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final AppCardVariant variant;
  final EdgeInsets? padding;
  final AppRadius? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final List<BoxShadow>? shadows;
  final double? width;
  final double? height;
  final bool showHoverEffect;
  final bool showRipple;
  final FeedbackType? feedbackType;
  final String? tooltip;

  const AppClickableCard({
    super.key,
    required this.child,
    this.onTap,
    this.variant = AppCardVariant.elevated,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.shadows,
    this.width,
    this.height,
    this.showHoverEffect = true,
    this.showRipple = true,
    this.feedbackType = FeedbackType.light,
    this.tooltip,
  });

  @override
  State<AppClickableCard> createState() => _AppClickableCardState();
}

class _AppClickableCardState extends State<AppClickableCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isPressed = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _animationController.reverse();
    if (widget.onTap != null) {
      final feedbackType = widget.feedbackType ?? FeedbackType.light;
      feedbackService.haptic(feedbackType);
      widget.onTap!();
    }
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  void _handleTap() {
    setState(() => _isPressed = false);
    _animationController.reverse();
    if (widget.onTap != null) {
      final feedbackType = widget.feedbackType ?? FeedbackType.light;
      feedbackService.haptic(feedbackType);
      widget.onTap!();
    }
  }

  void _handleHover(bool hovering) {
    setState(() => _isHovered = hovering);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme = theme.extension<AppThemeExtension>()!;
    final isInteractive = widget.onTap != null;

    // Calculate hover/press effects
    List<BoxShadow>? effectiveShadows;
    Color? effectiveBackgroundColor;
    Color? effectiveBorderColor;

    if (isInteractive && widget.showHoverEffect) {
      if (_isHovered && !_isPressed) {
        // Hover state
        effectiveShadows =
            widget.variant == AppCardVariant.elevated
                ? AppShadows.md.shadows
                : widget.shadows;
        effectiveBackgroundColor =
            widget.backgroundColor != null
                ? Color.alphaBlend(
                  theme.colorScheme.onSurface.withValues(alpha: 0.04),
                  widget.backgroundColor!,
                )
                : null;
        effectiveBorderColor =
            widget.variant == AppCardVariant.outlined
                ? theme.colorScheme.primary.withValues(alpha: 0.3)
                : widget.borderColor;
      } else if (_isPressed) {
        // Pressed state
        effectiveShadows =
            widget.variant == AppCardVariant.elevated
                ? AppShadows.lg.shadows
                : widget.shadows;
        effectiveBackgroundColor =
            widget.backgroundColor != null
                ? Color.alphaBlend(
                  theme.colorScheme.onSurface.withValues(alpha: 0.08),
                  widget.backgroundColor!,
                )
                : null;
        effectiveBorderColor =
            widget.variant == AppCardVariant.outlined
                ? theme.colorScheme.primary
                : widget.borderColor;
      }
    }

    Widget card = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: isInteractive ? _scaleAnimation.value : 1.0,
          child: AppCard(
            variant: widget.variant,
            padding: widget.padding,
            borderRadius: widget.borderRadius,
            backgroundColor: effectiveBackgroundColor ?? widget.backgroundColor,
            borderColor: effectiveBorderColor ?? widget.borderColor,
            shadows: effectiveShadows ?? widget.shadows,
            width: widget.width,
            height: widget.height,
            child: widget.child,
          ),
        );
      },
    );

    if (!isInteractive) {
      return card;
    }

    // Make it interactive
    Widget interactiveCard = MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      cursor: SystemMouseCursors.click,
      child:
          widget.showRipple
              ? Material(
                color: Colors.transparent,
                borderRadius:
                    (widget.borderRadius ?? appTheme.defaultRadius)
                        .borderRadius,
                child: InkWell(
                  borderRadius:
                      (widget.borderRadius ?? appTheme.defaultRadius)
                          .borderRadius,
                  onTap: _handleTap,
                  onTapDown: _handleTapDown,
                  onTapCancel: _handleTapCancel,
                  child: card,
                ),
              )
              : Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      (widget.borderRadius ?? appTheme.defaultRadius)
                          .borderRadius,
                  onTap: _handleTap,
                  onTapDown: _handleTapDown,
                  onTapCancel: _handleTapCancel,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: card,
                ),
              ),
    );

    // Add tooltip if provided
    if (widget.tooltip != null) {
      interactiveCard = Tooltip(
        message: widget.tooltip!,
        child: interactiveCard,
      );
    }

    return interactiveCard;
  }
}
