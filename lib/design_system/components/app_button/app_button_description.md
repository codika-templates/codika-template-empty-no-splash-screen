# AppButton

## Overview
AppButton is the primary interactive component for user actions in the design system. It provides consistent styling, behavior, and accessibility across the application with multiple variants and states optimized for web, mobile, and desktop platforms.

## Use Cases
- **Primary Actions**: Main call-to-action buttons (submit, save, continue)
- **Secondary Actions**: Supporting actions (cancel, edit, view details)
- **Navigation**: Page transitions and routing actions
- **Icon Actions**: Compact actions like favorites, settings, delete
- **Status Indicators**: Small badges and labels showing state
- **Avoid Using When**: For navigation that should use links, or for complex multi-action scenarios

## Component API

### Required Parameters
| Parameter | Type | Description |
|-----------|------|-------------|
| `child` | `Widget` | Content displayed inside the button (except for icon-only variants) |

### Optional Parameters
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `onPressed` | `VoidCallback?` | `null` | Callback when button is pressed (null = disabled) |
| `variant` | `AppButtonVariant` | `primary` | Visual style variant |
| `size` | `AppButtonSize` | `md` | Button size |
| `density` | `AppDensity?` | `null` | Override theme density |
| `isLoading` | `bool` | `false` | Shows loading spinner |
| `fullWidth` | `bool` | `false` | Expands to container width |
| `icon` | `IconData?` | `null` | Leading icon |
| `trailingIcon` | `IconData?` | `null` | Trailing icon |
| `borderRadius` | `AppRadius?` | `null` | Custom border radius |

### Enums & Types
```dart
enum AppButtonVariant { primary, secondary, ghost, destructive, outline, link }
enum AppButtonSize { sm, md, lg, icon, compact }
```

## Variants & States

### Variants
- **Primary**: Main action buttons with filled background and high contrast
- **Secondary**: Secondary actions with subtle background and border
- **Ghost**: Minimal buttons with transparent background for subtle actions
- **Destructive**: Warning/danger actions with red styling
- **Outline**: Bordered buttons with transparent background
- **Link**: Text-only buttons that appear as links

### States
- **Default**: Normal interactive state with hover/focus effects
- **Hover**: Enhanced shadow and background tint (web only)
- **Pressed**: Scaled down with darker background
- **Disabled**: Greyed out and non-interactive when onPressed is null
- **Loading**: Shows spinner and prevents interaction when isLoading is true

## Usage Examples

### Basic Usage
```dart
AppButton.primary(
  child: Text('Save Changes'),
  onPressed: () => saveData(),
)
```

### Variant Examples
```dart
// Primary action
AppButton.primary(
  child: Text('Continue'),
  onPressed: () => navigateNext(),
)

// Secondary action
AppButton.secondary(
  child: Text('Cancel'),
  onPressed: () => goBack(),
)

// Destructive action
AppButton.destructive(
  child: Text('Delete'),
  onPressed: () => confirmDelete(),
)
```

### Icon Buttons
```dart
// Square icon button
AppButton.icon(
  icon: Icons.favorite,
  onPressed: () => toggleFavorite(),
  variant: AppButtonVariant.primary,
)

// Rounded icon button
AppButton.iconRounded(
  icon: Icons.add,
  onPressed: () => addItem(),
  variant: AppButtonVariant.primary,
)
```

### Advanced Usage
```dart
AppButton.primary(
  child: Text('Upload File'),
  icon: Icons.upload,
  size: AppButtonSize.lg,
  isLoading: isUploading,
  fullWidth: true,
  onPressed: isUploading ? null : () => uploadFile(),
)
```

### Compact Usage
```dart
AppButton.compact(
  child: Text('NEW'),
  onPressed: () => showNewFeature(),
  variant: AppButtonVariant.secondary,
)
```

## Customization Guidelines

### When to Extend
- Creating domain-specific button variants (e.g., social login buttons)
- Adding new visual states (e.g., selected, active)
- Implementing platform-specific behaviors
- Adding accessibility features for specific use cases

### How to Modify
1. **New Variants**: Add to `AppButtonVariant` enum and update `_getButtonStyle()` method
2. **Factory Constructors**: Add semantic constructors for common patterns
3. **Custom Styling**: Modify variant-specific styling in the switch statement
4. **New Sizes**: Add to `AppButtonSize` enum and update size calculations

### Code Patterns
```dart
// Adding a social login variant
factory AppButton.google({
  required VoidCallback? onPressed,
  bool isLoading = false,
}) {
  return AppButton._(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/google_logo.png', width: 20),
        SizedBox(width: 8),
        Text('Continue with Google'),
      ],
    ),
    onPressed: onPressed,
    variant: AppButtonVariant.outline,
    isLoading: isLoading,
  );
}
```

## Related Components
- **AppClickableCard**: Use for larger interactive areas that aren't traditional buttons
- **AppTextField**: Often paired with buttons in forms
- **NavigationBar**: Use for bottom navigation instead of button rows
- **FloatingActionButton**: Use material FAB for primary floating actions

## Design System Integration

### Design Tokens Used
- **Colors**: `primary`, `secondary`, `surface`, `error` from theme
- **Typography**: `labelLarge`, `labelMedium`, `labelSmall` based on size
- **Spacing**: `xs`, `sm`, `md`, `lg`, `xl` for padding and gaps
- **Radius**: `defaultRadius` or custom `AppRadius` values
- **Shadows**: `sm`, `md`, `lg` for elevation effects
- **Density**: `buttonMinHeight`, `buttonPadding`, `iconButtonPadding`

### Theme Integration
- Automatically adapts to light/dark themes
- Uses `AppThemeExtension` for custom properties like disabled color
- Respects system color schemes and accessibility preferences
- Supports custom density settings per component

## Accessibility
- Semantic button role for screen readers
- Focus indicators with proper contrast
- Keyboard navigation support (Enter/Space activation)
- Disabled state announced to assistive technology
- Minimum touch target size (44x44pt) maintained
- High contrast color combinations

## Platform Considerations
- **Web**: Hover states, cursor changes, focus rings, keyboard shortcuts
- **Mobile**: Haptic feedback on interaction, appropriate touch targets
- **Desktop**: Keyboard navigation, context menus, precise mouse interactions
- **All Platforms**: Loading states, proper animations, theme adaptations

## Examples in Playground
See `app_button_showcase_page.dart` for comprehensive examples including:
- All variants with different states
- Size variations and responsive behavior
- Icon combinations and positioning
- Loading states and disabled states
- Custom properties and density settings
- Accessibility and platform-specific features

## Migration Notes
- Replaces legacy button implementations
- Factory constructors provide semantic API
- Icon buttons now enforce square dimensions
- Loading state built-in (no external wrapper needed)
- Density can be customized per button instance