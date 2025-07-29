# AppDivider

## Overview

AppDivider is a versatile component for creating visual separations between content sections. It provides multiple variants including solid lines, gradient fades, text separators, icon dividers, and stylized dotted/dashed patterns. The component supports both horizontal and vertical orientations and integrates seamlessly with the app's color system and theming.

## Use Cases

- **Content Separation**: Create clear visual boundaries between different content sections
- **Form Sections**: Separate groups of form fields or settings
- **List Items**: Add subtle separations in long lists or navigation menus
- **Decorative Elements**: Use text or icon variants for more prominent section breaks
- **Layout Structure**: Implement vertical dividers in sidebar layouts or multi-column designs
- **Avoid Using When**: Don't use for spacing alone - prefer spacing tokens for consistent layouts

## Component API

### Required Parameters

None - all parameters are optional with sensible defaults.

### Optional Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `orientation` | `AppDividerOrientation` | `horizontal` | Direction of the divider line |
| `thickness` | `double` | `1.0` | Line thickness in pixels |
| `color` | `Color?` | `null` | Custom color (defaults to theme divider color) |
| `padding` | `EdgeInsetsGeometry` | `EdgeInsets.zero` | Padding around the entire divider |
| `gradientFadeRatio` | `double` | `0.3` | Controls gradient fade intensity (0.0-1.0) |
| `text` | `String?` | `null` | Text to display in center (text variant only) |
| `textStyle` | `TextStyle?` | `null` | Custom text styling |
| `icon` | `IconData?` | `null` | Icon to display in center (icon variant only) |
| `iconSize` | `double?` | `18.0` | Size of the center icon |
| `indent` | `double?` | `null` | Starting indent for line variants |
| `endIndent` | `double?` | `null` | Ending indent for line variants |

### Enums & Types

```dart
enum AppDividerVariant { solid, gradient, text, icon, dotted, dashed }
enum AppDividerOrientation { horizontal, vertical }
```

## Variants & States

### Variants

- **Solid**: Clean, simple line divider for basic content separation
- **Gradient**: Fades from transparent to color, creating subtle transitions
- **Text**: Centers text between gradient fade lines for labeled sections
- **Icon**: Centers icon between gradient fade lines for decorative breaks
- **Dotted**: Stylized dotted line pattern for casual or decorative use
- **Dashed**: Professional dashed line pattern for emphasis

### States

- **Default**: Standard appearance with theme-appropriate colors
- **Custom Colored**: Override with specific colors for branding or emphasis
- **Themed**: Automatically adapts to light/dark mode color schemes

## Usage Examples

### Basic Usage

```dart
// Simple horizontal divider
AppDivider.solid()

// Gradient fade divider
AppDivider.gradient(
  gradientFadeRatio: 0.2,
  thickness: 2.0,
)
```

### With Variants

```dart
// Text separator
AppDivider.text(
  text: 'OR',
  thickness: 1.5,
  gradientFadeRatio: 0.3,
)

// Icon divider
AppDivider.icon(
  icon: Icons.star,
  iconSize: 16,
  color: AppColors.primary.resolve(context),
)

// Dotted line
AppDivider.dotted(
  thickness: 2.0,
  color: AppColors.neutral.resolve(context, shade: 300),
)
```

### Advanced Usage

```dart
// Vertical divider with custom styling
AppDivider.solid(
  orientation: AppDividerOrientation.vertical,
  thickness: 1.5,
  color: AppColors.primary.resolve(context, shade: 200),
  padding: EdgeInsets.symmetric(vertical: 8),
)

// Custom text divider with styling
AppDivider.text(
  text: 'SECTION BREAK',
  thickness: 1.0,
  gradientFadeRatio: 0.1,
  textStyle: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  ),
)

// Indented solid divider
AppDivider.solid(
  thickness: 1.0,
  indent: 20,
  endIndent: 20,
  color: AppColors.neutral.resolve(context, shade: 200),
)
```

## Customization Guidelines

### When to Extend

- Adding new visual patterns (e.g., double lines, wavy lines)
- Creating specialized variants for specific use cases
- Adding animation support for dynamic dividers
- Implementing custom painter variants

### How to Modify

1. **Adding Variants**: Extend the variant enum and add corresponding factory constructors
2. **New Visual Patterns**: Create custom painter classes for complex line patterns
3. **Animation Support**: Wrap in AnimatedBuilder for dynamic effects
4. **Custom Styling**: Override color resolution or add theme-specific variants

### Code Patterns

```dart
// Adding a custom variant
factory AppDivider.wavy({
  Key? key,
  double thickness = 1.0,
  Color? color,
  double amplitude = 4.0,
}) {
  return AppDivider._(
    key: key,
    variant: AppDividerVariant.wavy,
    thickness: thickness,
    color: color,
    // Additional custom parameters
  );
}

// Custom color usage
AppDivider.gradient(
  color: AppColors.accent.resolve(context, shade: 400),
  gradientFadeRatio: 0.15,
)
```

## Related Components

- **AppCard**: Use dividers to separate card content sections
- **AppBottomSheet**: Implement dividers for content organization
- **AppButton**: Combine with text dividers for action grouping
- **Layout Widgets**: Use vertical dividers in Row/Column layouts

## Design System Integration

### Design Tokens Used

- **Colors**: `dividerColor`, `borderColor`, custom color resolution
- **Typography**: `labelLarge`, `labelMedium`, `labelSmall` for text variants
- **Spacing**: `AppSpacing.xs`, `AppSpacing.md` for padding and gaps
- **Responsive**: Automatic color adjustment for light/dark themes

### Theme Integration

- Respects theme color schemes with automatic light/dark adaptation
- Uses context extension methods for consistent color application
- Integrates with AppColors system for shade-based customization
- Maintains visual hierarchy through proper color relationships

## Accessibility

- Semantic separation role for screen readers
- Sufficient color contrast for visibility
- Text variants provide meaningful content labels
- Icon variants include semantic meaning through icon choice
- Respects user's preferred contrast and color settings

## Platform Considerations

- **Web**: Smooth rendering of gradient effects and custom painting
- **Mobile**: Optimized custom painters for performance
- **Desktop**: Appropriate sizing for different screen densities
- **All Platforms**: Consistent visual appearance across environments

## Examples in Playground

See `app_divider_showcase_page.dart` for comprehensive examples showing:
- All divider variants with customization controls
- Interactive thickness and gradient fade adjustments
- Color picker for testing different color combinations
- Vertical and horizontal orientation examples
- Usage in context with real content layouts
- Dark/light theme demonstrations

## Migration Notes

This is a new component with no migration requirements. Integrates cleanly with existing design system patterns and color tokens.

## Performance Considerations

- Custom painters are optimized for efficient rendering
- Gradient calculations are cached where possible
- Text and icon variants use standard Flutter widgets for optimal performance
- Minimal rebuild overhead with proper widget composition