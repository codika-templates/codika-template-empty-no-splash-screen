import 'package:flutter/widgets.dart';

/// Conditionally wrap a subtree with a parent widget without breaking the code tree.
///
/// This utility widget provides a clean way to conditionally apply wrapper widgets
/// based on boolean conditions, maintaining code readability and avoiding complex
/// conditional logic in widget trees.
///
/// ## Usage Examples
///
/// ### Basic Conditional Wrapping
/// ```dart
/// AppConditionalWrapper(
///   condition: shouldHighlight,
///   child: Text('Content'),
///   wrapper: (child) => Container(
///     decoration: BoxDecoration(color: Colors.yellow),
///     child: child,
///   ),
/// )
/// ```
///
/// ### Authentication Wrapper
/// ```dart
/// AppConditionalWrapper(
///   condition: isLoggedIn,
///   child: ProfileButton(),
///   wrapper: (child) => Badge(
///     label: Text('New'),
///     child: child,
///   ),
/// )
/// ```
///
/// ### Accessibility Wrapper
/// ```dart
/// AppConditionalWrapper(
///   condition: needsSemantics,
///   child: Icon(Icons.star),
///   wrapper: (child) => Semantics(
///     label: 'Favorite',
///     child: child,
///   ),
/// )
/// ```
class AppConditionalWrapper extends StatelessWidget {
  const AppConditionalWrapper({
    super.key,
    required this.condition,
    required this.child,
    required this.wrapper,
  });

  /// Factory constructor for simple conditional wrapping
  const AppConditionalWrapper.when({
    Key? key,
    required bool condition,
    required Widget child,
    required Widget Function(Widget child) wrapper,
  }) : this(
          key: key,
          condition: condition,
          child: child,
          wrapper: wrapper,
        );

  /// The condition that determines whether the wrapper should be applied
  final bool condition;

  /// The child widget that will always be built
  final Widget child;

  /// Function that builds the parent wrapper around the child
  final Widget Function(Widget child) wrapper;

  @override
  Widget build(BuildContext context) {
    return condition ? wrapper(child) : child;
  }
}

/// Conditionally wrap a widget with one of two different wrappers based on a condition.
///
/// This variant allows you to apply different wrappers depending on the condition,
/// useful for theme switching, state-dependent styling, or feature toggling.
///
/// ## Usage Examples
///
/// ### Theme-Based Wrapping
/// ```dart
/// AppConditionalWrapperSwitch(
///   condition: isDarkMode,
///   child: Icon(Icons.home),
///   wrapperTrue: (child) => Container(
///     decoration: BoxDecoration(color: Colors.white),
///     child: child,
///   ),
///   wrapperFalse: (child) => Container(
///     decoration: BoxDecoration(color: Colors.black),
///     child: child,
///   ),
/// )
/// ```
///
/// ### Permission-Based UI
/// ```dart
/// AppConditionalWrapperSwitch(
///   condition: hasEditPermission,
///   child: DocumentViewer(),
///   wrapperTrue: (child) => GestureDetector(
///     onTap: openEditor,
///     child: child,
///   ),
///   wrapperFalse: (child) => AbsorbPointer(child: child),
/// )
/// ```
class AppConditionalWrapperSwitch extends StatelessWidget {
  const AppConditionalWrapperSwitch({
    super.key,
    required this.condition,
    required this.child,
    required this.wrapperTrue,
    required this.wrapperFalse,
  });

  /// Factory constructor for toggle-style conditional wrapping
  const AppConditionalWrapperSwitch.toggle({
    Key? key,
    required bool condition,
    required Widget child,
    required Widget Function(Widget child) wrapperTrue,
    required Widget Function(Widget child) wrapperFalse,
  }) : this(
          key: key,
          condition: condition,
          child: child,
          wrapperTrue: wrapperTrue,
          wrapperFalse: wrapperFalse,
        );

  /// The condition that determines which wrapper to use
  final bool condition;

  /// The child widget that will always be built
  final Widget child;

  /// Function that builds the wrapper when condition is true
  final Widget Function(Widget child) wrapperTrue;

  /// Function that builds the wrapper when condition is false
  final Widget Function(Widget child) wrapperFalse;

  @override
  Widget build(BuildContext context) {
    return condition ? wrapperTrue(child) : wrapperFalse(child);
  }
}