# AppCard & AppClickableCard

## Overview
AppCard provides the foundation for container-based UI elements with consistent styling and elevation. AppClickableCard extends this with interactive capabilities, hover effects, and web-optimized touch handling. These components are essential for organizing content into digestible, actionable sections.

## Use Cases
- **Content Organization**: Grouping related information (user profiles, product listings, articles)
- **Interactive Lists**: Clickable items that navigate or trigger actions
- **Dashboard Widgets**: Summary cards showing key metrics or status
- **Settings Panels**: Grouped configuration options
- **Navigation Cards**: Visual navigation elements with preview content
- **Avoid Using When**: For simple text grouping (use containers), complex multi-action interfaces, or primary navigation

## Component API

### AppCard (Base Component)

#### Required Parameters
| Parameter | Type | Description |
|-----------|------|-------------|
| `child` | `Widget` | Content displayed inside the card |

#### Optional Parameters
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `variant` | `AppCardVariant` | `elevated` | Visual style variant |
| `padding` | `EdgeInsets?` | `AppSpacing.md` | Internal padding |
| `borderRadius` | `AppRadius?` | `theme default` | Corner radius |
| `backgroundColor` | `Color?` | `theme surface` | Background color |
| `borderColor` | `Color?` | `theme border` | Border color (outlined variant) |
| `shadows` | `List<BoxShadow>?` | `variant default` | Drop shadow |
| `width` | `double?` | `null` | Fixed width |
| `height` | `double?` | `null` | Fixed height |

### AppClickableCard (Interactive Extension)

#### Additional Parameters
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `onTap` | `VoidCallback?` | `null` | Tap callback (null = non-interactive) |
| `showHoverEffect` | `bool` | `true` | Enable hover state styling |
| `showRipple` | `bool` | `true` | Material ripple effect |
| `feedbackType` | `FeedbackType?` | `FeedbackType.light` | Haptic feedback type |
| `tooltip` | `String?` | `null` | Tooltip text on hover |

### Enums & Types
```dart
enum AppCardVariant { elevated, outlined, filled }
enum FeedbackType { light, medium, heavy, selection, impact, error, success }
```

## Variants & States

### Variants
- **Elevated**: Default card with shadow and raised appearance
- **Outlined**: Bordered card with transparent background
- **Filled**: Card with tinted background, no shadow

### States (AppClickableCard only)
- **Default**: Normal appearance with subtle interactive hints
- **Hover**: Enhanced shadow, slight background tint, cursor change (web)
- **Pressed**: Scaled down slightly with darker background
- **Disabled**: No interaction when onTap is null

## Usage Examples

### Basic Card
```dart
AppCard(
  child: Column(
    children: [
      Text('Card Title', style: AppTextStyle.titleMedium.style),
      SizedBox(height: 8),
      Text('Card content goes here'),
    ],
  ),
)
```

### Variant Examples
```dart
// Elevated card (default)
AppCard(
  variant: AppCardVariant.elevated,
  child: Text('Elevated card'),
)

// Outlined card
AppCard(
  variant: AppCardVariant.outlined,
  child: Text('Outlined card'),
)

// Filled card
AppCard(
  variant: AppCardVariant.filled,
  child: Text('Filled card'),
)
```

### Interactive Cards
```dart
AppClickableCard(
  variant: AppCardVariant.elevated,
  onTap: () => navigateToDetail(),
  child: ListTile(
    leading: Icon(Icons.person),
    title: Text('John Doe'),
    subtitle: Text('Software Engineer'),
    trailing: Icon(Icons.arrow_forward_ios),
  ),
)
```

### Advanced Customization
```dart
AppCard(
  variant: AppCardVariant.elevated,
  width: 300,
  height: 200,
  borderRadius: AppRadius.lg,
  backgroundColor: Colors.blue.shade50,
  shadows: AppShadows.lg.shadows,
  padding: AppSpacing.lg.padding,
  child: CustomCardContent(),
)
```

### Dashboard Widget Example
```dart
AppClickableCard(
  variant: AppCardVariant.filled,
  onTap: () => showDetailView(),
  child: Padding(
    padding: AppSpacing.md.padding,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.analytics, color: theme.primary),
            SizedBox(width: 8),
            Text('Monthly Sales', style: AppTextStyle.titleMedium.style),
          ],
        ),
        SizedBox(height: 16),
        Text('\$24,532', style: AppTextStyle.headlineSmall.style),
        Text('+12% from last month', style: AppTextStyle.bodySmall.style),
      ],
    ),
  ),
)
```

## Customization Guidelines

### When to Extend
- Creating domain-specific card types (e.g., ProductCard, UserCard)
- Adding new visual variants for brand-specific styling
- Implementing specialized interaction patterns
- Adding analytics or tracking capabilities

### How to Modify
1. **New Variants**: Add to `AppCardVariant` enum and update styling logic
2. **Custom Cards**: Create wrapper components that use AppCard/AppClickableCard
3. **Interaction States**: Extend the state management in AppClickableCard
4. **Styling**: Override colors, shadows, or radius through parameters

### Code Patterns
```dart
// Custom product card component
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  
  const ProductCard({
    required this.product,
    this.onTap,
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    return AppClickableCard(
      variant: AppCardVariant.elevated,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(product.imageUrl),
          SizedBox(height: 8),
          Text(product.name, style: AppTextStyle.titleMedium.style),
          Text('\$${product.price}', style: AppTextStyle.bodyMedium.style),
        ],
      ),
    );
  }
}
```

## Interaction Feedback

AppClickableCard integrates with the global `InteractionFeedbackService` to provide consistent haptic and audio feedback across the application.

### Feedback Types
- **light**: Subtle feedback for gentle interactions
- **medium**: Standard feedback for normal interactions  
- **heavy**: Strong feedback for important actions
- **selection**: Feedback for selecting items
- **impact**: Feedback for button-like interactions
- **error**: Double vibration for error states
- **success**: Success pattern for completed actions

### Usage
```dart
AppClickableCard(
  feedbackType: FeedbackType.selection,
  onTap: () => selectItem(),
  child: Text('Select me'),
)
```

### Global Configuration
```dart
// Disable all haptic feedback
feedbackService.configure(enableHaptics: false);

// Enable audio feedback (requires custom audio callbacks)
feedbackService.configure(enableAudio: true);
```

## Related Components
- **AppButton**: Use for single-action items instead of clickable cards
- **ListTile**: Consider for simple list items with standard layouts
- **Container**: Use for non-semantic grouping without card semantics
- **ShowcaseCard**: Specialized card for the design system playground

## Design System Integration

### Design Tokens Used
- **Colors**: `surface`, `surfaceContainerHighest`, `primary`, `outline`
- **Spacing**: `md` default padding, customizable with all spacing tokens
- **Radius**: `defaultRadius` from theme, customizable with `AppRadius`
- **Shadows**: `sm` (elevated), `md` (hover), `lg` (pressed)
- **Typography**: Flexible - uses whatever styles are provided in child

### Theme Integration
- Automatically adapts to light/dark themes
- Uses theme surface colors and elevation
- Respects theme border colors and outline styles
- Supports theme extension properties

## Accessibility
- Semantic container role for screen readers
- Focus indicators with proper contrast ratios
- Keyboard navigation support (Enter/Space for clickable cards)
- Touch target requirements met (minimum 44x44pt)
- Screen reader announcements for state changes
- High contrast mode support

## Platform Considerations
- **Web**: Hover states, cursor changes, focus rings, keyboard shortcuts
- **Mobile**: Haptic feedback, appropriate touch targets, gesture recognition
- **Desktop**: Keyboard navigation, context menus, precise mouse interactions
- **All Platforms**: Smooth animations, theme adaptations, responsive sizing

## Examples in Playground
See `app_card_showcase_page.dart` for comprehensive examples including:
- All variants with different content types
- Interactive states and behaviors
- Custom sizing and styling options
- Real-world usage patterns (user profiles, products, articles)
- Accessibility and platform-specific features
- Performance considerations for large lists

## Migration Notes
- Replaces custom card implementations with standardized design
- Interactive cards now handle all states internally
- Hover effects are built-in for web platforms
- Ripple effects use Material design standards
- Focus management follows accessibility best practices