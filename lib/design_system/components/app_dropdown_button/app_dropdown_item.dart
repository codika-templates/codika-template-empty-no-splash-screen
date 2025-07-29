import 'package:flutter/material.dart';

/// A type-safe dropdown item for use with AppDropdownButton
class AppDropdownItem<T> {
  /// The value of this dropdown item
  final T value;
  
  /// The label to display for this item
  final String label;
  
  /// Optional leading icon for the item
  final Widget? leadingIcon;
  
  /// Optional trailing icon for the item
  final Widget? trailingIcon;
  
  /// Whether this item is enabled
  final bool enabled;
  
  /// Optional custom widget to display instead of label
  final Widget? customWidget;

  const AppDropdownItem({
    required this.value,
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
    this.enabled = true,
    this.customWidget,
  });

  /// Converts this item to a DropdownMenuEntry for use with DropdownMenu
  DropdownMenuEntry<T> toDropdownMenuEntry() {
    return DropdownMenuEntry<T>(
      value: value,
      label: label,
      enabled: enabled,
      labelWidget: customWidget ?? _buildDefaultLabelWidget(),
    );
  }

  /// Builds the default label widget with icons
  Widget _buildDefaultLabelWidget() {
    final children = <Widget>[];
    
    if (leadingIcon != null) {
      children.add(leadingIcon!);
      children.add(const SizedBox(width: 12));
    }
    
    children.add(
      Expanded(
        child: Text(
          label,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
    
    if (trailingIcon != null) {
      children.add(const SizedBox(width: 12));
      children.add(trailingIcon!);
    }
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: children,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppDropdownItem<T> && 
           other.value == value &&
           other.label == label;
  }

  @override
  int get hashCode => Object.hash(value, label);

  @override
  String toString() => 'AppDropdownItem(value: $value, label: $label)';
}

/// Extension methods for working with lists of AppDropdownItem
extension AppDropdownItemList<T> on List<AppDropdownItem<T>> {
  /// Converts a list of AppDropdownItem to DropdownMenuEntry list
  List<DropdownMenuEntry<T>> toDropdownMenuEntries() {
    return map((item) => item.toDropdownMenuEntry()).toList();
  }
  
  /// Finds an item by its value
  AppDropdownItem<T>? findByValue(T value) {
    try {
      return firstWhere((item) => item.value == value);
    } catch (e) {
      return null;
    }
  }
  
  /// Gets all values from the items
  List<T> get values => map((item) => item.value).toList();
  
  /// Gets all labels from the items
  List<String> get labels => map((item) => item.label).toList();
}