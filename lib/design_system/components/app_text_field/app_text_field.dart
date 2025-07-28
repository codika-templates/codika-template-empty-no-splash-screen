import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/interaction_feedback_service.dart';
import '../../theme/app_theme_extension.dart';
import '../../tokens/app_colors.dart';
import '../../tokens/app_density.dart';
import '../../tokens/app_radius.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';
import '../app_button/app_button.dart';

enum AppTextFieldVariant { outlined, filled, underlined }

enum AppTextFieldSize { sm, md, lg }

enum AppTextFieldState { normal, focused, error, disabled, success }

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final IconData? suffixIconData;
  final VoidCallback? onSuffixIconTap;
  final String? prefixText;
  final String? suffixText;
  final AppTextFieldVariant variant;
  final AppTextFieldSize size;
  final AppDensity? density;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final bool autofocus;
  final bool enableInteractiveSelection;
  final bool showCursor;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final AppRadius? borderRadius;
  final Color? fillColor;
  final Color? focusColor;
  final Color? hoverColor;
  final FeedbackType? feedbackType;
  final bool allowClear;
  final bool showCounter;
  final bool animateLabel;

  const AppTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.labelText,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconData,
    this.onSuffixIconTap,
    this.prefixText,
    this.suffixText,
    this.variant = AppTextFieldVariant.outlined,
    this.size = AppTextFieldSize.md,
    this.density,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.enableInteractiveSelection = true,
    this.showCursor = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.onEditingComplete,
    this.validator,
    this.autovalidateMode,
    this.borderRadius,
    this.fillColor,
    this.focusColor,
    this.hoverColor,
    this.feedbackType,
    this.allowClear = false,
    this.showCounter = false,
    this.animateLabel = true,
  }) : assert(
         controller == null || initialValue == null,
         'Cannot provide both controller and initialValue',
       );

  // Factory constructors for common use cases
  factory AppTextField.email({
    Key? key,
    TextEditingController? controller,
    String? initialValue,
    FocusNode? focusNode,
    String? labelText,
    String? hintText,
    String? errorText,
    bool enabled = true,
    bool autofocus = false,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    ValueChanged<String>? onSubmitted,
    String? Function(String?)? validator,
    AutovalidateMode? autovalidateMode,
    AppTextFieldVariant variant = AppTextFieldVariant.outlined,
    AppTextFieldSize size = AppTextFieldSize.md,
    bool allowClear = true,
    bool animateLabel =
        false, // Default to false for better wrapper compatibility
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      labelText: animateLabel ? (labelText ?? 'Email') : null,
      hintText: hintText,
      errorText: errorText,
      prefixIcon: const Icon(Icons.email_outlined),
      variant: variant,
      size: size,
      enabled: enabled,
      autofocus: autofocus,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      onTap: onTap,
      onSubmitted: onSubmitted,
      validator: validator,
      autovalidateMode: autovalidateMode,
      allowClear: allowClear,
      feedbackType: FeedbackType.light,
      animateLabel: animateLabel,
    );
  }

  factory AppTextField.password({
    Key? key,
    TextEditingController? controller,
    String? initialValue,
    FocusNode? focusNode,
    String? labelText,
    String? hintText,
    String? errorText,
    bool enabled = true,
    bool autofocus = false,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    ValueChanged<String>? onSubmitted,
    String? Function(String?)? validator,
    AutovalidateMode? autovalidateMode,
    AppTextFieldVariant variant = AppTextFieldVariant.outlined,
    AppTextFieldSize size = AppTextFieldSize.md,
    bool animateLabel = false,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      labelText: animateLabel ? (labelText ?? 'Password') : null,
      hintText: hintText,
      errorText: errorText,
      prefixIcon: const Icon(Icons.lock_outlined),
      variant: variant,
      size: size,
      enabled: enabled,
      autofocus: autofocus,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      onChanged: onChanged,
      onTap: onTap,
      onSubmitted: onSubmitted,
      validator: validator,
      autovalidateMode: autovalidateMode,
      feedbackType: FeedbackType.medium,
      animateLabel: animateLabel,
    );
  }

  factory AppTextField.search({
    Key? key,
    TextEditingController? controller,
    String? initialValue,
    FocusNode? focusNode,
    String? hintText,
    bool enabled = true,
    bool autofocus = false,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    ValueChanged<String>? onSubmitted,
    AppTextFieldSize size = AppTextFieldSize.md,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      hintText: hintText,
      prefixIcon: const Icon(Icons.search_outlined),
      variant: AppTextFieldVariant.filled,
      size: size,
      enabled: enabled,
      autofocus: autofocus,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      onChanged: onChanged,
      onTap: onTap,
      onSubmitted: onSubmitted,
      allowClear: true,
      feedbackType: FeedbackType.light,
      animateLabel: false, // Search always uses static placeholder
    );
  }

  factory AppTextField.multiline({
    Key? key,
    TextEditingController? controller,
    String? initialValue,
    FocusNode? focusNode,
    String? labelText,
    String? hintText,
    String? errorText,
    bool enabled = true,
    bool autofocus = false,
    int maxLines = 3,
    int? minLines,
    int? maxLength,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    String? Function(String?)? validator,
    AutovalidateMode? autovalidateMode,
    AppTextFieldVariant variant = AppTextFieldVariant.outlined,
    AppTextFieldSize size = AppTextFieldSize.md,
    bool showCounter = false,
    bool animateLabel = false,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      labelText: animateLabel ? labelText : null,
      hintText: hintText,
      errorText: errorText,
      variant: variant,
      size: size,
      enabled: enabled,
      autofocus: autofocus,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      textCapitalization: TextCapitalization.sentences,
      onChanged: onChanged,
      onTap: onTap,
      validator: validator,
      autovalidateMode: autovalidateMode,
      showCounter: showCounter,
      feedbackType: FeedbackType.light,
      animateLabel: animateLabel,
    );
  }

  factory AppTextField.phone({
    Key? key,
    TextEditingController? controller,
    String? initialValue,
    FocusNode? focusNode,
    String? labelText,
    String? hintText,
    String? errorText,
    bool enabled = true,
    bool autofocus = false,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    ValueChanged<String>? onSubmitted,
    String? Function(String?)? validator,
    AutovalidateMode? autovalidateMode,
    AppTextFieldVariant variant = AppTextFieldVariant.outlined,
    AppTextFieldSize size = AppTextFieldSize.md,
    bool animateLabel = false,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      labelText: animateLabel ? (labelText ?? 'Phone Number') : null,
      hintText: hintText,
      errorText: errorText,
      prefixIcon: const Icon(Icons.phone_outlined),
      variant: variant,
      size: size,
      enabled: enabled,
      autofocus: autofocus,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      onTap: onTap,
      onSubmitted: onSubmitted,
      validator: validator,
      autovalidateMode: autovalidateMode,
      feedbackType: FeedbackType.light,
      animateLabel: animateLabel,
    );
  }

  factory AppTextField.number({
    Key? key,
    TextEditingController? controller,
    String? initialValue,
    FocusNode? focusNode,
    String? labelText,
    String? hintText,
    String? errorText,
    bool enabled = true,
    bool autofocus = false,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    ValueChanged<String>? onSubmitted,
    String? Function(String?)? validator,
    AutovalidateMode? autovalidateMode,
    AppTextFieldVariant variant = AppTextFieldVariant.outlined,
    AppTextFieldSize size = AppTextFieldSize.md,
    bool allowDecimal = false,
    bool animateLabel = false,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      labelText: animateLabel ? labelText : null,
      hintText: hintText,
      errorText: errorText,
      variant: variant,
      size: size,
      enabled: enabled,
      autofocus: autofocus,
      keyboardType:
          allowDecimal
              ? const TextInputType.numberWithOptions(decimal: true)
              : TextInputType.number,
      textInputAction: TextInputAction.next,
      inputFormatters:
          allowDecimal
              ? [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))]
              : [FilteringTextInputFormatter.digitsOnly],
      onChanged: onChanged,
      onTap: onTap,
      onSubmitted: onSubmitted,
      validator: validator,
      autovalidateMode: autovalidateMode,
      feedbackType: FeedbackType.light,
      animateLabel: animateLabel,
    );
  }

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _obscureText = false;
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode = widget.focusNode ?? FocusNode();
    _obscureText = widget.obscureText;

    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });

    if (_isFocused && widget.feedbackType != null) {
      feedbackService.haptic(widget.feedbackType!);
    }
  }

  AppTextFieldState get _currentState {
    if (!widget.enabled) return AppTextFieldState.disabled;
    if (widget.errorText != null) return AppTextFieldState.error;
    if (_isFocused) return AppTextFieldState.focused;
    return AppTextFieldState.normal;
  }

  InputDecoration _buildDecoration(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme = context.appTheme;
    final effectiveDensity = widget.density ?? appTheme.density;
    final radius = widget.borderRadius ?? appTheme.defaultRadius;

    EdgeInsets contentPadding;
    double iconSize;
    TextStyle labelStyle;
    TextStyle hintStyle;
    TextStyle helperStyle;

    // Size-based properties
    switch (widget.size) {
      case AppTextFieldSize.sm:
        contentPadding = AppSpacing.sm.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        );
        iconSize = effectiveDensity.buttonIconSize * 0.9;
        labelStyle = AppTextStyle.labelMedium.style;
        hintStyle = AppTextStyle.bodySmall.style;
        helperStyle = AppTextStyle.bodySmall.style;
        break;
      case AppTextFieldSize.md:
        contentPadding = AppSpacing.md.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        );
        iconSize = effectiveDensity.buttonIconSize;
        labelStyle = AppTextStyle.labelLarge.style;
        hintStyle = AppTextStyle.bodyMedium.style;
        helperStyle = AppTextStyle.bodySmall.style;
        break;
      case AppTextFieldSize.lg:
        contentPadding = AppSpacing.lg.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        );
        iconSize = effectiveDensity.buttonIconSize * 1.1;
        labelStyle = AppTextStyle.labelLarge.style;
        hintStyle = AppTextStyle.bodyLarge.style;
        helperStyle = AppTextStyle.bodyMedium.style;
        break;
    }

    // State-based colors
    Color borderColor;
    Color? fillColor;
    Color? focusColor;
    Color? hoverColor;
    Color labelColor;
    Color hintColor;

    switch (_currentState) {
      case AppTextFieldState.normal:
        borderColor = appTheme.border;
        fillColor = widget.fillColor;
        focusColor = widget.focusColor ?? theme.colorScheme.primary;
        hoverColor =
            widget.hoverColor ??
            theme.colorScheme.onSurface.withValues(alpha: 0.04);
        labelColor = theme.colorScheme.onSurfaceVariant;
        hintColor = theme.colorScheme.onSurfaceVariant;
        break;
      case AppTextFieldState.focused:
        borderColor = theme.colorScheme.primary;
        fillColor = widget.fillColor;
        focusColor = theme.colorScheme.primary;
        hoverColor =
            widget.hoverColor ??
            theme.colorScheme.onSurface.withValues(alpha: 0.04);
        labelColor = theme.colorScheme.primary;
        hintColor = theme.colorScheme.onSurfaceVariant;
        break;
      case AppTextFieldState.error:
        borderColor = AppColors.error.materialSwatch[500]!;
        fillColor = widget.fillColor;
        focusColor = AppColors.error.materialSwatch[500]!;
        hoverColor = AppColors.error.materialSwatch[50]!;
        labelColor = AppColors.error.materialSwatch[500]!;
        hintColor = theme.colorScheme.onSurfaceVariant;
        break;
      case AppTextFieldState.disabled:
        borderColor = appTheme.disabled;
        fillColor = appTheme.disabled.withValues(alpha: 0.04);
        focusColor = null;
        hoverColor = null;
        labelColor = appTheme.disabled;
        hintColor = appTheme.disabled;
        break;
      case AppTextFieldState.success:
        borderColor = AppColors.success.materialSwatch[500]!;
        fillColor = widget.fillColor;
        focusColor = AppColors.success.materialSwatch[500]!;
        hoverColor = AppColors.success.materialSwatch[50]!;
        labelColor = AppColors.success.materialSwatch[500]!;
        hintColor = theme.colorScheme.onSurfaceVariant;
        break;
    }

    // Build suffix icon with clear functionality and custom suffix icon
    Widget? effectiveSuffixIcon = widget.suffixIcon;
    
    // Create list of suffix widgets
    final suffixWidgets = <Widget>[];
    
    // Add password visibility toggle if needed
    if (widget.obscureText &&
        widget.keyboardType == TextInputType.visiblePassword) {
      suffixWidgets.add(
        AppButton.icon(
          icon: _obscureText
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          variant: AppButtonVariant.ghost,
          density: AppDensity.compact,
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
            feedbackService.haptic(FeedbackType.selection);
          },
        ),
      );
    }
    
    // Add custom suffix icon if provided
    if (widget.suffixIconData != null && widget.onSuffixIconTap != null) {
      suffixWidgets.add(
        AppButton.icon(
          icon: widget.suffixIconData!,
          variant: AppButtonVariant.ghost,
          density: AppDensity.compact,
          onPressed: widget.onSuffixIconTap,
        ),
      );
    }
    
    // Add existing suffixIcon if provided
    if (widget.suffixIcon != null) {
      suffixWidgets.add(widget.suffixIcon!);
    }
    
    // Add clear button if needed
    if (widget.allowClear && _controller.text.isNotEmpty && widget.enabled) {
      suffixWidgets.add(
        AppButton.icon(
          icon: Icons.clear,
          variant: AppButtonVariant.ghost,
          density: AppDensity.compact,
          onPressed: () {
            _controller.clear();
            widget.onChanged?.call('');
            feedbackService.haptic(FeedbackType.light);
          },
        ),
      );
    }
    
    // Build the final suffix icon widget
    if (suffixWidgets.isNotEmpty) {
      effectiveSuffixIcon = Row(
        mainAxisSize: MainAxisSize.min,
        children: suffixWidgets,
      );
    }

    // Variant-specific decoration
    InputBorder border;
    InputBorder? focusedBorder;
    InputBorder? errorBorder;
    InputBorder? focusedErrorBorder;
    InputBorder? disabledBorder;
    InputBorder? enabledBorder;

    switch (widget.variant) {
      case AppTextFieldVariant.outlined:
        border = OutlineInputBorder(
          borderRadius: radius.borderRadius,
          borderSide: BorderSide(color: borderColor),
        );
        focusedBorder = OutlineInputBorder(
          borderRadius: radius.borderRadius,
          borderSide: BorderSide(color: focusColor ?? borderColor, width: 2),
        );
        errorBorder = OutlineInputBorder(
          borderRadius: radius.borderRadius,
          borderSide: BorderSide(color: AppColors.error.materialSwatch[500]!),
        );
        focusedErrorBorder = OutlineInputBorder(
          borderRadius: radius.borderRadius,
          borderSide: BorderSide(
            color: AppColors.error.materialSwatch[500]!,
            width: 2,
          ),
        );
        fillColor = fillColor;
        break;
      case AppTextFieldVariant.filled:
        border = OutlineInputBorder(
          borderRadius: radius.borderRadius,
          borderSide: BorderSide.none,
        );
        focusedBorder = OutlineInputBorder(
          borderRadius: radius.borderRadius,
          borderSide: BorderSide(color: focusColor ?? borderColor, width: 2),
        );
        errorBorder = OutlineInputBorder(
          borderRadius: radius.borderRadius,
          borderSide: BorderSide(color: AppColors.error.materialSwatch[500]!),
        );
        focusedErrorBorder = OutlineInputBorder(
          borderRadius: radius.borderRadius,
          borderSide: BorderSide(
            color: AppColors.error.materialSwatch[500]!,
            width: 2,
          ),
        );
        fillColor = fillColor ?? theme.colorScheme.surfaceContainerHighest;
        break;
      case AppTextFieldVariant.underlined:
        border = UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        );
        focusedBorder = UnderlineInputBorder(
          borderSide: BorderSide(color: focusColor ?? borderColor, width: 2),
        );
        errorBorder = UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.error.materialSwatch[500]!),
        );
        focusedErrorBorder = UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.error.materialSwatch[500]!,
            width: 2,
          ),
        );
        fillColor = null;
        break;
    }

    return InputDecoration(
      labelText: widget.animateLabel ? widget.labelText : null,
      hintText: widget.hintText,
      errorText: widget.errorText,
      prefixIcon: widget.prefixIcon != null
          ? Padding(
              padding: EdgeInsets.only(left: AppSpacing.sm.value),
              child: Transform.scale(
                scale: 0.85,
                child: widget.prefixIcon,
              ),
            )
          : null,
      suffixIcon: effectiveSuffixIcon != null
          ? Padding(
              padding: EdgeInsets.only(right: AppSpacing.sm.value),
              child: Transform.scale(
                scale: 0.85,
                child: effectiveSuffixIcon,
              ),
            )
          : null,
      prefixText: widget.prefixText,
      suffixText: widget.suffixText,
      contentPadding: contentPadding,
      border: border,
      enabledBorder: enabledBorder ?? border,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      focusedErrorBorder: focusedErrorBorder,
      disabledBorder: disabledBorder ?? border,
      filled: fillColor != null,
      fillColor: fillColor,
      hoverColor: _isHovered ? hoverColor : null,
      labelStyle: labelStyle.copyWith(color: labelColor),
      hintStyle: hintStyle.copyWith(color: hintColor),
      errorStyle: helperStyle.copyWith(
        color: AppColors.error.materialSwatch[500]!,
      ),
      prefixIconConstraints: BoxConstraints(
        minWidth: iconSize + AppSpacing.md.value,
        minHeight: iconSize,
      ),
      suffixIconConstraints: BoxConstraints(
        minWidth: iconSize + AppSpacing.md.value,
        minHeight: iconSize,
      ),
      counterText: widget.showCounter ? null : '',
      errorMaxLines: 2,
      floatingLabelBehavior:
          widget.animateLabel
              ? FloatingLabelBehavior.auto
              : FloatingLabelBehavior.never,
    );
  }

  TextStyle _buildTextStyle(BuildContext context) {
    final theme = Theme.of(context);

    TextStyle baseStyle;
    switch (widget.size) {
      case AppTextFieldSize.sm:
        baseStyle = AppTextStyle.bodySmall.style;
        break;
      case AppTextFieldSize.md:
        baseStyle = AppTextStyle.bodyMedium.style;
        break;
      case AppTextFieldSize.lg:
        baseStyle = AppTextStyle.bodyLarge.style;
        break;
    }

    Color textColor;
    switch (_currentState) {
      case AppTextFieldState.disabled:
        textColor = context.appTheme.disabled;
        break;
      default:
        textColor = theme.colorScheme.onSurface;
        break;
    }

    return baseStyle.copyWith(color: textColor);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        style: _buildTextStyle(context),
        decoration: _buildDecoration(context),
        obscureText: _obscureText,
        readOnly: widget.readOnly,
        enabled: widget.enabled,
        autofocus: widget.autofocus,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        showCursor: widget.showCursor,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        textCapitalization: widget.textCapitalization,
        inputFormatters: widget.inputFormatters,
        onChanged: widget.onChanged,
        onTap: () {
          if (widget.feedbackType != null) {
            feedbackService.haptic(widget.feedbackType!);
          }
          widget.onTap?.call();
        },
        onFieldSubmitted: widget.onSubmitted,
        onEditingComplete: widget.onEditingComplete,
        validator: widget.validator,
        autovalidateMode: widget.autovalidateMode,
      ),
    );
  }
}
