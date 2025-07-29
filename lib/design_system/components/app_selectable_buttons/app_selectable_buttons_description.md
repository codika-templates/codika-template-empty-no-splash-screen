# App Selectable Buttons

## Overview

A comprehensive collection of selectable input components including checkboxes, radio buttons, and toggle switches. These components provide consistent styling, haptic feedback, and accessibility features across the design system.

## Use Cases

- **Primary Use Case**: Form inputs where users need to select one or more options from a set
- **Secondary Use Case**: Settings toggles, preferences, and configuration options
- **Avoid Using When**: Complex multi-selection scenarios would be better served by dedicated picker components

## Component API

### AppCheckbox

#### Required Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `value` | `bool` | Current checked state of the checkbox |

#### Optional Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `onChanged` | `ValueChanged<bool?>?` | `null` | Callback when checkbox state changes |
| `style` | `AppSelectableButtonStyle` | `primary` | Visual style variant |
| `feedbackType` | `FeedbackType?` | `null` | Type of haptic feedback on interaction |
| `tristate` | `bool` | `false` | Whether checkbox supports three states |
| `semanticLabel` | `String?` | `null` | Accessibility label for screen readers |

### AppRadioButton<T>

#### Required Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `value` | `T` | The value represented by this radio button |
| `groupValue` | `T?` | The currently selected value in the radio group |

#### Optional Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `onChanged` | `ValueChanged<T?>?` | `null` | Callback when selection changes |
| `style` | `AppSelectableButtonStyle` | `primary` | Visual style variant |
| `feedbackType` | `FeedbackType?` | `null` | Type of haptic feedback on interaction |
| `semanticLabel` | `String?` | `null` | Accessibility label for screen readers |

### AppToggleSwitch

#### Required Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `value` | `bool` | Current toggle state |

#### Optional Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `onChanged` | `ValueChanged<bool>?` | `null` | Callback when toggle state changes |
| `style` | `AppSelectableButtonStyle` | `primary` | Visual style variant |
| `feedbackType` | `FeedbackType?` | `null` | Type of haptic feedback on interaction |
| `semanticLabel` | `String?` | `null` | Accessibility label for screen readers |
| `width` | `double?` | `48.0` | Custom width for the toggle |
| `height` | `double?` | `24.0` | Custom height for the toggle |

### Enums & Types

```dart
enum AppSelectableButtonStyle {
  /// Primary style with brand colors
  primary,
  /// Secondary style with muted appearance
  secondary, 
  /// Tertiary style with success colors when selected
  tertiary
}
```

## Variants & States

### Variants

- **Primary**: Uses primary brand colors when selected, suitable for main actions
- **Secondary**: Uses surface colors when selected, good for secondary options
- **Tertiary**: Uses success colors when selected, ideal for confirmations

### States

- **Default**: Normal interactive state, unselected
- **Selected**: When the component is checked/selected
- **Hover**: Visual feedback on hover (web platforms)
- **Pressed**: Temporary visual feedback during interaction
- **Disabled**: When component is not interactive (onChanged is null)

## Usage Examples

### Basic Checkbox

```dart
AppCheckbox(
  value: isChecked,
  onChanged: (value) => setState(() => isChecked = value ?? false),
)
```

### Radio Button Group

```dart
enum PaymentMethod { card, cash, bank }

PaymentMethod? selectedPayment = PaymentMethod.card;

Column(
  children: PaymentMethod.values.map((method) =>
    AppRadioButton<PaymentMethod>(
      value: method,
      groupValue: selectedPayment,
      onChanged: (value) => setState(() => selectedPayment = value),
    ),
  ).toList(),
)
```

### Toggle Switch with Variants

```dart
AppToggleSwitch.primary(
  value: notificationsEnabled,
  onChanged: (value) => setState(() => notificationsEnabled = value),
  semanticLabel: 'Enable push notifications',
)

AppToggleSwitch.tertiary(
  value: isOnline,
  onChanged: (value) => updateOnlineStatus(value),
)
```

### List Tiles

```dart
AppCheckboxListTile(
  value: acceptTerms,
  title: Text('Accept Terms and Conditions'),
  subtitle: Text('Required to continue'),
  onChanged: (value) => setState(() => acceptTerms = value ?? false),
)

AppRadioListTile<String>(
  value: 'email',
  groupValue: contactMethod,
  title: Text('Email'),
  subtitle: Text('Receive updates via email'),
  onChanged: (value) => setState(() => contactMethod = value),
)
```

### Advanced Usage

```dart
AppCheckbox.secondary(
  value: isOptional,
  onChanged: isFormEnabled ? (value) => handleChange(value) : null,
  feedbackType: FeedbackType.light,
  semanticLabel: 'Optional feature toggle',
)
```

## Customization Guidelines

### When to Extend

- Adding new visual variants for specific brand requirements
- Creating specialized behaviors for unique use cases
- Adding new feedback types or interaction patterns

### How to Modify

1. **Adding Variants**: Extend the `AppSelectableButtonStyle` enum and update the `_getSelectableButtonColors` function
2. **New Factory Constructors**: Create semantic constructors for common patterns
3. **Styling Changes**: Modify the color resolution logic in `_getSelectableButtonColors`
4. **New Parameters**: Add to main constructor and handle in build method

### Code Patterns

```dart
// Adding a new variant
factory AppCheckbox.warning({
  Key? key,
  required bool value,
  ValueChanged<bool?>? onChanged,
}) {
  return AppCheckbox(
    key: key,
    value: value,
    onChanged: onChanged,
    style: AppSelectableButtonStyle.warning, // New enum value
  );
}
```

## Related Components

- **AppButton**: Use for action-based interactions instead of state selection
- **AppTextField**: Can be combined with checkboxes for form validation
- **AppCard**: Good container for grouped selectable options

## Design System Integration

### Design Tokens Used

- **Colors**: `primary`, `secondary`, `success`, `surface`, `onSurface`
- **Spacing**: `xs`, `sm`, `md` for padding and gaps
- **Shapes**: `xs` for checkbox corners, circular for radio buttons
- **Shadows**: Subtle shadows on toggle switches for depth

### Theme Integration

- Respects theme color schemes automatically
- Adapts to light/dark mode through `AppColors.resolve()`
- Uses app theme extensions for consistent styling
- Integrates with `InteractionFeedbackService` for haptics

## Accessibility

- Semantic roles and labels through `Semantics` widget
- Keyboard navigation support via `InkWell`
- Screen reader compatibility with proper state announcements
- Focus management with visual indicators
- Color contrast compliance across all variants
- Touch target sizing meets accessibility guidelines (minimum 44x44pt)

## Platform Considerations

- **Web**: Hover states, cursor changes, focus indicators
- **Mobile**: Haptic feedback, touch targets, gesture recognition
- **Desktop**: Keyboard shortcuts, focus management

## Examples in Playground

See `app_selectable_buttons_showcase_page.dart` for comprehensive examples showing all variants, states, and use cases including:

- Individual component demonstrations
- Form integration examples
- Accessibility features showcase
- Theme variation examples
- Interactive state demonstrations

## Migration Notes

When migrating from previous checkbox/radio implementations:

1. Replace direct `Checkbox`/`Radio` widgets with `AppCheckbox`/`AppRadioButton`
2. Update styling to use design system variants instead of custom colors
3. Add semantic labels for improved accessibility
4. Consider enabling haptic feedback for better user experience
5. Use list tile variants for better layout consistency