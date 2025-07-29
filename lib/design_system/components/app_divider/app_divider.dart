import 'package:flutter/material.dart';

import '../../tokens/app_colors.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';

enum AppDividerVariant { solid, gradient, text, icon, dotted, dashed }

enum AppDividerOrientation { horizontal, vertical }

class AppDivider extends StatelessWidget {
  final AppDividerVariant variant;
  final AppDividerOrientation orientation;
  final double thickness;
  final Color? color;
  final EdgeInsetsGeometry padding;
  final double gradientFadeRatio;
  
  final String? text;
  final TextStyle? textStyle;
  final IconData? icon;
  final double? iconSize;
  
  final double? indent;
  final double? endIndent;

  const AppDivider._({
    required this.variant,
    this.orientation = AppDividerOrientation.horizontal,
    this.thickness = 1.0,
    this.color,
    this.padding = EdgeInsets.zero,
    this.gradientFadeRatio = 0.3,
    this.text,
    this.textStyle,
    this.icon,
    this.iconSize,
    this.indent,
    this.endIndent,
    super.key,
  });

  factory AppDivider.solid({
    Key? key,
    AppDividerOrientation orientation = AppDividerOrientation.horizontal,
    double thickness = 1.0,
    Color? color,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    double? indent,
    double? endIndent,
  }) {
    return AppDivider._(
      key: key,
      variant: AppDividerVariant.solid,
      orientation: orientation,
      thickness: thickness,
      color: color,
      padding: padding,
      indent: indent,
      endIndent: endIndent,
    );
  }

  factory AppDivider.gradient({
    Key? key,
    AppDividerOrientation orientation = AppDividerOrientation.horizontal,
    double thickness = 1.0,
    Color? color,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    double gradientFadeRatio = 0.3,
    double? indent,
    double? endIndent,
  }) {
    return AppDivider._(
      key: key,
      variant: AppDividerVariant.gradient,
      orientation: orientation,
      thickness: thickness,
      color: color,
      padding: padding,
      gradientFadeRatio: gradientFadeRatio,
      indent: indent,
      endIndent: endIndent,
    );
  }

  factory AppDivider.text({
    Key? key,
    required String text,
    AppDividerOrientation orientation = AppDividerOrientation.horizontal,
    double thickness = 1.0,
    Color? color,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    double gradientFadeRatio = 0.3,
    TextStyle? textStyle,
  }) {
    return AppDivider._(
      key: key,
      variant: AppDividerVariant.text,
      orientation: orientation,
      thickness: thickness,
      color: color,
      padding: padding,
      gradientFadeRatio: gradientFadeRatio,
      text: text,
      textStyle: textStyle,
    );
  }

  factory AppDivider.icon({
    Key? key,
    required IconData icon,
    AppDividerOrientation orientation = AppDividerOrientation.horizontal,
    double thickness = 1.0,
    Color? color,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    double gradientFadeRatio = 0.3,
    double? iconSize,
  }) {
    return AppDivider._(
      key: key,
      variant: AppDividerVariant.icon,
      orientation: orientation,
      thickness: thickness,
      color: color,
      padding: padding,
      gradientFadeRatio: gradientFadeRatio,
      icon: icon,
      iconSize: iconSize,
    );
  }

  factory AppDivider.dotted({
    Key? key,
    AppDividerOrientation orientation = AppDividerOrientation.horizontal,
    double thickness = 1.0,
    Color? color,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    double? indent,
    double? endIndent,
  }) {
    return AppDivider._(
      key: key,
      variant: AppDividerVariant.dotted,
      orientation: orientation,
      thickness: thickness,
      color: color,
      padding: padding,
      indent: indent,
      endIndent: endIndent,
    );
  }

  factory AppDivider.dashed({
    Key? key,
    AppDividerOrientation orientation = AppDividerOrientation.horizontal,
    double thickness = 1.0,
    Color? color,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    double? indent,
    double? endIndent,
  }) {
    return AppDivider._(
      key: key,
      variant: AppDividerVariant.dashed,
      orientation: orientation,
      thickness: thickness,
      color: color,
      padding: padding,
      indent: indent,
      endIndent: endIndent,
    );
  }

  Color _getEffectiveColor(BuildContext context) {
    return color ?? context.dividerColor;
  }

  Widget _buildSolid(BuildContext context) {
    final effectiveColor = _getEffectiveColor(context);
    
    if (orientation == AppDividerOrientation.vertical) {
      return Container(
        width: thickness,
        height: double.infinity,
        margin: EdgeInsets.only(
          top: indent ?? 0,
          bottom: endIndent ?? 0,
        ),
        color: effectiveColor,
      );
    }
    
    return Container(
      height: thickness,
      width: double.infinity,
      margin: EdgeInsets.only(
        left: indent ?? 0,
        right: endIndent ?? 0,
      ),
      color: effectiveColor,
    );
  }

  Widget _buildGradient(BuildContext context) {
    final effectiveColor = _getEffectiveColor(context);
    final gradientColors = [
      Colors.transparent,
      effectiveColor.withValues(alpha: 1 - gradientFadeRatio),
      effectiveColor,
      effectiveColor.withValues(alpha: 1 - gradientFadeRatio),
      Colors.transparent,
    ];
    
    if (orientation == AppDividerOrientation.vertical) {
      return Container(
        width: thickness,
        height: double.infinity,
        margin: EdgeInsets.only(
          top: indent ?? 0,
          bottom: endIndent ?? 0,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
            stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
          ),
        ),
      );
    }
    
    return Container(
      height: thickness,
      width: double.infinity,
      margin: EdgeInsets.only(
        left: indent ?? 0,
        right: endIndent ?? 0,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: gradientColors,
          stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
        ),
      ),
    );
  }

  Widget _buildTextDivider(BuildContext context) {
    if (text == null || orientation == AppDividerOrientation.vertical) {
      return _buildGradient(context);
    }

    final effectiveColor = _getEffectiveColor(context);
    final effectiveTextStyle = textStyle ?? 
        AppTextStyle.labelLarge.style.copyWith(
          color: effectiveColor,
          fontSize: 14,
        );

    final gradientColors = [
      Colors.transparent,
      effectiveColor.withValues(alpha: 1 - gradientFadeRatio),
      effectiveColor,
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: thickness,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: gradientColors,
              ),
            ),
          ),
        ),
        Padding(
          padding: AppSpacing.md.paddingHorizontal,
          child: Text(
            text!,
            style: effectiveTextStyle,
          ),
        ),
        Expanded(
          child: Container(
            height: thickness,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: gradientColors,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconDivider(BuildContext context) {
    if (icon == null || orientation == AppDividerOrientation.vertical) {
      return _buildGradient(context);
    }

    final effectiveColor = _getEffectiveColor(context);
    final effectiveIconSize = iconSize ?? 18.0;

    final gradientColors = [
      Colors.transparent,
      effectiveColor.withValues(alpha: 1 - gradientFadeRatio),
      effectiveColor,
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: thickness,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: gradientColors,
              ),
            ),
          ),
        ),
        Padding(
          padding: AppSpacing.md.paddingHorizontal,
          child: Icon(
            icon!,
            size: effectiveIconSize,
            color: effectiveColor,
          ),
        ),
        Expanded(
          child: Container(
            height: thickness,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: gradientColors,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDotted(BuildContext context) {
    final effectiveColor = _getEffectiveColor(context);
    
    return CustomPaint(
      painter: _DottedLinePainter(
        color: effectiveColor,
        thickness: thickness,
        orientation: orientation,
        indent: indent ?? 0,
        endIndent: endIndent ?? 0,
      ),
      child: orientation == AppDividerOrientation.vertical
          ? SizedBox(width: thickness, height: double.infinity)
          : SizedBox(height: thickness, width: double.infinity),
    );
  }

  Widget _buildDashed(BuildContext context) {
    final effectiveColor = _getEffectiveColor(context);
    
    return CustomPaint(
      painter: _DashedLinePainter(
        color: effectiveColor,
        thickness: thickness,
        orientation: orientation,
        indent: indent ?? 0,
        endIndent: endIndent ?? 0,
      ),
      child: orientation == AppDividerOrientation.vertical
          ? SizedBox(width: thickness, height: double.infinity)
          : SizedBox(height: thickness, width: double.infinity),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget divider;
    
    switch (variant) {
      case AppDividerVariant.solid:
        divider = _buildSolid(context);
        break;
      case AppDividerVariant.gradient:
        divider = _buildGradient(context);
        break;
      case AppDividerVariant.text:
        divider = _buildTextDivider(context);
        break;
      case AppDividerVariant.icon:
        divider = _buildIconDivider(context);
        break;
      case AppDividerVariant.dotted:
        divider = _buildDotted(context);
        break;
      case AppDividerVariant.dashed:
        divider = _buildDashed(context);
        break;
    }

    return Padding(
      padding: padding,
      child: divider,
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final Color color;
  final double thickness;
  final AppDividerOrientation orientation;
  final double indent;
  final double endIndent;

  _DottedLinePainter({
    required this.color,
    required this.thickness,
    required this.orientation,
    required this.indent,
    required this.endIndent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    const double dashLength = 4.0;
    const double dashSpace = 4.0;

    if (orientation == AppDividerOrientation.horizontal) {
      final y = size.height / 2;
      final startX = indent;
      final endX = size.width - endIndent;
      
      double currentX = startX;
      while (currentX < endX) {
        final nextX = (currentX + dashLength).clamp(startX, endX);
        canvas.drawCircle(Offset(currentX + (nextX - currentX) / 2, y), thickness / 2, paint);
        currentX += dashLength + dashSpace;
      }
    } else {
      final x = size.width / 2;
      final startY = indent;
      final endY = size.height - endIndent;
      
      double currentY = startY;
      while (currentY < endY) {
        final nextY = (currentY + dashLength).clamp(startY, endY);
        canvas.drawCircle(Offset(x, currentY + (nextY - currentY) / 2), thickness / 2, paint);
        currentY += dashLength + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DashedLinePainter extends CustomPainter {
  final Color color;
  final double thickness;
  final AppDividerOrientation orientation;
  final double indent;
  final double endIndent;

  _DashedLinePainter({
    required this.color,
    required this.thickness,
    required this.orientation,
    required this.indent,
    required this.endIndent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    const double dashLength = 8.0;
    const double dashSpace = 4.0;

    if (orientation == AppDividerOrientation.horizontal) {
      final y = size.height / 2;
      final startX = indent;
      final endX = size.width - endIndent;
      
      double currentX = startX;
      while (currentX < endX) {
        final nextX = (currentX + dashLength).clamp(startX, endX);
        canvas.drawLine(Offset(currentX, y), Offset(nextX, y), paint);
        currentX += dashLength + dashSpace;
      }
    } else {
      final x = size.width / 2;
      final startY = indent;
      final endY = size.height - endIndent;
      
      double currentY = startY;
      while (currentY < endY) {
        final nextY = (currentY + dashLength).clamp(startY, endY);
        canvas.drawLine(Offset(x, currentY), Offset(x, nextY), paint);
        currentY += dashLength + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}