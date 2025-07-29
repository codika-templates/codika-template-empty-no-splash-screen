# AppLoadingIndicator

## Overview

AppLoadingIndicator is a versatile component for displaying loading states with multiple animation variants. It provides consistent loading animations that integrate seamlessly with the design system's color tokens and theming. All variants are optimized for performance and accessibility, offering different visual styles to match various UI contexts.

## Use Cases

- **Loading States**: Display loading animations during data fetching, form submissions, or processing
- **Button Loading**: Show inline loading indicators within buttons during actions
- **Page Loading**: Provide visual feedback during page transitions or content loading
- **Background Processing**: Indicate ongoing background operations
- **Custom Loading UI**: Create consistent loading experiences across the application
- **Avoid Using When**: Don't use for very short operations (< 500ms) or when users need specific progress information

## Component API

### Required Parameters

None - all parameters are optional with sensible defaults.

### Optional Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `size` | `AppLoadingIndicatorSize` | `medium` | Predefined size preset for the indicator |
| `color` | `Color?` | `null` | Custom color (defaults to primary theme color) |
| `strokeWidth` | `double?` | `2.0` | Stroke width for circular variant only |

### Enums & Types

```dart
enum AppLoadingIndicatorVariant { circular, dots, pulse, bars }

enum AppLoadingIndicatorSize { 
  small(16.0), 
  medium(24.0), 
  large(32.0), 
  extraLarge(48.0) 
}
```

## Variants & States

### Variants

- **Circular**: Material Design circular progress indicator for general loading states
- **Dots**: Three animated dots for casual or playful loading contexts
- **Pulse**: Pulsing circle animation for subtle, ambient loading indicators
- **Bars**: Animated bars for more dynamic and prominent loading states

### States

- **Default**: Standard appearance with theme-appropriate colors
- **Custom Colored**: Override with specific colors for branding or context
- **Sized**: Multiple predefined sizes for different UI contexts
- **Themed**: Automatically adapts to design system color tokens

## Usage Examples

### Basic Usage

```dart
// Simple circular loading indicator
AppLoadingIndicator.circular()

// Dots indicator with custom size
AppLoadingIndicator.dots(
  size: AppLoadingIndicatorSize.large,
)

// Pulse indicator with custom color
AppLoadingIndicator.pulse(
  color: AppColors.success.resolve(context),
)
```

### With Variants

```dart
// Different animation styles
AppLoadingIndicator.circular(
  size: AppLoadingIndicatorSize.medium,
  strokeWidth: 3.0,
)

AppLoadingIndicator.bars(
  size: AppLoadingIndicatorSize.small,
  color: AppColors.primary.resolve(context, shade: 600),
)

AppLoadingIndicator.pulse(
  size: AppLoadingIndicatorSize.extraLarge,
  color: Colors.blue.withValues(alpha: 0.7),
)
```

### Advanced Usage

```dart
// Custom stroke width for circular
AppLoadingIndicator.circular(
  size: AppLoadingIndicatorSize.large,
  strokeWidth: 1.0,
  color: AppColors.neutral.resolve(context, shade: 400),
)

// Inline loading in button
Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    AppLoadingIndicator.circular(
      size: AppLoadingIndicatorSize.small,
    ),
    AppSpacing.sm.gapH,
    Text('Saving...'),
  ],
)

// Centered page loading
Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      AppLoadingIndicator.dots(
        size: AppLoadingIndicatorSize.extraLarge,
      ),
      AppSpacing.md.gapV,
      Text('Loading content...'),
    ],
  ),
)
```

## Customization Guidelines

### When to Extend

- Adding new animation patterns (e.g., ripple effects, morphing shapes)
- Creating specialized variants for specific use cases
- Implementing custom duration or easing curves
- Adding progress percentage display capabilities

### How to Modify

1. **Adding Variants**: Extend the variant enum and add corresponding factory constructors
2. **New Animations**: Create custom stateful widgets with animation controllers
3. **Custom Sizing**: Add new size presets to the enum or allow custom dimensions
4. **Color Schemes**: Integrate with additional color tokens or theme properties

### Code Patterns

```dart
// Custom variant example
factory AppLoadingIndicator.ripple({
  Key? key,
  AppLoadingIndicatorSize size = AppLoadingIndicatorSize.medium,
  Color? color,
}) {
  return AppLoadingIndicator._(
    key: key,
    variant: AppLoadingIndicatorVariant.ripple,
    size: size,
    color: color,
  );
}

// Custom color usage
AppLoadingIndicator.circular(
  color: AppColors.accent.resolve(context, shade: 500),
  size: AppLoadingIndicatorSize.large,
)
```

## Related Components

- **AppLoadingOverlay**: Use loading indicators within loading overlays
- **AppButton**: Integrate with button loading states
- **AppProgressBar**: Use for determinate progress indication
- **AppSkeletonLoader**: Combine with skeleton loading patterns

## Design System Integration

### Design Tokens Used

- **Colors**: `AppColors.primary` and all color variants with context resolution
- **Sizing**: Predefined size scales matching design system spacing
- **Animation**: Consistent timing and easing curves
- **Theme Integration**: Automatic color adaptation for light/dark modes

### Theme Integration

- Respects theme color schemes with automatic adaptation
- Uses design system color resolution methods
- Integrates with Material Design theming
- Maintains visual consistency across different contexts

## Accessibility

- Semantic loading role for screen readers
- Appropriate animation duration for accessibility preferences
- High contrast support through color system integration
- Reduced motion respect through Flutter's accessibility settings
- Proper focus management when used in interactive contexts

## Platform Considerations

- **Web**: Smooth CSS-like animations with optimal performance
- **Mobile**: Battery-efficient animations with proper lifecycle management
- **Desktop**: Appropriate sizing for mouse interaction contexts
- **All Platforms**: Consistent visual appearance and timing

## Performance Considerations

- Optimized animation controllers with proper disposal
- Efficient custom painters for complex animations
- Minimal rebuild overhead with proper widget composition
- Memory-efficient animation loops with controlled repetition
- GPU-accelerated transforms for smooth performance

## Examples in Playground

See `app_loading_indicator_showcase_page.dart` for comprehensive examples showing:
- All indicator variants with customization controls
- Interactive size and color selection
- Usage patterns in different contexts
- Performance demonstrations across variants
- Dark/light theme compatibility testing

## Migration Notes

This is a new component with no migration requirements. Designed to replace any existing loading widgets with consistent design system integration.

## Common Use Cases

### Button Loading States
```dart
AppButton.primary(
  isLoading: true,
  loadingIndicator: AppLoadingIndicator.circular(
    size: AppLoadingIndicatorSize.small,
  ),
  child: Text('Save'),
)
```

### Page Loading
```dart
if (isLoading)
  Center(
    child: AppLoadingIndicator.dots(
      size: AppLoadingIndicatorSize.large,
    ),
  )
else
  ContentWidget()
```

### Inline Loading
```dart
Row(
  children: [
    if (isProcessing) ...[
      AppLoadingIndicator.pulse(
        size: AppLoadingIndicatorSize.small,
      ),
      AppSpacing.sm.gapH,
    ],
    Text(isProcessing ? 'Processing...' : 'Complete'),
  ],
)
```