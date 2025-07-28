# App Design System

A comprehensive, professional design system built for Flutter applications. This system provides a unified foundation for creating consistent, maintainable, and easily customizable user interfaces across different client projects.

## 🎯 Design Philosophy

This design system follows the **token-first approach** where all visual properties are defined as reusable design tokens. These tokens are then seamlessly integrated with Flutter's native theming system, ensuring both consistency and flexibility.

### Key Principles
- **Single Source of Truth**: All design decisions centralized in design tokens
- **Client Customization**: Easy theme switching for different client requirements  
- **Native Integration**: Works seamlessly with Flutter's built-in components
- **Professional Quality**: Industry-standard patterns and best practices
- **Maintainability**: Clean, organized code structure for long-term maintenance

## 📁 Structure

```
lib/design_system/
├── tokens/                  # Design foundation
│   ├── app_colors.dart     # Color system with semantic variants
│   ├── app_spacing.dart    # Spacing scale (Tailwind-inspired)
│   ├── app_radius.dart     # Border radius presets
│   ├── app_shadows.dart    # Shadow and elevation system
│   ├── app_typography.dart # Text styles and hierarchy
│   └── app_density.dart    # Component density controls
├── theme/                  # Theme integration
│   ├── app_theme.dart      # Main theme configuration
│   └── app_theme_extension.dart # Custom theme properties
└── components/             # Custom components
    └── app_button.dart     # Button component with variants
```

## 🎨 Design Tokens

### Colors
```dart
// Semantic color usage
AppColors.primary.shade(500)        // Primary color
AppColors.neutral.border(context)   // Context-aware border
AppColors.error.materialSwatch[100] // Light error background

// Built-in context extensions
context.colors.primary              // Theme-aware primary
context.borderColor                 // Semantic border color
```

### Spacing
```dart
// Spacing scale (0, 4, 8, 16, 24, 32, 48, 64)
AppSpacing.md.padding              // EdgeInsets.all(16)
AppSpacing.lg.paddingHorizontal    // EdgeInsets.symmetric(horizontal: 24)
AppSpacing.sm.gapV                 // SizedBox(height: 8)

// Flexible combinations
AppSpacing.md.combine(
  top: AppSpacing.lg,
  bottom: AppSpacing.sm,
)
```

### Border Radius
```dart
// Radius scale (0, 2, 4, 6, 8, 12, 16, 24, 999)
AppRadius.lg.borderRadius          // BorderRadius.circular(8)
AppRadius.xl.topOnly              // Top corners only
AppRadius.pill.buttonShape        // Fully rounded button
```

### Shadows
```dart
// Shadow presets
AppShadows.sm.shadows             // Subtle shadow
AppShadows.card.shadows           // Card elevation
AppShadows.lg.colored(Colors.blue) // Custom colored shadow
```

### Typography
```dart
// Material Design 3 type scale
AppTextStyle.headlineLarge.style   // 32px headline
AppTextStyle.bodyMedium.bold()     // Bold body text
AppTextStyle.labelLarge.colored(Colors.red) // Colored label
```

### Density
```dart
// Component density control
AppDensity.compact.buttonPadding   // Tight spacing
AppDensity.standard.buttonMinHeight // Standard sizing
AppDensity.comfortable.iconSize    // Spacious layout
```

## 🔧 Theme Integration

### Basic Setup
```dart
// In your main.dart
import 'package:your_app/design_system/theme/app_theme.dart';

MaterialApp(
  theme: AppTheme.light(),           // Light theme
  darkTheme: AppTheme.dark(),        // Dark theme
  themeMode: ThemeMode.system,       // System preference
  home: MyHomePage(),
)
```

### Client Customization
```dart
// Different themes for different clients
MaterialApp(
  theme: AppTheme.clientA(),         // Client A branding
  // OR
  theme: AppTheme.clientB(),         // Client B branding
  home: MyHomePage(),
)
```

### Density Control
```dart
// App-wide density settings
MaterialApp(
  theme: AppTheme.light(density: AppDensity.compact),  // Compact UI
  home: MyHomePage(),
)
```

### Custom Theme Extensions
```dart
// Access custom properties
Container(
  decoration: BoxDecoration(
    color: context.colors.surface,
    border: Border.all(color: context.borderColor),
    borderRadius: context.radius.borderRadius,
    boxShadow: context.shadow.shadows,
  ),
)
```

## 🧩 Components

### AppButton

A comprehensive button component with multiple variants, sizes, and features.

#### Variants
```dart
// Primary action button
AppButton.primary(
  onPressed: () {},
  child: Text('Save'),
)

// Secondary action button  
AppButton.secondary(
  onPressed: () {},
  child: Text('Cancel'),
)

// Ghost/transparent button
AppButton.ghost(
  onPressed: () {},
  child: Text('Skip'),
)

// Destructive action button
AppButton.destructive(
  onPressed: () {},
  child: Text('Delete'),
)

// Outlined button
AppButton.outline(
  onPressed: () {},
  child: Text('Edit'),
)

// Link-style button
AppButton.link(
  onPressed: () {},
  child: Text('Learn More'),
)
```

#### Sizes and Features
```dart
// Different sizes
AppButton.primary(
  size: AppButtonSize.sm,           // Small
  size: AppButtonSize.md,           // Medium (default)
  size: AppButtonSize.lg,           // Large
  size: AppButtonSize.icon,         // Icon only
  child: Text('Button'),
)

// With icons
AppButton.primary(
  icon: Icons.save,                 // Leading icon
  trailingIcon: Icons.arrow_forward, // Trailing icon
  child: Text('Save & Continue'),
)

// Loading state
AppButton.primary(
  isLoading: true,                  // Shows spinner
  child: Text('Saving...'),
)

// Full width
AppButton.primary(
  fullWidth: true,                  // Stretches to container
  child: Text('Get Started'),
)

// Custom density
AppButton.primary(
  density: AppDensity.compact,      // Override app density
  child: Text('Compact Button'),
)
```

#### Advanced Features
- **Hover Effects**: Automatic shadow and color transitions
- **Press Animation**: Scale animation on tap
- **Loading States**: Built-in loading spinner
- **Accessibility**: Full screen reader and focus support
- **Theme Integration**: Automatically adapts to light/dark themes

## 💡 Usage Examples

### Basic Layout
```dart
class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ Automatically themed with design system
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Padding(
        padding: AppSpacing.lg.padding,  // Consistent spacing
        child: Column(
          children: [
            // ✅ Native TextField automatically themed
            TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
              ),
            ),
            
            AppSpacing.md.gapV,  // Consistent spacing
            
            // ✅ Custom button with design system
            AppButton.primary(
              onPressed: () {},
              child: Text('Search'),
            ),
            
            AppSpacing.lg.gapV,
            
            // ✅ Native Card automatically themed
            Card(
              child: Padding(
                padding: AppSpacing.md.padding,
                child: Text('Card content'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Client Customization Example
```dart
// Easy to switch between client themes
class AppConfig {
  static ThemeData getTheme(String clientId) {
    switch (clientId) {
      case 'client_a':
        return AppTheme.clientA();
      case 'client_b':  
        return AppTheme.clientB();
      default:
        return AppTheme.light();
    }
  }
}

// In main.dart
MaterialApp(
  theme: AppConfig.getTheme('client_a'),
  home: MyApp(),
)
```

## 🔄 Migration Guide

### From Existing Design System
1. **Replace color constants** with `AppColors` enum values
2. **Replace hardcoded spacing** with `AppSpacing` values  
3. **Replace custom buttons** with `AppButton` variants
4. **Update theme configuration** to use `AppTheme`
5. **Test different densities** to ensure layout compatibility

### Adding New Components
1. **Follow token-first approach** - use existing design tokens
2. **Integrate with theme system** - support light/dark modes
3. **Add factory methods** for different variants
4. **Include accessibility features** - focus, semantics, etc.
5. **Document usage patterns** - provide clear examples

## 🚀 Best Practices

### Do ✅
- Use design tokens for all visual properties
- Leverage context extensions for easy access
- Test components in both light and dark themes
- Follow the factory pattern for component variants
- Maintain consistent naming conventions

### Don't ❌  
- Hardcode colors, spacing, or other design values
- Create custom themes without using design tokens
- Ignore accessibility requirements
- Mix different design systems in the same app
- Override theme properties without good reason

## 🔮 Future Enhancements

### Planned Features
- **Additional Components**: Cards, inputs, dialogs, navigation
- **Animation System**: Consistent motion and transitions
- **Responsive Breakpoints**: Adaptive layouts for different screen sizes
- **Icon System**: Standardized icon library with sizing
- **Focus Management**: Enhanced accessibility features

### Extensibility
This design system is built for growth. New tokens, components, and themes can be added following the established patterns without breaking existing code.

---

## 📖 Getting Started

1. **Import the theme** in your `main.dart`
2. **Replace hardcoded values** with design tokens
3. **Use AppButton** for all button interactions
4. **Test across different themes** and densities
5. **Follow the examples** in this documentation

For questions or contributions, refer to the component-specific documentation or create an issue in the project repository.