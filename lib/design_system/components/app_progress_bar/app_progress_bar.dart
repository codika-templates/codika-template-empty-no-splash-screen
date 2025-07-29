import 'package:flutter/material.dart';
import '../../tokens/app_colors.dart';
import '../../tokens/app_radius.dart';
import '../../tokens/app_spacing.dart';

/// Progress bar component with multiple variants for different use cases.
///
/// Provides consistent progress indication that integrates with the design system's
/// color and spacing tokens. Supports both determinate and indeterminate progress,
/// with timer functionality for time-bound operations.
enum AppProgressBarVariant {
  linear,
  timer,
  stepped,
}

/// Orientation options for progress bars
enum AppProgressBarOrientation {
  horizontal,
  vertical,
}

class AppProgressBar extends StatefulWidget {
  const AppProgressBar._({
    super.key,
    required this.variant,
    required this.orientation,
    this.value,
    this.duration,
    this.delay = Duration.zero,
    this.thickness = 4.0,
    this.backgroundColor,
    this.progressColor,
    this.borderRadius,
    this.padding,
    this.onComplete,
    this.isAnimated = true,
    this.steps,
    this.currentStep,
  });

  /// Factory constructor for linear progress bar
  factory AppProgressBar.linear({
    Key? key,
    double? value,
    AppProgressBarOrientation orientation = AppProgressBarOrientation.horizontal,
    double thickness = 4.0,
    Color? backgroundColor,
    Color? progressColor,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    bool isAnimated = true,
  }) {
    return AppProgressBar._(
      key: key,
      variant: AppProgressBarVariant.linear,
      orientation: orientation,
      value: value,
      thickness: thickness,
      backgroundColor: backgroundColor,
      progressColor: progressColor,
      borderRadius: borderRadius,
      padding: padding,
      isAnimated: isAnimated,
    );
  }

  /// Factory constructor for timer progress bar
  factory AppProgressBar.timer({
    Key? key,
    required Duration duration,
    Duration delay = Duration.zero,
    AppProgressBarOrientation orientation = AppProgressBarOrientation.horizontal,
    double thickness = 4.0,
    Color? backgroundColor,
    Color? progressColor,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    VoidCallback? onComplete,
  }) {
    return AppProgressBar._(
      key: key,
      variant: AppProgressBarVariant.timer,
      orientation: orientation,
      duration: duration,
      delay: delay,
      thickness: thickness,
      backgroundColor: backgroundColor,
      progressColor: progressColor,
      borderRadius: borderRadius,
      padding: padding,
      onComplete: onComplete,
      isAnimated: true,
    );
  }

  /// Factory constructor for stepped progress bar
  factory AppProgressBar.stepped({
    Key? key,
    required int steps,
    required int currentStep,
    AppProgressBarOrientation orientation = AppProgressBarOrientation.horizontal,
    double thickness = 4.0,
    Color? backgroundColor,
    Color? progressColor,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    bool isAnimated = true,
  }) {
    return AppProgressBar._(
      key: key,
      variant: AppProgressBarVariant.stepped,
      orientation: orientation,
      steps: steps,
      currentStep: currentStep,
      thickness: thickness,
      backgroundColor: backgroundColor,
      progressColor: progressColor,
      borderRadius: borderRadius,
      padding: padding,
      isAnimated: isAnimated,
    );
  }

  final AppProgressBarVariant variant;
  final AppProgressBarOrientation orientation;
  final double? value;
  final Duration? duration;
  final Duration delay;
  final double thickness;
  final Color? backgroundColor;
  final Color? progressColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onComplete;
  final bool isAnimated;
  final int? steps;
  final int? currentStep;

  @override
  State<AppProgressBar> createState() => _AppProgressBarState();
}

class _AppProgressBarState extends State<AppProgressBar>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  @override
  void didUpdateWidget(AppProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration ||
        widget.delay != oldWidget.delay ||
        widget.currentStep != oldWidget.currentStep) {
      _setupAnimation();
    }
  }

  void _setupAnimation() {
    _controller?.dispose();

    if (widget.variant == AppProgressBarVariant.timer && widget.duration != null) {
      _controller = AnimationController(
        duration: widget.duration!,
        vsync: this,
      );

      _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller!, curve: Curves.linear),
      );

      _controller!.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete?.call();
        }
      });

      // Start animation with delay
      Future.delayed(widget.delay, () {
        if (mounted) {
          _controller!.forward();
        }
      });
    } else if (widget.variant == AppProgressBarVariant.stepped && widget.isAnimated) {
      _controller = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      );

      final targetValue = widget.steps != null && widget.currentStep != null
          ? (widget.currentStep! / widget.steps!).clamp(0.0, 1.0)
          : 0.0;

      _animation = Tween<double>(
        begin: _animation?.value ?? 0.0,
        end: targetValue,
      ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));

      _controller!.forward();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = widget.backgroundColor ?? 
                                    Theme.of(context).dividerColor;
    final effectiveProgressColor = widget.progressColor ?? 
                                  AppColors.primary.resolve(context);
    final effectiveBorderRadius = widget.borderRadius ?? 
                                 AppRadius.sm.borderRadius;
    final effectivePadding = widget.padding ?? 
                            AppSpacing.sm.paddingVertical;

    return Padding(
      padding: effectivePadding,
      child: _buildProgressBar(
        context,
        effectiveBackgroundColor,
        effectiveProgressColor,
        effectiveBorderRadius,
      ),
    );
  }

  Widget _buildProgressBar(
    BuildContext context,
    Color backgroundColor,
    Color progressColor,
    BorderRadius borderRadius,
  ) {
    switch (widget.variant) {
      case AppProgressBarVariant.linear:
        return _buildLinearProgress(backgroundColor, progressColor, borderRadius);
      case AppProgressBarVariant.timer:
        return _buildTimerProgress(backgroundColor, progressColor, borderRadius);
      case AppProgressBarVariant.stepped:
        return _buildSteppedProgress(backgroundColor, progressColor, borderRadius);
    }
  }

  Widget _buildLinearProgress(
    Color backgroundColor,
    Color progressColor,
    BorderRadius borderRadius,
  ) {
    if (widget.orientation == AppProgressBarOrientation.vertical) {
      return SizedBox(
        width: widget.thickness,
        height: double.infinity,
        child: LinearProgressIndicator(
          value: widget.value,
          backgroundColor: backgroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(progressColor),
        ),
      );
    }

    return SizedBox(
      height: widget.thickness,
      child: LinearProgressIndicator(
        value: widget.value,
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color>(progressColor),
      ),
    );
  }

  Widget _buildTimerProgress(
    Color backgroundColor,
    Color progressColor,
    BorderRadius borderRadius,
  ) {
    return AnimatedBuilder(
      animation: _animation ?? const AlwaysStoppedAnimation(0.0),
      builder: (context, child) {
        return _buildCustomProgress(
          backgroundColor,
          progressColor,
          borderRadius,
          _animation?.value ?? 0.0,
        );
      },
    );
  }

  Widget _buildSteppedProgress(
    Color backgroundColor,
    Color progressColor,
    BorderRadius borderRadius,
  ) {
    double progress = 0.0;
    if (widget.steps != null && widget.currentStep != null) {
      progress = (widget.currentStep! / widget.steps!).clamp(0.0, 1.0);
    }

    if (widget.isAnimated && _animation != null) {
      return AnimatedBuilder(
        animation: _animation!,
        builder: (context, child) {
          return _buildCustomProgress(
            backgroundColor,
            progressColor,
            borderRadius,
            _animation!.value,
          );
        },
      );
    }

    return _buildCustomProgress(
      backgroundColor,
      progressColor,
      borderRadius,
      progress,
    );
  }

  Widget _buildCustomProgress(
    Color backgroundColor,
    Color progressColor,
    BorderRadius borderRadius,
    double progress,
  ) {
    if (widget.orientation == AppProgressBarOrientation.vertical) {
      return SizedBox(
        width: widget.thickness,
        height: double.infinity,
        child: CustomPaint(
          painter: _VerticalProgressPainter(
            progress: progress,
            backgroundColor: backgroundColor,
            progressColor: progressColor,
            borderRadius: borderRadius,
          ),
        ),
      );
    }

    return SizedBox(
      height: widget.thickness,
      child: CustomPaint(
        painter: _HorizontalProgressPainter(
          progress: progress,
          backgroundColor: backgroundColor,
          progressColor: progressColor,
          borderRadius: borderRadius,
        ),
        size: Size.infinite,
      ),
    );
  }
}

/// Custom painter for horizontal progress bars
class _HorizontalProgressPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;
  final BorderRadius borderRadius;

  _HorizontalProgressPainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.fill;

    final backgroundRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final backgroundRRect = RRect.fromRectAndCorners(
      backgroundRect,
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
    );

    canvas.drawRRect(backgroundRRect, backgroundPaint);

    if (progress > 0) {
      final progressWidth = size.width * progress;
      final progressRect = Rect.fromLTWH(0, 0, progressWidth, size.height);
      final progressRRect = RRect.fromRectAndCorners(
        progressRect,
        topLeft: borderRadius.topLeft,
        topRight: progress >= 1.0 ? borderRadius.topRight : Radius.zero,
        bottomLeft: borderRadius.bottomLeft,
        bottomRight: progress >= 1.0 ? borderRadius.bottomRight : Radius.zero,
      );

      canvas.drawRRect(progressRRect, progressPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// Custom painter for vertical progress bars
class _VerticalProgressPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;
  final BorderRadius borderRadius;

  _VerticalProgressPainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.fill;

    final backgroundRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final backgroundRRect = RRect.fromRectAndCorners(
      backgroundRect,
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
    );

    canvas.drawRRect(backgroundRRect, backgroundPaint);

    if (progress > 0) {
      final progressHeight = size.height * progress;
      final progressY = size.height - progressHeight;
      final progressRect = Rect.fromLTWH(0, progressY, size.width, progressHeight);
      final progressRRect = RRect.fromRectAndCorners(
        progressRect,
        topLeft: progress >= 1.0 ? borderRadius.topLeft : Radius.zero,
        topRight: progress >= 1.0 ? borderRadius.topRight : Radius.zero,
        bottomLeft: borderRadius.bottomLeft,
        bottomRight: borderRadius.bottomRight,
      );

      canvas.drawRRect(progressRRect, progressPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}