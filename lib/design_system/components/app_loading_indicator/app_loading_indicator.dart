import 'package:flutter/material.dart';
import '../../tokens/app_colors.dart';

/// Loading indicator component with multiple animation variants.
///
/// Provides consistent loading animations that integrate with the design system's
/// color tokens and theming. All variants are optimized for performance and
/// accessibility.
enum AppLoadingIndicatorVariant {
  circular,
  dots,
  pulse,
  bars,
}

/// Size presets for loading indicators
enum AppLoadingIndicatorSize {
  small(16.0),
  medium(24.0),
  large(32.0),
  extraLarge(48.0);

  const AppLoadingIndicatorSize(this.value);
  final double value;
}

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator._({
    super.key,
    required this.variant,
    required this.size,
    this.color,
    this.strokeWidth,
  });

  /// Factory constructor for circular progress indicator
  factory AppLoadingIndicator.circular({
    Key? key,
    AppLoadingIndicatorSize size = AppLoadingIndicatorSize.medium,
    Color? color,
    double? strokeWidth,
  }) {
    return AppLoadingIndicator._(
      key: key,
      variant: AppLoadingIndicatorVariant.circular,
      size: size,
      color: color,
      strokeWidth: strokeWidth ?? 2.0,
    );
  }

  /// Factory constructor for animated dots indicator
  factory AppLoadingIndicator.dots({
    Key? key,
    AppLoadingIndicatorSize size = AppLoadingIndicatorSize.medium,
    Color? color,
  }) {
    return AppLoadingIndicator._(
      key: key,
      variant: AppLoadingIndicatorVariant.dots,
      size: size,
      color: color,
    );
  }

  /// Factory constructor for pulsing circle indicator
  factory AppLoadingIndicator.pulse({
    Key? key,
    AppLoadingIndicatorSize size = AppLoadingIndicatorSize.medium,
    Color? color,
  }) {
    return AppLoadingIndicator._(
      key: key,
      variant: AppLoadingIndicatorVariant.pulse,
      size: size,
      color: color,
    );
  }

  /// Factory constructor for animated bars indicator
  factory AppLoadingIndicator.bars({
    Key? key,
    AppLoadingIndicatorSize size = AppLoadingIndicatorSize.medium,
    Color? color,
  }) {
    return AppLoadingIndicator._(
      key: key,
      variant: AppLoadingIndicatorVariant.bars,
      size: size,
      color: color,
    );
  }

  final AppLoadingIndicatorVariant variant;
  final AppLoadingIndicatorSize size;
  final Color? color;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.primary.resolve(context);

    return SizedBox.square(
      dimension: size.value,
      child: _buildIndicator(context, effectiveColor),
    );
  }

  Widget _buildIndicator(BuildContext context, Color effectiveColor) {
    switch (variant) {
      case AppLoadingIndicatorVariant.circular:
        return CircularProgressIndicator(
          strokeWidth: strokeWidth!,
          valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
        );
      case AppLoadingIndicatorVariant.dots:
        return _DotsLoadingIndicator(
          color: effectiveColor,
          size: size.value,
        );
      case AppLoadingIndicatorVariant.pulse:        
        return _PulseLoadingIndicator(
          color: effectiveColor,
          size: size.value,
        );
      case AppLoadingIndicatorVariant.bars:
        return _BarsLoadingIndicator(
          color: effectiveColor,
          size: size.value,
        );
    }
  }
}

/// Three dots loading animation
class _DotsLoadingIndicator extends StatefulWidget {
  const _DotsLoadingIndicator({
    required this.color,
    required this.size,
  });

  final Color color;
  final double size;

  @override
  State<_DotsLoadingIndicator> createState() => _DotsLoadingIndicatorState();
}

class _DotsLoadingIndicatorState extends State<_DotsLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            final delay = index * 0.2;
            final animation = Tween<double>(begin: 0.3, end: 1.0).animate(
              CurvedAnimation(
                parent: _controller,
                curve: Interval(
                  delay,
                  0.6 + delay,
                  curve: Curves.easeInOut,
                ),
              ),
            );

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.size * 0.05),
              child: Transform.scale(
                scale: animation.value,
                child: Container(
                  width: widget.size * 0.2,
                  height: widget.size * 0.2,
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

/// Pulsing circle loading animation
class _PulseLoadingIndicator extends StatefulWidget {
  const _PulseLoadingIndicator({
    required this.color,
    required this.size,
  });

  final Color color;
  final double size;

  @override
  State<_PulseLoadingIndicator> createState() => _PulseLoadingIndicatorState();
}

class _PulseLoadingIndicatorState extends State<_PulseLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: widget.color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Animated bars loading indicator
class _BarsLoadingIndicator extends StatefulWidget {
  const _BarsLoadingIndicator({
    required this.color,
    required this.size,
  });

  final Color color;
  final double size;

  @override
  State<_BarsLoadingIndicator> createState() => _BarsLoadingIndicatorState();
}

class _BarsLoadingIndicatorState extends State<_BarsLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(4, (index) {
            final delay = index * 0.1;
            final animation = Tween<double>(begin: 0.3, end: 1.0).animate(
              CurvedAnimation(
                parent: _controller,
                curve: Interval(
                  delay,
                  0.5 + delay,
                  curve: Curves.easeInOut,
                ),
              ),
            );

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.size * 0.02),
              child: Container(
                width: widget.size * 0.15,
                height: widget.size * animation.value,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(widget.size * 0.02),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}