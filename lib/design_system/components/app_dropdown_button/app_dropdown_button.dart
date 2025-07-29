import 'package:flutter/material.dart';

import '../../services/interaction_feedback_service.dart';
import '../../theme/app_theme_extension.dart';
import '../../tokens/app_density.dart';
import '../../tokens/app_radius.dart';
import '../../tokens/app_shadows.dart';
import '../../utils/input_styling.dart';
import '../app_text_field/app_text_field.dart';
import 'app_dropdown_item.dart';

class AppDropdownButton<T> extends StatefulWidget {
  /// The currently selected value
  final T? value;

  /// List of dropdown items
  final List<AppDropdownItem<T>> items;

  /// Callback when a value is selected
  final ValueChanged<T?>? onSelected;

  /// Hint text when no value is selected
  final String? hintText;

  /// Label text (used with AppTextFieldWrapper or animateLabel)
  final String? labelText;

  /// Error text to display
  final String? errorText;

  /// Visual variant of the dropdown
  final AppTextFieldVariant variant;

  /// Size of the dropdown
  final AppTextFieldSize size;

  /// Density configuration
  final AppDensity? density;

  /// Whether the dropdown is enabled
  final bool enabled;

  /// Custom width for the dropdown
  final double? width;

  /// Whether to enable search/filtering (default: false for selection-only)
  final bool enableSearch;

  /// Whether to enable filtering by typing (default: false for selection-only)
  final bool enableFilter;

  /// Whether to request focus when tapped (default: false to prevent double-click issues)
  final bool requestFocusOnTap;

  /// Leading icon
  final Widget? leadingIcon;

  /// Trailing icon (defaults to dropdown arrow)
  final Widget? trailingIcon;

  /// Custom border radius
  final AppRadius? borderRadius;

  /// Custom fill color
  final Color? fillColor;

  /// Custom focus color
  final Color? focusColor;

  /// Custom hover color
  final Color? hoverColor;

  /// Feedback type for haptic feedback
  final FeedbackType? feedbackType;

  /// Whether to animate the label
  final bool animateLabel;

  /// Whether to show counter
  final bool showCounter;

  /// Focus node for the dropdown
  final FocusNode? focusNode;

  /// Text editing controller for search functionality
  final TextEditingController? controller;

  /// Menu height
  final double? menuHeight;

  const AppDropdownButton({
    super.key,
    required this.items,
    this.value,
    this.onSelected,
    this.hintText,
    this.labelText,
    this.errorText,
    this.variant = AppTextFieldVariant.outlined,
    this.size = AppTextFieldSize.md,
    this.density,
    this.enabled = true,
    this.width,
    this.enableSearch = false,
    this.enableFilter = false,
    this.requestFocusOnTap = false,
    this.leadingIcon,
    this.trailingIcon,
    this.borderRadius,
    this.fillColor,
    this.focusColor,
    this.hoverColor,
    this.feedbackType,
    this.animateLabel = false,
    this.showCounter = false,
    this.focusNode,
    this.controller,
    this.menuHeight,
  });

  // Factory constructors for common use cases
  factory AppDropdownButton.filled({
    Key? key,
    required List<AppDropdownItem<T>> items,
    T? value,
    ValueChanged<T?>? onSelected,
    String? hintText,
    String? labelText,
    String? errorText,
    AppTextFieldSize size = AppTextFieldSize.md,
    bool enabled = true,
    bool enableSearch = false,
    Widget? leadingIcon,
    Widget? trailingIcon,
    FeedbackType? feedbackType,
  }) {
    return AppDropdownButton<T>(
      key: key,
      items: items,
      value: value,
      onSelected: onSelected,
      hintText: hintText,
      labelText: labelText,
      errorText: errorText,
      variant: AppTextFieldVariant.filled,
      size: size,
      enabled: enabled,
      enableSearch: enableSearch,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      feedbackType: feedbackType,
    );
  }

  factory AppDropdownButton.outlined({
    Key? key,
    required List<AppDropdownItem<T>> items,
    T? value,
    ValueChanged<T?>? onSelected,
    String? hintText,
    String? labelText,
    String? errorText,
    AppTextFieldSize size = AppTextFieldSize.md,
    bool enabled = true,
    bool enableSearch = false,
    Widget? leadingIcon,
    Widget? trailingIcon,
    FeedbackType? feedbackType,
  }) {
    return AppDropdownButton<T>(
      key: key,
      items: items,
      value: value,
      onSelected: onSelected,
      hintText: hintText,
      labelText: labelText,
      errorText: errorText,
      variant: AppTextFieldVariant.outlined,
      size: size,
      enabled: enabled,
      enableSearch: enableSearch,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      feedbackType: feedbackType,
    );
  }

  @override
  State<AppDropdownButton<T>> createState() => _AppDropdownButtonState<T>();
}

class _AppDropdownButtonState<T> extends State<AppDropdownButton<T>>
    with TickerProviderStateMixin {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    // Set initial value text if value is provided
    _updateControllerText();
  }

  @override
  void didUpdateWidget(AppDropdownButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _updateControllerText();
    }
  }

  @override
  void dispose() {
    _closeDropdown();
    _animationController.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _updateControllerText() {
    if (widget.value != null) {
      final selectedItem = widget.items.findByValue(widget.value as T);
      if (selectedItem != null) {
        _controller.text = selectedItem.label;
      }
    } else {
      _controller.clear();
    }
  }

  AppTextFieldState get _currentState {
    if (!widget.enabled) return AppTextFieldState.disabled;
    if (widget.errorText != null) return AppTextFieldState.error;
    if (_isOpen) return AppTextFieldState.focused;
    return AppTextFieldState.normal;
  }

  void _toggleDropdown() {
    if (!widget.enabled) return;

    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }

    if (widget.feedbackType != null) {
      feedbackService.haptic(widget.feedbackType!);
    }
  }

  void _openDropdown() {
    if (_isOpen) return;

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _animationController.forward();
    setState(() {
      _isOpen = true;
    });
  }

  void _closeDropdown() {
    if (!_isOpen) return;

    _animationController.reverse().then((_) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
    setState(() {
      _isOpen = false;
    });
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _closeDropdown,
        child: SizedBox.expand(
          child: Stack(
            children: [
              Positioned(
                child: CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  offset: Offset(0.0, size.height + 4.0),
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) => SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: GestureDetector(
                          onTap: () {}, // Prevent tap from bubbling up
                          child: _buildDropdownMenu(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownMenu() {
    final theme = Theme.of(context);
    final appTheme = context.appTheme;
    final radius = widget.borderRadius ?? appTheme.defaultRadius;
    final renderBox = context.findRenderObject() as RenderBox;
    final fieldWidth = renderBox.size.width;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: fieldWidth,
        maxWidth: fieldWidth * 1.5,
        maxHeight: widget.menuHeight ?? 280,
      ),
      child: Material(
        elevation: 0,
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: radius.borderRadius,
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: radius.borderRadius,
            border: Border.all(color: theme.colorScheme.primary, width: 1),
            boxShadow: AppShadows.md.shadows,
          ),
          child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                final item = widget.items[index];
                final isSelected = widget.value == item.value;

                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: item.enabled
                        ? () => _handleSelection(item.value)
                        : null,
                    hoverColor: theme.colorScheme.onSurface.withValues(
                      alpha: 0.04,
                    ),
                    highlightColor: theme.colorScheme.onSurface.withValues(
                      alpha: 0.08,
                    ),
                    borderRadius: index == 0
                        ? BorderRadius.only(
                            topLeft: radius.borderRadius.topLeft,
                            topRight: radius.borderRadius.topRight,
                          )
                        : index == widget.items.length - 1
                        ? BorderRadius.only(
                            bottomLeft: radius.borderRadius.bottomLeft,
                            bottomRight: radius.borderRadius.bottomRight,
                          )
                        : null,
                    child: Container(
                      padding: AppInputStyling.buildContentPadding(
                        size: widget.size,
                        density: widget.density,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? theme.colorScheme.primary.withValues(alpha: 0.1)
                            : null,
                      ),
                      child: Row(
                        children: [
                          if (item.leadingIcon != null) ...[
                            item.leadingIcon!,
                            const SizedBox(width: 12),
                          ],
                          Expanded(
                            child: Text(
                              item.label,
                              style:
                                  AppInputStyling.buildTextStyle(
                                    context: context,
                                    size: widget.size,
                                    state: item.enabled
                                        ? AppTextFieldState.normal
                                        : AppTextFieldState.disabled,
                                  ).copyWith(
                                    color: isSelected
                                        ? theme.colorScheme.primary
                                        : null,
                                  ),
                            ),
                          ),
                          if (item.trailingIcon != null) ...[
                            const SizedBox(width: 12),
                            item.trailingIcon!,
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
        ),
      ),
    );
  }

  void _handleSelection(T? value) {
    _closeDropdown();

    if (widget.feedbackType != null) {
      feedbackService.haptic(widget.feedbackType!);
    }

    widget.onSelected?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Build effective trailing icon with rotation animation
    Widget effectiveTrailingIcon = AnimatedRotation(
      turns: _isOpen ? 0.5 : 0,
      duration: const Duration(milliseconds: 200),
      child:
          widget.trailingIcon ??
          Icon(
            Icons.keyboard_arrow_down,
            color: widget.enabled
                ? theme.colorScheme.onSurfaceVariant
                : context.appTheme.disabled,
          ),
    );

    // Build the input decoration using our shared utility
    final inputDecoration = AppInputStyling.buildDecoration(
      context: context,
      variant: widget.variant,
      size: widget.size,
      state: _currentState,
      density: widget.density,
      borderRadius: widget.borderRadius,
      hintText: widget.hintText,
      labelText: widget.labelText,
      errorText: widget.errorText,
      prefixIcon: widget.leadingIcon,
      suffixIcon: effectiveTrailingIcon,
      fillColor: widget.fillColor,
      focusColor: widget.focusColor,
      hoverColor: widget.hoverColor,
      animateLabel: widget.animateLabel,
      showCounter: widget.showCounter,
      isHovered: _isHovered,
    );

    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        cursor: widget.enabled
            ? SystemMouseCursors.click
            : SystemMouseCursors.forbidden,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: _toggleDropdown,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              color: _isHovered && widget.enabled
                  ? (widget.hoverColor ??
                        theme.colorScheme.onSurface.withValues(alpha: 0.04))
                  : Colors.transparent,
              borderRadius:
                  (widget.borderRadius ?? context.appTheme.defaultRadius)
                      .borderRadius,
            ),
            child: AbsorbPointer(
              child: TextFormField(
                controller: _controller,
                focusNode: _focusNode,
                enabled: widget.enabled,
                readOnly: true, // Always read-only for selection-only behavior
                decoration: inputDecoration,
                style: AppInputStyling.buildTextStyle(
                  context: context,
                  size: widget.size,
                  state: _currentState,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
