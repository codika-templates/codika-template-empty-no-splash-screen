# AppBottomBar

## Overview
AppBottomBar is a comprehensive bottom navigation component that provides consistent navigation patterns across the application. It offers multiple variants including standard, floating, and notched styles, with support for badges, custom icons, and various sizes to accommodate different design needs and accessibility requirements.

## Use Cases
- **Primary Navigation**: Main app navigation between top-level destinations
- **Tab Switching**: Switching between different content views or modes
- **E-commerce Apps**: Navigation between shop, cart, profile, and other key sections
- **Social Apps**: Navigation with message/notification badges and status indicators
- **Content Apps**: Navigation between feeds, search, favorites, and profile
- **Avoid Using When**: For secondary navigation, overflow menus, or when you have more than 5 destinations

## Component API

### Required Parameters
| Parameter | Type | Description |
|-----------|------|-------------|
| `items` | `List<AppBottomBarItem>` | List of navigation items (minimum 2, maximum recommended 5) |
| `currentIndex` | `int` | Currently selected item index |

### Optional Parameters
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `onTap` | `ValueChanged<int>?` | `null` | Callback when item is tapped |
| `variant` | `AppBottomBarVariant` | `standard` | Visual style variant |
| `size` | `AppBottomBarSize` | `standard` | Size of icons and text |
| `density` | `AppDensity?` | `null` | Override theme density |
| `backgroundColor` | `Color?` | `null` | Custom background color |
| `surfaceTintColor` | `Color?` | `null` | Surface tint color |
| `elevation` | `double?` | `null` | Custom elevation |
| `borderRadius` | `AppRadius?` | `null` | Custom border radius (floating variant) |
| `margin` | `EdgeInsets?` | `null` | Custom margin (floating variant) |
| `showLabels` | `bool` | `true` | Show labels for selected items |
| `showUnselectedLabels` | `bool` | `true` | Show labels for unselected items |
| `feedbackType` | `FeedbackType?` | `null` | Haptic feedback type |
| `type` | `BottomNavigationBarType?` | `null` | Navigation bar type (fixed/shifting) |

### Enums & Types
```dart
enum AppBottomBarVariant { standard, floating, notched }
enum AppBottomBarSize { compact, standard, comfortable }

class AppBottomBarItem {
  final IconData icon;           // Required icon
  final IconData? activeIcon;    // Optional different icon when selected
  final String label;            // Required text label
  final Widget? badge;           // Optional badge widget
  final Color? color;            // Optional custom color
  final Color? activeColor;      // Optional custom active color
}
```

## Variants & States

### Variants
- **Standard**: Traditional bottom navigation bar attached to bottom of screen
- **Floating**: Elevated bar with rounded corners and margin from edges
- **Notched**: Designed to work with FloatingActionButton, has notch cutout
- **Compact**: Icon-only variant without labels for space-constrained layouts

### States
- **Default**: Normal interactive state with proper contrast
- **Selected**: Highlighted item with primary color and optional active icon
- **Unselected**: Subdued items with secondary colors
- **Disabled**: Non-interactive state when onTap is null
- **With Badges**: Items showing notification counts or status indicators

## Usage Examples

### Basic Usage
```dart
AppBottomBar.standard(
  items: [
    AppBottomBarItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
    ),
    AppBottomBarItem(
      icon: Icons.search_outlined,
      activeIcon: Icons.search,
      label: 'Search',
    ),
  ],
  currentIndex: 0,
  onTap: (index) => navigateToTab(index),
)
```

### Variant Examples
```dart
// Standard bottom bar
AppBottomBar.standard(
  items: navigationItems,
  currentIndex: currentTab,
  onTap: (index) => setState(() => currentTab = index),
)

// Floating bottom bar
AppBottomBar.floating(
  items: navigationItems,
  currentIndex: currentTab,
  onTap: (index) => setState(() => currentTab = index),
  borderRadius: AppRadius.xl,
  margin: EdgeInsets.all(16),
)

// Notched for FAB
AppBottomBar.notched(
  items: navigationItems,
  currentIndex: currentTab,
  onTap: (index) => setState(() => currentTab = index),
  showUnselectedLabels: false,
)

// Compact icon-only
AppBottomBar.compact(
  items: navigationItems,
  currentIndex: currentTab,
  onTap: (index) => setState(() => currentTab = index),
)
```

### Items with Badges
```dart
AppBottomBar.standard(
  items: [
    AppBottomBarItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
    ),
    AppBottomBarItem(
      icon: Icons.chat_outlined,
      activeIcon: Icons.chat,
      label: 'Messages',
      badge: Text('3'), // Text badge
    ),
    AppBottomBarItem(
      icon: Icons.notifications_outlined,
      activeIcon: Icons.notifications,
      label: 'Notifications',
      badge: Container( // Dot badge
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    ),
  ],
  currentIndex: currentTab,
  onTap: (index) => handleTabChange(index),
)
```

### Advanced Usage
```dart
AppBottomBar.floating(
  items: ecommerceItems,
  currentIndex: currentTab,
  onTap: (index) => handleNavigation(index),
  size: AppBottomBarSize.comfortable,
  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
  elevation: 12.0,
  borderRadius: AppRadius.xl,
  margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
  showUnselectedLabels: false,
  feedbackType: FeedbackType.light,
)
```

## Customization Guidelines

### When to Extend
- Adding app-specific navigation patterns
- Creating specialized item types (e.g., with custom widgets)
- Implementing platform-specific behaviors
- Adding new animation or transition effects

### How to Modify
1. **New Variants**: Add to `AppBottomBarVariant` enum and implement in `build()` method
2. **Custom Items**: Extend `AppBottomBarItem` class or create factory constructors
3. **Styling Changes**: Modify the variant-specific builders
4. **New Sizes**: Add to `AppBottomBarSize` enum and update size calculations

### Code Patterns
```dart
// Adding a specialized item type
class AppBottomBarItem {
  factory AppBottomBarItem.withStatus({
    required IconData icon,
    required String label,
    required bool hasNotification,
  }) {
    return AppBottomBarItem(
      icon: icon,
      label: label,
      badge: hasNotification 
        ? Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          )
        : null,
    );
  }
}

// Adding a custom variant
factory AppBottomBar.material3({
  required List<AppBottomBarItem> items,
  required int currentIndex,
  ValueChanged<int>? onTap,
}) {
  return AppBottomBar._(
    items: items,
    currentIndex: currentIndex,
    onTap: onTap,
    variant: AppBottomBarVariant.standard,
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: false,
    elevation: 3.0,
  );
}
```

## Related Components
- **AppButton**: Use for individual action buttons within bottom sheets or dialogs
- **NavigationRail**: Use for wider screens or when you need vertical navigation
- **TabBar**: Use for content switching within a single screen
- **AppDrawer**: Use for secondary navigation and settings
- **FloatingActionButton**: Often paired with notched variant

## Design System Integration

### Design Tokens Used
- **Colors**: `primary`, `onPrimary`, `surface`, `onSurface`, `onSurfaceVariant`
- **Typography**: `labelSmall`, `labelMedium`, `labelLarge` based on size
- **Spacing**: `xs`, `sm`, `md`, `lg` for padding, margins, and gaps
- **Radius**: `md`, `lg`, `xl` for border radius on floating variant
- **Shadows**: `sm`, `md`, `lg` for elevation effects
- **Density**: `buttonIconSize`, `buttonMinHeight` for sizing

### Theme Integration
- Automatically adapts to light/dark themes
- Uses theme color schemes for consistency
- Respects system accessibility settings
- Supports custom density configurations
- Integrates with Material 3 design principles

## Accessibility
- Semantic navigation role for screen readers
- Proper focus management with keyboard navigation
- High contrast colors that meet WCAG guidelines
- Minimum touch target sizes (44x44pt) maintained
- Badge content announced to screen readers
- Tab order follows visual order
- Voice over support with proper labels

## Platform Considerations
- **Web**: Hover states, focus indicators, keyboard shortcuts (Tab, Arrow keys)
- **Mobile**: Haptic feedback on selection, proper touch targets, gesture support
- **Desktop**: Keyboard navigation, precise mouse interactions, context menus
- **All Platforms**: Smooth animations, theme adaptations, responsive design

## Examples in Playground
See `app_bottom_bar_showcase_page.dart` for comprehensive examples including:
- All variants with different configurations
- Size variations and density settings
- Badge implementations and custom styling
- Real-world app navigation examples
- Accessibility and interaction demonstrations
- Custom colors and theming options

## Migration Notes
- Replaces legacy bottom navigation implementations
- Factory constructors provide semantic API for common patterns
- Badge system replaces custom overlay implementations
- Automatic theme integration reduces manual color management
- Size variants replace manual icon/text size adjustments
- Built-in haptic feedback eliminates need for wrapper widgets