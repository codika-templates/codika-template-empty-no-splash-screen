import 'package:flutter/material.dart';
import 'package:smooth_corner/smooth_corner.dart';

import 'app_radius.dart';

/// Defines the shape style used throughout the design system
enum AppShapeStyle {
  /// Traditional rounded rectangles with circular corners
  rounded,

  /// Modern squircle shapes with organic, smooth corners (Flutter 3.32+)
  squircle,
}

/// Configuration for shape behavior across the design system
class AppShapeConfig {
  /// The shape style used throughout the app
  final AppShapeStyle style;

  /// The smoothness of the squircle effect (0.0 to 1.0)
  /// Only used when style is AppShapeStyle.squircle
  /// 0.0 = rounded rectangle, 1.0 = perfect squircle
  final double smoothness;

  const AppShapeConfig({
    this.style = AppShapeStyle.squircle, // Default to modern squircle
    this.smoothness = 0.6, // Moderate squircle effect
  });

  /// Conservative configuration with subtle squircle
  static const AppShapeConfig conservative = AppShapeConfig(
    style: AppShapeStyle.squircle,
    smoothness: 0.3,
  );

  /// Aggressive configuration with strong squircle
  static const AppShapeConfig aggressive = AppShapeConfig(
    style: AppShapeStyle.squircle,
    smoothness: 0.8,
  );

  /// Traditional rounded rectangles
  static const AppShapeConfig rounded = AppShapeConfig(
    style: AppShapeStyle.rounded,
    smoothness: 0.0,
  );
}

/// Global shape configuration - change this to affect all shapes in the app
const AppShapeConfig _globalShapeConfig = AppShapeConfig();

/// Provides consistent shape borders throughout the design system
class AppShape {
  final AppRadius _radius;
  final AppShapeConfig _config;

  const AppShape._(this._radius, [this._config = _globalShapeConfig]);

  /// Extra small shape (4px radius equivalent)
  static const AppShape xs = AppShape._(AppRadius.xs);

  /// Small shape (8px radius equivalent)
  static const AppShape sm = AppShape._(AppRadius.sm);

  /// Medium shape (12px radius equivalent)
  static const AppShape md = AppShape._(AppRadius.md);

  /// Large shape (16px radius equivalent)
  static const AppShape lg = AppShape._(AppRadius.lg);

  /// Extra large shape (24px radius equivalent)
  static const AppShape xl = AppShape._(AppRadius.xl);

  /// Pill shape (999px radius equivalent)
  static const AppShape pill = AppShape._(AppRadius.pill);

  /// No shape (0px radius)
  static const AppShape none = AppShape._(AppRadius.none);

  /// Create a custom shape with specific configuration
  AppShape withConfig(AppShapeConfig config) {
    return AppShape._(_radius, config);
  }

  /// Create a shape with custom squircle smoothness
  AppShape withSmoothness(double smoothness) {
    return AppShape._(
      _radius,
      AppShapeConfig(
        style: _config.style,
        smoothness: smoothness.clamp(0.0, 1.0),
      ),
    );
  }

  /// Create a shape with rounded style regardless of global config
  AppShape asRounded() {
    return AppShape._(_radius, AppShapeConfig.rounded);
  }

  /// Create a shape with squircle style regardless of global config
  AppShape asSquircle([double? smoothness]) {
    return AppShape._(
      _radius,
      AppShapeConfig(
        style: AppShapeStyle.squircle,
        smoothness: smoothness ?? _config.smoothness,
      ),
    );
  }

  /// Get the ShapeBorder for use in decorations
  ShapeBorder get shapeBorder {
    switch (_config.style) {
      case AppShapeStyle.rounded:
        return RoundedRectangleBorder(borderRadius: _radius.borderRadius);
      case AppShapeStyle.squircle:
        return SmoothRectangleBorder(
          borderRadius: _radius.borderRadius,
          smoothness: _config.smoothness,
        );
    }
  }

  /// Get the ShapeBorder with custom border side
  ShapeBorder shapeBorderWith({
    Color? color,
    double? width,
    BorderStyle? style,
  }) {
    final side = BorderSide(
      color: color ?? Colors.transparent,
      width: width ?? 1.0,
      style: style ?? BorderStyle.solid,
    );

    switch (_config.style) {
      case AppShapeStyle.rounded:
        return RoundedRectangleBorder(
          borderRadius: _radius.borderRadius,
          side: side,
        );
      case AppShapeStyle.squircle:
        return SmoothRectangleBorder(
          borderRadius: _radius.borderRadius,
          smoothness: _config.smoothness,
          side: side,
        );
    }
  }

  /// Get the OutlinedBorder for buttons
  OutlinedBorder get outlinedBorder {
    switch (_config.style) {
      case AppShapeStyle.rounded:
        return RoundedRectangleBorder(borderRadius: _radius.borderRadius);
      case AppShapeStyle.squircle:
        return SmoothRectangleBorder(
          borderRadius: _radius.borderRadius,
          smoothness: _config.smoothness,
        );
    }
  }

  /// Get the OutlinedBorder with custom side for buttons
  OutlinedBorder outlinedBorderWith({
    Color? color,
    double? width,
    BorderStyle? style,
  }) {
    final side = BorderSide(
      color: color ?? Colors.transparent,
      width: width ?? 1.0,
      style: style ?? BorderStyle.solid,
    );

    switch (_config.style) {
      case AppShapeStyle.rounded:
        return RoundedRectangleBorder(
          borderRadius: _radius.borderRadius,
          side: side,
        );
      case AppShapeStyle.squircle:
        return SmoothRectangleBorder(
          borderRadius: _radius.borderRadius,
          smoothness: _config.smoothness,
          side: side,
        );
    }
  }

  /// Get BorderRadius for clipping (works with both styles)
  BorderRadius get borderRadius => _radius.borderRadius;

  /// Get the radius value
  double get radiusValue => _radius.value;

  /// Get the current configuration
  AppShapeConfig get config => _config;

  /// Check if this shape uses squircle
  bool get isSquircle => _config.style == AppShapeStyle.squircle;

  /// Check if this shape uses rounded corners
  bool get isRounded => _config.style == AppShapeStyle.rounded;
}

/// Extension to easily apply shapes to widgets
extension AppShapeExtension on Widget {
  /// Apply an AppShape to a Container-like widget
  Widget shaped(
    AppShape shape, {
    Color? color,
    Color? borderColor,
    double? borderWidth,
  }) {
    return Container(
      decoration: ShapeDecoration(
        shape: shape.shapeBorderWith(color: borderColor, width: borderWidth),
        color: color,
      ),
      child: ClipPath(
        clipper: ShapeBorderClipper(shape: shape.shapeBorder),
        child: this,
      ),
    );
  }
}

/// Utility functions for backward compatibility and migration
class AppShapeUtils {
  /// Get the global shape configuration
  static AppShapeConfig get globalConfig => _globalShapeConfig;

  /// Create a decoration with the specified shape
  static BoxDecoration decoration({
    required AppShape shape,
    Color? color,
    Color? borderColor,
    double? borderWidth,
    List<BoxShadow>? boxShadows,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: shape.borderRadius,
      border: borderColor != null
          ? Border.all(color: borderColor, width: borderWidth ?? 1.0)
          : null,
      boxShadow: boxShadows,
    );
  }

  /// Create a ShapeDecoration with the specified shape
  static ShapeDecoration shapeDecoration({
    required AppShape shape,
    Color? color,
    Color? borderColor,
    double? borderWidth,
    List<BoxShadow>? shadows,
  }) {
    return ShapeDecoration(
      color: color,
      shape: shape.shapeBorderWith(color: borderColor, width: borderWidth),
      shadows: shadows,
    );
  }
}
