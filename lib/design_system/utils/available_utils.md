# Available Design System Utilities

This file serves as a reference for AI agents and developers to discover available utility widgets in the design system. These are **code utilities** that help with widget tree structure and logic flow, but don't render visual UI themselves.

## Widget Structure Utilities

### AppConditionalWrapper

**Purpose**: Conditionally wrap a widget with a parent widget based on a boolean condition.

**When to Use**: 
- Avoid complex conditional logic in widget trees
- Apply wrapper widgets based on state (authentication, permissions, theme)
- Clean conditional rendering without breaking widget hierarchy

**Basic Usage**:
```dart
AppConditionalWrapper(
  condition: isLoggedIn,
  child: ProfileButton(),
  wrapper: (child) => Badge(
    label: Text('New'),
    child: child,
  ),
)
```

**Factory Constructors**:
- `.when()` - Simple conditional wrapping
- Default constructor - Standard usage

### AppConditionalWrapperSwitch

**Purpose**: Apply one of two different wrappers based on a boolean condition.

**When to Use**:
- Theme-dependent wrapping
- State-specific styling
- Permission-based UI modifications
- Feature toggling with different wrapper behaviors

**Basic Usage**:
```dart
AppConditionalWrapperSwitch(
  condition: isDarkMode,
  child: Icon(Icons.home),
  wrapperTrue: (child) => Container(
    decoration: BoxDecoration(color: Colors.white),
    child: child,
  ),
  wrapperFalse: (child) => Container(
    decoration: BoxDecoration(color: Colors.black),
    child: child,
  ),
)
```

**Factory Constructors**:
- `.toggle()` - Toggle-style conditional wrapping
- Default constructor - Standard usage

## Usage Guidelines

### For AI Agents
1. **Structure Over UI**: These utilities help with code organization, not visual presentation
2. **Condition-Based Logic**: Use when you need to conditionally apply wrapper widgets
3. **Clean Code**: Prefer these utilities over complex conditional expressions in widget trees

### Best Practices
- Use `AppConditionalWrapper` for single condition checks
- Use `AppConditionalWrapperSwitch` when you need different wrappers for true/false cases
- Keep wrapper functions simple and focused
- Consider performance - these widgets rebuild when conditions change

### Common Patterns

**Authentication Wrapper**:
```dart
AppConditionalWrapper(
  condition: user.hasPermission,
  child: EditButton(),
  wrapper: (child) => GestureDetector(
    onTap: handleEdit,
    child: child,
  ),
)
```

**Accessibility Enhancement**:
```dart
AppConditionalWrapper(
  condition: needsSemantics,
  child: CustomIcon(),
  wrapper: (child) => Semantics(
    label: 'Important action',
    child: child,
  ),
)
```

**Loading State Management**:
```dart
AppConditionalWrapper(
  condition: isLoading,
  child: ActionButton(),
  wrapper: (child) => AbsorbPointer(
    absorbing: true,
    child: Opacity(opacity: 0.5, child: child),
  ),
)
```

## Related Components

For **visual UI components** (loading overlays, indicators, progress bars), see the main components directory:
- `AppLoadingOverlay` - Visual loading overlays
- `AppLoadingIndicator` - Loading animations
- `AppProgressBar` - Progress indicators
- `AppSkeletonLoader` - Skeleton loading UI

## File Location

`lib/design_system/utils/widgets/app_conditional_wrapper.dart`