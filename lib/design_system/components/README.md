# Design System Components

This directory contains all reusable UI components for the design system, organized using a folder-per-component structure.

## Folder Structure

Each component follows this standardized structure:

```
components/
├── component_name/
│   ├── component_name.dart           # Main component implementation
│   ├── component_name_description.md # AI-readable documentation
│   └── component_name_showcase_page.dart # Playground demonstration
└── _template/
    └── component_description_template.md # Template for new components
```

## Available Components

### AppButton (`app_button/`)
Interactive button component with multiple variants, sizes, and states.
- **Variants**: Primary, Secondary, Ghost, Destructive, Outline, Link
- **Specialized**: Icon buttons (square/rounded), Compact buttons
- **Features**: Loading states, hover effects, accessibility support

### AppCard (`app_card/`)
Container components for organizing content with consistent styling.
- **AppCard**: Base non-interactive card with elevation variants
- **AppClickableCard**: Interactive card with hover/press effects
- **Variants**: Elevated, Outlined, Filled

## Documentation for AI Agents

Each component includes comprehensive documentation in `*_description.md` files that provide:

- **Overview**: Component purpose and primary use cases
- **API Reference**: Complete parameter documentation
- **Usage Examples**: Code examples for common scenarios
- **Customization Guidelines**: How to extend or modify components
- **Design Integration**: Which design tokens are used
- **Accessibility**: Screen reader, keyboard, and touch requirements
- **Platform Considerations**: Web/mobile/desktop-specific features

## Adding New Components

1. **Create Component Folder**: `mkdir components/new_component/`
2. **Copy Template**: Use `_template/component_description_template.md` as base
3. **Implement Component**: Create `new_component.dart` with your component
4. **Write Documentation**: Fill out `new_component_description.md`
5. **Create Showcase**: Build `new_component_showcase_page.dart` for playground
6. **Update Router**: Add route in `playground/router/playground_router.dart`
7. **Update Dashboard**: Add card in `playground/pages/dashboard_page.dart`

## Best Practices

- **Co-location**: Keep related files together in component folders
- **Documentation**: Update `.md` files when changing component APIs
- **Examples**: Show all variants and states in showcase pages
- **Consistency**: Follow existing patterns for naming and structure
- **Accessibility**: Include focus, keyboard, and screen reader support
- **Responsiveness**: Consider all platform constraints and breakpoints

## Import Patterns

```dart
// Import from component folder
import 'package:app/design_system/components/app_button/app_button.dart';
import 'package:app/design_system/components/app_card/app_card.dart';

// Components can reference each other
import '../app_card/app_clickable_card.dart';
```

This structure ensures components are:
- **Self-contained**: Everything related to a component is in one place
- **Discoverable**: AI agents can easily find component info and examples  
- **Maintainable**: Clear ownership and organization
- **Scalable**: Easy to add new components without cluttering