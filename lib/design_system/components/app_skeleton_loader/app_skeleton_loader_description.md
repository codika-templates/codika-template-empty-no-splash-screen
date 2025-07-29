# AppSkeletonLoader

## Overview

AppSkeletonLoader is a comprehensive component for creating skeleton loading states that maintain the visual structure of content while it loads. It provides animated shimmer effects with multiple variants and pre-built patterns for common UI layouts. The component integrates seamlessly with the design system's color, spacing, and radius tokens, offering both individual skeleton elements and complete patterns for complex layouts.

## Use Cases

- **Content Loading**: Display placeholder content while data is being fetched from APIs
- **Image Loading**: Show skeleton shapes while images or media content loads
- **List Loading**: Maintain list structure during data loading with skeleton items
- **Card Loading**: Preview card layouts before content is available
- **Page Loading**: Show skeleton versions of entire pages or sections
- **Progressive Loading**: Display skeleton elements that are replaced incrementally as content loads
- **Avoid Using When**: Don't use for very short loading times (< 300ms) or when showing specific progress information is more appropriate

## Component API

### Required Parameters

None - all parameters are optional with sensible defaults.

### Optional Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `width` | `double?` | `null` | Width of skeleton element (defaults to intrinsic width) |
| `height` | `double?` | `16.0` | Height of skeleton element |
| `borderRadius` | `BorderRadius?` | `null` | Custom border radius (defaults to design system values) |
| `baseColor` | `Color?` | `null` | Base color for skeleton (defaults to neutral-100) |
| `highlightColor` | `Color?` | `null` | Highlight color for animation (defaults to neutral-200) |
| `animationDuration` | `Duration` | `1500ms` | Duration of one animation cycle |
| `enabled` | `bool` | `true` | Whether skeleton animation is active |
| `child` | `Widget?` | `null` | Child widget for wrap variant |

### Enums & Types

```dart
enum AppSkeletonLoaderVariant { container, text, circle, card }
```

## Variants & States

### Variants

- **Container**: Generic rectangular skeleton for containers, images, and content blocks
- **Text**: Rounded rectangle optimized for text line placeholders
- **Circle**: Circular skeleton for avatars, profile pictures, and round icons
- **Card**: Card-shaped skeleton with proper radius for card-style content

### Pre-built Patterns

- **List Item**: Complete list item with optional avatar and subtitle
- **Card**: Card layout with optional image and multiple text lines
- **Article**: Article layout with title, optional image, and paragraphs
- **Profile**: User profile with avatar, name, and subtitle

### States

- **Animated**: Shimmer animation moves across the skeleton (default)
- **Static**: No animation, shows solid color placeholder
- **Wrapped**: Skeleton effect applied to existing child content
- **Grouped**: Multiple skeleton elements with consistent spacing

## Usage Examples

### Basic Usage

```dart
// Simple container skeleton
AppSkeletonLoader.container(
  width: double.infinity,
  height: 40.0,
)

// Text line skeleton
AppSkeletonLoader.text(
  width: 200.0,
  height: 16.0,
)

// Circular avatar skeleton
AppSkeletonLoader.circle(diameter: 50.0)

// Card skeleton
AppSkeletonLoader.card(
  width: double.infinity,
  height: 120.0,
)
```

### With Customization

```dart
// Custom colored skeleton
AppSkeletonLoader.container(
  width: double.infinity,
  height: 60.0,
  baseColor: AppColors.neutral.resolve(context, shade: 50),
  highlightColor: AppColors.neutral.resolve(context, shade: 100),
  animationDuration: Duration(milliseconds: 2000),
)

// Disabled animation
AppSkeletonLoader.text(
  width: 150.0,
  enabled: false,
)

// Custom border radius
AppSkeletonLoader.container(
  width: 100.0,
  height: 100.0,
  borderRadius: BorderRadius.circular(20.0),
)
```

### Pre-built Patterns

```dart
// List item with avatar
AppSkeletonPatterns.listItem(
  hasAvatar: true,
  hasSubtitle: true,
)

// Card with image
AppSkeletonPatterns.card(
  hasImage: true,
  textLines: 3,
)

// Article pattern
AppSkeletonPatterns.article(
  hasImage: true,
  paragraphs: 2,
)

// Profile pattern
AppSkeletonPatterns.profile()
```

### Advanced Usage

```dart
// Grouped skeleton elements
AppSkeletonGroup(
  spacing: 12.0,
  children: [
    AppSkeletonLoader.text(width: double.infinity),
    AppSkeletonLoader.text(width: double.infinity),
    AppSkeletonLoader.text(width: 150.0),
  ],
)

// Wrapped content skeleton
AppSkeletonLoader.wrap(
  enabled: isLoading,
  child: Text('Content being loaded'),
)

// Custom list of skeletons
ListView.builder(
  itemCount: 5,
  itemBuilder: (context, index) => Padding(
    padding: AppSpacing.md.paddingVertical,
    child: AppSkeletonPatterns.listItem(),
  ),
)
```

## Customization Guidelines

### When to Extend

- Creating domain-specific skeleton patterns (e.g., product cards, message bubbles)
- Adding new animation effects or timing variations
- Implementing responsive skeleton layouts
- Adding skeleton variants for custom component shapes

### How to Modify

1. **Custom Patterns**: Create static methods in `AppSkeletonPatterns` for reusable layouts
2. **Animation Variations**: Modify animation controller settings for different effects
3. **Color Schemes**: Create themed skeleton color variants
4. **Shapes**: Add new variants to the enum with corresponding factory constructors

### Code Patterns

```dart
// Custom pattern example
static Widget productCard({bool enabled = true}) {
  return AppSkeletonLoader.card(
    height: 250.0,
    enabled: enabled,
    child: Column(
      children: [
        AppSkeletonLoader.container(
          width: double.infinity,
          height: 150.0,
          enabled: enabled,
        ),
        AppSpacing.md.gapV,
        AppSkeletonLoader.text(
          width: double.infinity,
          enabled: enabled,
        ),
        AppSpacing.sm.gapV,
        AppSkeletonLoader.text(
          width: 100.0,
          enabled: enabled,
        ),
      ],
    ),
  );
}

// Conditional skeleton
Widget buildContent() {
  return isLoading 
    ? AppSkeletonPatterns.listItem()
    : ListTile(
        leading: CircleAvatar(/* ... */),
        title: Text(data.title),
        subtitle: Text(data.subtitle),
      );
}
```

## Related Components

- **AppLoadingIndicator**: Use for indeterminate loading without content structure
- **AppProgressBar**: Combine with skeleton for progress indication
- **AppLoadingOverlay**: Use skeleton within loading overlays
- **ListView/GridView**: Integrate skeleton patterns for list loading states

## Design System Integration

### Design Tokens Used

- **Colors**: `AppColors.neutral` with shade variations for base and highlight
- **Spacing**: `AppSpacing` values for consistent gaps in patterns
- **Radius**: `AppRadius` values for consistent border radius
- **Animation**: Standardized timing and easing curves

### Theme Integration

- Automatic color adaptation for light/dark themes
- Uses design system color resolution methods
- Respects accessibility preferences for reduced motion
- Maintains proper contrast ratios across themes

## Accessibility

- Respects reduced motion preferences by disabling animation
- Proper semantic structure maintained in patterns
- Screen reader announcements can be configured
- High contrast support through color system integration
- Maintains focus management during skeleton-to-content transitions

## Platform Considerations

- **Web**: Smooth GPU-accelerated animations with CSS-like performance
- **Mobile**: Battery-efficient animations with proper lifecycle management
- **Desktop**: Appropriate sizing for different screen densities
- **All Platforms**: Consistent visual appearance and animation timing

## Performance Considerations

- Optimized animation controllers with efficient disposal
- GPU-accelerated gradient animations
- Minimal rebuild overhead with targeted animations
- Memory-efficient pattern implementations
- Proper animation lifecycle management to prevent memory leaks

## Examples in Playground

See `app_skeleton_loader_showcase_page.dart` for comprehensive examples showing:
- All skeleton variants with customization controls
- Pre-built patterns in different configurations
- Animation speed and color customization
- Comparison between skeleton and real content
- Grouped skeleton layouts and spacing options

## Migration Notes

This is a new component designed to replace existing skeleton loading implementations. Provides more flexibility and better design system integration than previous solutions.

## Common Use Cases

### Loading List Items
```dart
ListView.builder(
  itemCount: isLoading ? 5 : data.length,
  itemBuilder: (context, index) {
    if (isLoading) {
      return AppSkeletonPatterns.listItem();
    }
    return ListTile(/* real content */);
  },
)
```

### Loading Card Grid
```dart
GridView.builder(
  itemCount: isLoading ? 6 : products.length,  
  itemBuilder: (context, index) {
    if (isLoading) {
      return AppSkeletonPatterns.card(
        hasImage: true,
        textLines: 2,
      );
    }
    return ProductCard(products[index]);
  },
)
```

### Profile Loading
```dart
Column(
  children: [
    if (isLoading)
      AppSkeletonPatterns.profile()
    else
      UserProfile(user: user),
    
    AppSpacing.lg.gapV,
    
    if (isLoading) 
      AppSkeletonPatterns.article(paragraphs: 3)
    else
      UserBio(bio: user.bio),
  ],
)
```

### Progressive Loading
```dart
Column(
  children: [
    // Always show title skeleton until loaded
    AppSkeletonLoader.text(
      width: 200.0,
      height: 24.0,
      enabled: title == null,
      child: title != null ? Text(title!) : null,
    ),
    
    AppSpacing.md.gapV,
    
    // Show content skeleton until loaded
    isContentLoaded 
      ? ContentWidget(content)
      : AppSkeletonPatterns.article(paragraphs: 2),
  ],
)
```