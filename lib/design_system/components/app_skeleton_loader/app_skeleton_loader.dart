import 'package:flutter/material.dart';
import '../../tokens/app_colors.dart';
import '../../tokens/app_radius.dart';
import '../../tokens/app_spacing.dart';

/// Skeleton loader component for indicating loading content with placeholder shapes.
///
/// Provides animated shimmer effects to indicate content is loading while
/// maintaining the visual structure of the final content. Integrates with
/// the design system's color, spacing, and radius tokens.
enum AppSkeletonLoaderVariant {
  container,
  text,
  circle,
  card,
}

class AppSkeletonLoader extends StatefulWidget {
  const AppSkeletonLoader._({
    super.key,
    required this.variant,
    this.width,
    this.height,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.child,
    this.enabled = true,
  });

  /// Factory constructor for basic container skeleton
  factory AppSkeletonLoader.container({
    Key? key,
    double? width,
    double? height = 16.0,
    BorderRadius? borderRadius,
    Color? baseColor,
    Color? highlightColor,
    Duration animationDuration = const Duration(milliseconds: 1500),
    bool enabled = true,
  }) {
    return AppSkeletonLoader._(
      key: key,
      variant: AppSkeletonLoaderVariant.container,
      width: width,
      height: height,
      borderRadius: borderRadius,
      baseColor: baseColor,
      highlightColor: highlightColor,
      animationDuration: animationDuration,
      enabled: enabled,
    );
  }

  /// Factory constructor for text line skeleton
  factory AppSkeletonLoader.text({
    Key? key,
    double? width,
    double height = 16.0,
    Color? baseColor,
    Color? highlightColor,
    Duration animationDuration = const Duration(milliseconds: 1500),
    bool enabled = true,
  }) {
    return AppSkeletonLoader._(
      key: key,
      variant: AppSkeletonLoaderVariant.text,
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(height / 2),
      baseColor: baseColor,
      highlightColor: highlightColor,
      animationDuration: animationDuration,
      enabled: enabled,
    );
  }

  /// Factory constructor for circular skeleton (avatars, icons)
  factory AppSkeletonLoader.circle({
    Key? key,
    required double diameter,
    Color? baseColor,
    Color? highlightColor,
    Duration animationDuration = const Duration(milliseconds: 1500),
    bool enabled = true,
  }) {
    return AppSkeletonLoader._(
      key: key,
      variant: AppSkeletonLoaderVariant.circle,
      width: diameter,
      height: diameter,
      borderRadius: BorderRadius.circular(diameter / 2),
      baseColor: baseColor,
      highlightColor: highlightColor,
      animationDuration: animationDuration,
      enabled: enabled,
    );
  }

  /// Factory constructor for card-style skeleton
  factory AppSkeletonLoader.card({
    Key? key,
    double? width,
    double height = 120.0,
    BorderRadius? borderRadius,
    Color? baseColor,
    Color? highlightColor,
    Duration animationDuration = const Duration(milliseconds: 1500),
    bool enabled = true,
  }) {
    return AppSkeletonLoader._(
      key: key,
      variant: AppSkeletonLoaderVariant.card,
      width: width,
      height: height,
      borderRadius: borderRadius ?? AppRadius.md.borderRadius,
      baseColor: baseColor,
      highlightColor: highlightColor,
      animationDuration: animationDuration,
      enabled: enabled,
    );
  }

  /// Factory constructor for wrapping existing content with skeleton effect
  factory AppSkeletonLoader.wrap({
    Key? key,
    required Widget child,
    Color? baseColor,
    Color? highlightColor,
    Duration animationDuration = const Duration(milliseconds: 1500),
    bool enabled = true,
  }) {
    return AppSkeletonLoader._(
      key: key,
      variant: AppSkeletonLoaderVariant.container,
      child: child,
      baseColor: baseColor,
      highlightColor: highlightColor,
      animationDuration: animationDuration,
      enabled: enabled,
    );
  }

  final AppSkeletonLoaderVariant variant;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration animationDuration;
  final Widget? child;
  final bool enabled;

  @override
  State<AppSkeletonLoader> createState() => _AppSkeletonLoaderState();
}

class _AppSkeletonLoaderState extends State<AppSkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: -2.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    if (widget.enabled) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(AppSkeletonLoader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      if (widget.enabled) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child ?? const SizedBox.shrink();
    }

    final baseColor = widget.baseColor ?? 
                     AppColors.neutral.resolve(context, shade: 100);
    final highlightColor = widget.highlightColor ?? 
                          AppColors.neutral.resolve(context, shade: 200);

    if (widget.child != null) {
      return _buildWrappedSkeleton(baseColor, highlightColor);
    }

    return _buildSkeletonShape(baseColor, highlightColor);
  }

  Widget _buildWrappedSkeleton(Color baseColor, Color highlightColor) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(_animation.value - 1.0, 0.0),
              end: Alignment(_animation.value + 1.0, 0.0),
              colors: [
                baseColor,
                highlightColor,
                baseColor,
              ],
              stops: const [0.0, 0.5, 1.0],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: widget.child,
        );
      },
    );
  }

  Widget _buildSkeletonShape(Color baseColor, Color highlightColor) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? AppRadius.sm.borderRadius,
            gradient: LinearGradient(
              begin: Alignment(_animation.value - 1.0, 0.0),
              end: Alignment(_animation.value + 1.0, 0.0),
              colors: [
                baseColor,
                highlightColor,
                baseColor,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}


/// Convenience widget for creating multiple skeleton elements
class AppSkeletonGroup extends StatelessWidget {
  const AppSkeletonGroup({
    super.key,
    required this.children,
    this.spacing = 8.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.enabled = true,
  });

  final List<Widget> children;
  final double spacing;
  final CrossAxisAlignment crossAxisAlignment;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: children
          .expand((child) => [child, SizedBox(height: spacing)])
          .take(children.length * 2 - 1)
          .toList(),
    );
  }
}

/// Pre-built skeleton patterns for common use cases
class AppSkeletonPatterns {
  /// List item skeleton pattern
  static Widget listItem({
    bool hasAvatar = true,
    bool hasSubtitle = true,
    bool enabled = true,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasAvatar) ...[
          AppSkeletonLoader.circle(
            diameter: 40.0,
            enabled: enabled,
          ),
          AppSpacing.md.gapH,
        ],
        Expanded(
          child: AppSkeletonGroup(
            spacing: 8.0,
            enabled: enabled,
            children: [
              AppSkeletonLoader.text(
                width: double.infinity,
                height: 16.0,
                enabled: enabled,
              ),
              if (hasSubtitle)
                AppSkeletonLoader.text(
                  width: 200.0,
                  height: 14.0,
                  enabled: enabled,
                ),
            ],
          ),
        ),
      ],
    );
  }

  /// Card skeleton pattern
  static Widget card({
    bool hasImage = true,
    int textLines = 2,
    bool enabled = true,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: AppRadius.md.borderRadius,
      ),
      child: AppSkeletonLoader.wrap(
        enabled: enabled,
        child: Padding(
          padding: AppSpacing.md.padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasImage) ...[
                AppSkeletonLoader.container(
                  width: double.infinity,
                  height: 120.0,
                  borderRadius: AppRadius.sm.borderRadius,
                  enabled: enabled,
                ),
                AppSpacing.md.gapV,
              ],
              ...List.generate(textLines, (index) => 
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: AppSkeletonLoader.text(
                    width: index == textLines - 1 ? 150.0 : double.infinity,
                    enabled: enabled,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Article skeleton pattern
  static Widget article({
    bool hasImage = true,
    int paragraphs = 3,
    bool enabled = true,
  }) {
    return AppSkeletonGroup(
      spacing: 16.0,
      enabled: enabled,
      children: [
        AppSkeletonLoader.text(
          width: double.infinity,
          height: 24.0,
          enabled: enabled,
        ),
        if (hasImage)
          AppSkeletonLoader.container(
            width: double.infinity,
            height: 200.0,
            enabled: enabled,
          ),
        ...List.generate(paragraphs, (index) =>
          AppSkeletonGroup(
            spacing: 8.0,
            enabled: enabled,
            children: [
              AppSkeletonLoader.text(width: double.infinity, enabled: enabled),
              AppSkeletonLoader.text(width: double.infinity, enabled: enabled),
              AppSkeletonLoader.text(width: 200.0, enabled: enabled),
            ],
          ),
        ),
      ],
    );
  }

  /// Profile skeleton pattern
  static Widget profile({
    bool enabled = true,
  }) {
    return AppSkeletonGroup(
      spacing: 16.0,
      enabled: enabled,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppSkeletonLoader.circle(
          diameter: 80.0,
          enabled: enabled,
        ),
        AppSkeletonLoader.text(
          width: 150.0,
          height: 20.0,
          enabled: enabled,
        ),
        AppSkeletonLoader.text(
          width: 100.0,
          height: 16.0,
          enabled: enabled,
        ),
      ],
    );
  }
}