# Component Name

## Overview
Brief description of what this component does and its primary purpose.

## Use Cases
- **Primary Use Case**: Main scenario where this component should be used
- **Secondary Use Case**: Additional scenarios where it's appropriate
- **Avoid Using When**: Situations where this component is not recommended

## Component API

### Required Parameters
| Parameter | Type | Description |
|-----------|------|-------------|
| `param1` | `String` | Description of required parameter |

### Optional Parameters
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `param2` | `bool` | `false` | Description of optional parameter |

### Enums & Types
```dart
enum ComponentVariant { primary, secondary, tertiary }
enum ComponentSize { sm, md, lg }
```

## Variants & States

### Variants
- **Primary**: Default variant for main actions
- **Secondary**: For secondary actions or less prominent elements
- **Tertiary**: For minimal or subtle interactions

### States
- **Default**: Normal interactive state
- **Hover**: When user hovers over component (web)
- **Pressed**: When component is being pressed
- **Disabled**: When component is not interactive
- **Loading**: When component is performing an action

## Usage Examples

### Basic Usage
```dart
ComponentName(
  child: Text('Example'),
  onPressed: () => print('Pressed'),
)
```

### With Variants
```dart
ComponentName.primary(
  child: Text('Primary Action'),
  onPressed: () => handlePrimaryAction(),
)

ComponentName.secondary(
  child: Text('Secondary Action'),
  onPressed: () => handleSecondaryAction(),
)
```

### Advanced Usage
```dart
ComponentName(
  variant: ComponentVariant.primary,
  size: ComponentSize.lg,
  isLoading: true,
  child: Text('Loading...'),
  onPressed: isLoading ? null : () => handleAction(),
)
```

## Customization Guidelines

### When to Extend
- Adding new variants for specific use cases
- Creating specialized factory constructors
- Adding new states or behaviors

### How to Modify
1. **Adding Variants**: Extend the variant enum and update switch statements
2. **New Factory Constructors**: Create semantic constructors for common patterns
3. **Styling Changes**: Modify the `_getComponentStyle()` method
4. **New Parameters**: Add to main constructor and handle in build method

### Code Patterns
```dart
// Adding a new variant
factory ComponentName.custom({
  required Widget child,
  VoidCallback? onPressed,
}) {
  return ComponentName._(
    variant: ComponentVariant.custom,
    child: child,
    onPressed: onPressed,
  );
}
```

## Related Components
- **ComponentB**: Use for similar but different use case
- **ComponentC**: Can be combined with this component
- **ComponentD**: Alternative component for different scenarios

## Design System Integration

### Design Tokens Used
- **Colors**: `primary`, `secondary`, `surface`
- **Typography**: `labelLarge`, `bodyMedium`
- **Spacing**: `md`, `lg` for padding
- **Radius**: `defaultRadius` for border radius
- **Shadows**: `sm`, `md` for elevation

### Theme Integration
- Respects theme color schemes
- Adapts to light/dark mode automatically
- Uses app theme extensions for custom properties

## Accessibility
- Semantic roles and labels
- Keyboard navigation support
- Screen reader compatibility
- Focus management
- Color contrast compliance

## Platform Considerations
- **Web**: Hover states, cursor changes, focus indicators
- **Mobile**: Touch targets, haptic feedback
- **Desktop**: Keyboard shortcuts, context menus

## Examples in Playground
See `component_showcase_page.dart` for comprehensive examples showing all variants, states, and use cases in action.

## Migration Notes
If updating from previous versions, note any breaking changes or migration steps needed.