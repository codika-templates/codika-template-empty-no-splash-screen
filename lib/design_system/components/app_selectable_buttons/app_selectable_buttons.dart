import 'package:flutter/material.dart';

import '../../services/interaction_feedback_service.dart';
import '../../theme/app_theme_extension.dart';
import '../../tokens/app_colors.dart';
import '../../tokens/app_shapes.dart';
import '../../tokens/app_spacing.dart';
import '../../utils/widgets/app_conditional_wrapper.dart';

enum AppSelectableButtonStyle { primary, secondary, tertiary }


(Color, Color) _getSelectableButtonColors(
  BuildContext context,
  AppSelectableButtonStyle style, {
  bool isSelected = false,
}) {
  final theme = Theme.of(context);
  final appTheme = context.appTheme;

  Color backgroundColor, foregroundColor;

  switch (style) {
    case AppSelectableButtonStyle.primary:
      if (isSelected) {
        backgroundColor = theme.colorScheme.primary;
        foregroundColor = theme.colorScheme.onPrimary;
      } else {
        backgroundColor = theme.colorScheme.surface;
        foregroundColor = appTheme.border;
      }
      break;

    case AppSelectableButtonStyle.secondary:
      if (isSelected) {
        backgroundColor = theme.colorScheme.surfaceContainerHighest;
        foregroundColor = theme.colorScheme.primary;
      } else {
        backgroundColor = theme.colorScheme.surface;
        foregroundColor = appTheme.border;
      }
      break;

    case AppSelectableButtonStyle.tertiary:
      if (isSelected) {
        backgroundColor = AppColors.success.resolve(context, shade: 500);
        foregroundColor = Colors.white;
      } else {
        backgroundColor = theme.colorScheme.surface;
        foregroundColor = appTheme.border;
      }
      break;
  }

  return (backgroundColor, foregroundColor);
}

class AppCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final AppSelectableButtonStyle style;
  final FeedbackType? feedbackType;
  final bool tristate;
  final String? semanticLabel;

  const AppCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.style = AppSelectableButtonStyle.primary,
    this.feedbackType,
    this.tristate = false,
    this.semanticLabel,
  });

  factory AppCheckbox.primary({
    Key? key,
    required bool value,
    ValueChanged<bool?>? onChanged,
    FeedbackType? feedbackType,
    bool tristate = false,
    String? semanticLabel,
  }) {
    return AppCheckbox(
      key: key,
      value: value,
      onChanged: onChanged,
      style: AppSelectableButtonStyle.primary,
      feedbackType: feedbackType,
      tristate: tristate,
      semanticLabel: semanticLabel,
    );
  }

  factory AppCheckbox.secondary({
    Key? key,
    required bool value,
    ValueChanged<bool?>? onChanged,
    FeedbackType? feedbackType,
    bool tristate = false,
    String? semanticLabel,
  }) {
    return AppCheckbox(
      key: key,
      value: value,
      onChanged: onChanged,
      style: AppSelectableButtonStyle.secondary,
      feedbackType: feedbackType,
      tristate: tristate,
      semanticLabel: semanticLabel,
    );
  }

  factory AppCheckbox.tertiary({
    Key? key,
    required bool value,
    ValueChanged<bool?>? onChanged,
    FeedbackType? feedbackType,
    bool tristate = false,
    String? semanticLabel,
  }) {
    return AppCheckbox(
      key: key,
      value: value,
      onChanged: onChanged,
      style: AppSelectableButtonStyle.tertiary,
      feedbackType: feedbackType,
      tristate: tristate,
      semanticLabel: semanticLabel,
    );
  }

  VoidCallback? get _wrappedOnChanged {
    if (onChanged == null) return null;
    return () {
      final effectiveFeedbackType = feedbackType ?? FeedbackType.selection;
      feedbackService.haptic(effectiveFeedbackType);
      onChanged!(!value);
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (backgroundColor, foregroundColor) = _getSelectableButtonColors(
      context,
      style,
      isSelected: value,
    );

    const size = 20.0;
    const borderWidth = 2.0;

    return AppConditionalWrapper(
      condition: semanticLabel != null,
      wrapper: (child) => Semantics(
        label: semanticLabel!,
        checked: value,
        child: child,
      ),
      child: SizedBox(
        width: size + 8, // Add padding for touch target
        height: size + 8,
        child: InkWell(
          onTap: _wrappedOnChanged,
          borderRadius: AppShape.xs.borderRadius,
          child: Container(
            width: size,
            height: size,
            margin: AppSpacing.xs.padding,
            decoration: ShapeDecoration(
              shape: AppShape.xs.shapeBorderWith(
                color: value ? backgroundColor : foregroundColor,
                width: borderWidth,
              ),
              color: value ? backgroundColor : Colors.transparent,
            ),
            child: value
                ? Icon(
                    Icons.check,
                    size: size * 0.6,
                    color: style == AppSelectableButtonStyle.primary
                        ? theme.colorScheme.onPrimary
                        : style == AppSelectableButtonStyle.secondary
                            ? theme.colorScheme.primary
                            : Colors.white,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

class AppRadioButton<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final AppSelectableButtonStyle style;
  final FeedbackType? feedbackType;
  final String? semanticLabel;

  const AppRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    this.onChanged,
    this.style = AppSelectableButtonStyle.primary,
    this.feedbackType,
    this.semanticLabel,
  });

  factory AppRadioButton.primary({
    Key? key,
    required T value,
    required T? groupValue,
    ValueChanged<T?>? onChanged,
    FeedbackType? feedbackType,
    String? semanticLabel,
  }) {
    return AppRadioButton<T>(
      key: key,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      style: AppSelectableButtonStyle.primary,
      feedbackType: feedbackType,
      semanticLabel: semanticLabel,
    );
  }

  factory AppRadioButton.secondary({
    Key? key,
    required T value,
    required T? groupValue,
    ValueChanged<T?>? onChanged,
    FeedbackType? feedbackType,
    String? semanticLabel,
  }) {
    return AppRadioButton<T>(
      key: key,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      style: AppSelectableButtonStyle.secondary,
      feedbackType: feedbackType,
      semanticLabel: semanticLabel,
    );
  }

  factory AppRadioButton.tertiary({
    Key? key,
    required T value,
    required T? groupValue,
    ValueChanged<T?>? onChanged,
    FeedbackType? feedbackType,
    String? semanticLabel,
  }) {
    return AppRadioButton<T>(
      key: key,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      style: AppSelectableButtonStyle.tertiary,
      feedbackType: feedbackType,
      semanticLabel: semanticLabel,
    );
  }

  bool get isSelected => value == groupValue;

  VoidCallback? get _wrappedOnChanged {
    if (onChanged == null) return null;
    return () {
      final effectiveFeedbackType = feedbackType ?? FeedbackType.selection;
      feedbackService.haptic(effectiveFeedbackType);
      onChanged!(value);
    };
  }

  @override
  Widget build(BuildContext context) {
    final (backgroundColor, foregroundColor) = _getSelectableButtonColors(
      context,
      style,
      isSelected: isSelected,
    );

    const size = 20.0;
    const borderWidth = 2.0;
    const innerRatio = 0.5;

    return AppConditionalWrapper(
      condition: semanticLabel != null,
      wrapper: (child) => Semantics(
        label: semanticLabel!,
        checked: isSelected,
        inMutuallyExclusiveGroup: true,
        child: child,
      ),
      child: SizedBox(
        width: size + 8, // Add padding for touch target
        height: size + 8,
        child: InkWell(
          onTap: _wrappedOnChanged,
          borderRadius: BorderRadius.circular(size),
          child: Container(
            width: size,
            height: size,
            margin: AppSpacing.xs.padding,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? backgroundColor : foregroundColor,
                width: borderWidth,
              ),
              color: isSelected ? backgroundColor : Colors.transparent,
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: size * innerRatio,
                      height: size * innerRatio,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: style == AppSelectableButtonStyle.primary
                            ? Theme.of(context).colorScheme.onPrimary
                            : style == AppSelectableButtonStyle.secondary
                                ? Theme.of(context).colorScheme.primary
                                : Colors.white,
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

class AppRadioListTile<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final Widget title;
  final Widget? subtitle;
  final AppSelectableButtonStyle style;
  final FeedbackType? feedbackType;
  final bool controlAffinity;
  final EdgeInsetsGeometry? contentPadding;

  const AppRadioListTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.title,
    this.onChanged,
    this.subtitle,
    this.style = AppSelectableButtonStyle.primary,
    this.feedbackType,
    this.controlAffinity = false,
    this.contentPadding,
  });

  bool get isSelected => value == groupValue;

  VoidCallback? get _wrappedOnChanged {
    if (onChanged == null) return null;
    return () {
      final effectiveFeedbackType = feedbackType ?? FeedbackType.selection;
      feedbackService.haptic(effectiveFeedbackType);
      onChanged!(value);
    };
  }

  @override
  Widget build(BuildContext context) {
    final radioButton = AppRadioButton<T>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      style: style,
      feedbackType: feedbackType,
    );

    final titleWidget = DefaultTextStyle.merge(
      style: Theme.of(context).textTheme.bodyLarge,
      child: title,
    );

    final subtitleWidget = subtitle != null
        ? DefaultTextStyle.merge(
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
            child: subtitle!,
          )
        : null;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        titleWidget,
        if (subtitleWidget != null) ...[
          AppSpacing.xs.gapV,
          subtitleWidget,
        ],
      ],
    );

    return InkWell(
      onTap: _wrappedOnChanged,
      child: Padding(
        padding: contentPadding ?? AppSpacing.md.padding,
        child: Row(
          children: controlAffinity
              ? [
                  Expanded(child: content),
                  AppSpacing.md.gapH,
                  radioButton,
                ]
              : [
                  radioButton,
                  AppSpacing.md.gapH,
                  Expanded(child: content),
                ],
        ),
      ),
    );
  }
}

class AppToggleSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final AppSelectableButtonStyle style;
  final FeedbackType? feedbackType;
  final String? semanticLabel;
  final double? width;
  final double? height;

  const AppToggleSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.style = AppSelectableButtonStyle.primary,
    this.feedbackType,
    this.semanticLabel,
    this.width,
    this.height,
  });

  factory AppToggleSwitch.primary({
    Key? key,
    required bool value,
    ValueChanged<bool>? onChanged,
    FeedbackType? feedbackType,
    String? semanticLabel,
    double? width,
    double? height,
  }) {
    return AppToggleSwitch(
      key: key,
      value: value,
      onChanged: onChanged,
      style: AppSelectableButtonStyle.primary,
      feedbackType: feedbackType,
      semanticLabel: semanticLabel,
      width: width,
      height: height,
    );
  }

  factory AppToggleSwitch.secondary({
    Key? key,
    required bool value,
    ValueChanged<bool>? onChanged,
    FeedbackType? feedbackType,
    String? semanticLabel,
    double? width,
    double? height,
  }) {
    return AppToggleSwitch(
      key: key,
      value: value,
      onChanged: onChanged,
      style: AppSelectableButtonStyle.secondary,
      feedbackType: feedbackType,
      semanticLabel: semanticLabel,
      width: width,
      height: height,
    );
  }

  factory AppToggleSwitch.tertiary({
    Key? key,
    required bool value,
    ValueChanged<bool>? onChanged,
    FeedbackType? feedbackType,
    String? semanticLabel,
    double? width,
    double? height,
  }) {
    return AppToggleSwitch(
      key: key,
      value: value,
      onChanged: onChanged,
      style: AppSelectableButtonStyle.tertiary,
      feedbackType: feedbackType,
      semanticLabel: semanticLabel,
      width: width,
      height: height,
    );
  }

  @override
  State<AppToggleSwitch> createState() => _AppToggleSwitchState();
}

class _AppToggleSwitchState extends State<AppToggleSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _thumbAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _thumbAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    if (widget.value) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(AppToggleSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  (Color, Color) _getToggleColors(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme = context.appTheme;

    Color activeColor, inactiveColor;

    switch (widget.style) {
      case AppSelectableButtonStyle.primary:
        activeColor = theme.colorScheme.primary;
        inactiveColor = appTheme.disabled;
        break;
      case AppSelectableButtonStyle.secondary:
        activeColor = theme.colorScheme.surfaceContainerHighest;
        inactiveColor = appTheme.disabled;
        break;
      case AppSelectableButtonStyle.tertiary:
        activeColor = AppColors.success.resolve(context, shade: 500);
        inactiveColor = appTheme.disabled;
        break;
    }

    return (activeColor, inactiveColor);
  }

  VoidCallback? get _wrappedOnChanged {
    if (widget.onChanged == null) return null;
    return () {
      final effectiveFeedbackType = widget.feedbackType ?? FeedbackType.impact;
      feedbackService.haptic(effectiveFeedbackType);
      widget.onChanged!(!widget.value);
    };
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveWidth = widget.width ?? 48.0;
    final effectiveHeight = widget.height ?? 24.0;
    final thumbSize = effectiveHeight - 4.0;
    final (activeColor, inactiveColor) = _getToggleColors(context);

    return AppConditionalWrapper(
      condition: widget.semanticLabel != null,
      wrapper: (child) => Semantics(
        label: widget.semanticLabel!,
        toggled: widget.value,
        child: child,
      ),
      child: GestureDetector(
        onTap: _wrappedOnChanged,
        child: SizedBox(
          width: effectiveWidth,
          height: effectiveHeight,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              final trackColor = Color.lerp(inactiveColor, activeColor, _thumbAnimation.value);
              
              return Container(
                width: effectiveWidth,
                height: effectiveHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(effectiveHeight / 2),
                  color: trackColor,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: _thumbAnimation.value *
                          (effectiveWidth - thumbSize - 4.0) +
                          2.0,
                      top: 2.0,
                      child: Container(
                        width: thumbSize,
                        height: thumbSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.surface,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class AppCheckboxListTile extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final Widget title;
  final Widget? subtitle;
  final AppSelectableButtonStyle style;
  final FeedbackType? feedbackType;
  final bool controlAffinity;
  final EdgeInsetsGeometry? contentPadding;
  final bool tristate;

  const AppCheckboxListTile({
    super.key,
    required this.value,
    required this.title,
    this.onChanged,
    this.subtitle,
    this.style = AppSelectableButtonStyle.primary,
    this.feedbackType,
    this.controlAffinity = false,
    this.contentPadding,
    this.tristate = false,
  });

  VoidCallback? get _wrappedOnChanged {
    if (onChanged == null) return null;
    return () {
      final effectiveFeedbackType = feedbackType ?? FeedbackType.selection;
      feedbackService.haptic(effectiveFeedbackType);
      onChanged!(!value);
    };
  }

  @override
  Widget build(BuildContext context) {
    final checkbox = AppCheckbox(
      value: value,
      onChanged: onChanged,
      style: style,
      feedbackType: feedbackType,
      tristate: tristate,
    );

    final titleWidget = DefaultTextStyle.merge(
      style: Theme.of(context).textTheme.bodyLarge,
      child: title,
    );

    final subtitleWidget = subtitle != null
        ? DefaultTextStyle.merge(
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
            child: subtitle!,
          )
        : null;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        titleWidget,
        if (subtitleWidget != null) ...[
          AppSpacing.xs.gapV,
          subtitleWidget,
        ],
      ],
    );

    return InkWell(
      onTap: _wrappedOnChanged,
      child: Padding(
        padding: contentPadding ?? AppSpacing.md.padding,
        child: Row(
          children: controlAffinity
              ? [
                  Expanded(child: content),
                  AppSpacing.md.gapH,
                  checkbox,
                ]
              : [
                  checkbox,
                  AppSpacing.md.gapH,
                  Expanded(child: content),
                ],
        ),
      ),
    );
  }
}