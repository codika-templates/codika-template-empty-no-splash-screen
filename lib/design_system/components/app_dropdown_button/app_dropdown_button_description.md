# AppDropdownButton Component

A professional dropdown button component that maintains consistent styling with AppTextField. Uses Flutter's native `DropdownMenu` widget with custom styling to create an overlay dropdown that appears on top of existing UI.

## Features

- **Consistent Styling**: Matches AppTextField exactly using shared styling utilities
- **Overlay Behavior**: Dropdown menu appears as an overlay on top of existing UI
- **Type-Safe**: Generic type `T` for type-safe dropdown options
- **Multiple Variants**: Supports outlined, filled, and underlined variants
- **Multiple Sizes**: sm, md, lg sizes matching AppTextField
- **Search & Filter**: Optional search and filtering capabilities
- **Custom Items**: Rich dropdown items with icons and custom widgets
- **Accessibility**: Full accessibility support with proper focus management
- **Haptic Feedback**: Integration with the app's interaction feedback service

## Basic Usage

```dart
// Simple dropdown with string values
AppDropdownButton<String>(
  items: [
    AppDropdownItem(value: 'option1', label: 'Option 1'),
    AppDropdownItem(value: 'option2', label: 'Option 2'),
    AppDropdownItem(value: 'option3', label: 'Option 3'),
  ],
  value: selectedValue,
  onSelected: (value) => setState(() => selectedValue = value),
  hintText: 'Select an option',
)
```

## With AppTextFieldWrapper

```dart
// Use with wrapper for external labels and descriptions
AppTextFieldWrapper(
  title: 'Country',
  isMandatory: true,
  description: 'Select your country of residence',
  child: AppDropdownButton<Country>(
    items: countries.map((country) => AppDropdownItem(
      value: country,
      label: country.name,
      leadingIcon: Icon(country.flagIcon),
    )).toList(),
    value: selectedCountry,
    onSelected: (country) => setState(() => selectedCountry = country),
    hintText: 'Select country',
  ),
)
```

## Variants

### Outlined (Default)
```dart
AppDropdownButton.outlined(
  items: items,
  value: value,
  onSelected: onChanged,
  hintText: 'Select option',
)
```

### Filled
```dart
AppDropdownButton.filled(
  items: items,
  value: value,
  onSelected: onChanged,
  hintText: 'Select option',
)
```

### Custom Variant
```dart
AppDropdownButton<T>(
  variant: AppTextFieldVariant.underlined,
  items: items,
  value: value,
  onSelected: onChanged,
  hintText: 'Select option',
)
```

## Sizes

```dart
// Small
AppDropdownButton<T>(
  size: AppTextFieldSize.sm,
  items: items,
  // ...
)

// Medium (default)
AppDropdownButton<T>(
  size: AppTextFieldSize.md,
  items: items,
  // ...
)

// Large
AppDropdownButton<T>(
  size: AppTextFieldSize.lg,
  items: items,
  // ...
)
```

## Rich Dropdown Items

```dart
AppDropdownButton<User>(
  items: users.map((user) => AppDropdownItem(
    value: user,
    label: user.name,
    leadingIcon: CircleAvatar(
      backgroundImage: NetworkImage(user.avatarUrl),
      radius: 12,
    ),
    trailingIcon: user.isOnline 
        ? Icon(Icons.circle, color: Colors.green, size: 8)
        : null,
  )).toList(),
  value: selectedUser,
  onSelected: (user) => setState(() => selectedUser = user),
  hintText: 'Select user',
)
```

## With Search and Filtering

```dart
AppDropdownButton<City>(
  items: cities.map((city) => AppDropdownItem(
    value: city,
    label: city.name,
  )).toList(),
  value: selectedCity,
  onSelected: (city) => setState(() => selectedCity = city),
  hintText: 'Search cities...',
  enableSearch: true,
  enableFilter: true,
)
```

## Error States

```dart
AppDropdownButton<T>(
  items: items,
  value: value,
  onSelected: onChanged,
  errorText: isValid ? null : 'Please select an option',
  hintText: 'Select option',
)
```

## Custom Styling

```dart
AppDropdownButton<T>(
  items: items,
  value: value,
  onSelected: onChanged,
  fillColor: Colors.blue.shade50,
  focusColor: Colors.blue,
  borderRadius: AppRadius.lg,
  feedbackType: FeedbackType.medium,
)
```

## API Reference

### AppDropdownButton Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `items` | `List<AppDropdownItem<T>>` | required | List of dropdown items |
| `value` | `T?` | null | Currently selected value |
| `onSelected` | `ValueChanged<T?>?` | null | Callback when selection changes |
| `hintText` | `String?` | null | Hint text when no value selected |
| `labelText` | `String?` | null | Label text (for animateLabel) |
| `errorText` | `String?` | null | Error text to display |
| `variant` | `AppTextFieldVariant` | outlined | Visual variant |
| `size` | `AppTextFieldSize` | md | Size of the dropdown |
| `enabled` | `bool` | true | Whether dropdown is enabled |
| `enableSearch` | `bool` | false | Enable search functionality |
| `enableFilter` | `bool` | false | Enable filtering |
| `leadingIcon` | `Widget?` | null | Leading icon |
| `trailingIcon` | `Widget?` | null | Custom trailing icon |
| `feedbackType` | `FeedbackType?` | null | Haptic feedback type |

### AppDropdownItem Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `T` | required | The value of the item |
| `label` | `String` | required | Display label |
| `leadingIcon` | `Widget?` | null | Leading icon |
| `trailingIcon` | `Widget?` | null | Trailing icon |
| `enabled` | `bool` | true | Whether item is enabled |
| `customWidget` | `Widget?` | null | Custom widget instead of label |

## Best Practices

1. **Use with AppTextFieldWrapper**: For consistent form layouts with labels and descriptions
2. **Type Safety**: Always specify the generic type for better type checking
3. **Meaningful Labels**: Use clear, descriptive labels for dropdown items
4. **Icon Usage**: Use leading icons to help users identify options quickly
5. **Error Handling**: Always provide error text for validation feedback
6. **Search for Long Lists**: Enable search/filter for lists with more than 10 items
7. **Consistent Sizing**: Use the same size as other form fields in your layout

## Integration Notes

- Works seamlessly with `AppTextFieldWrapper` for consistent form layouts
- Shares styling utilities with `AppTextField` for consistent appearance
- Uses design system tokens for colors, spacing, and typography
- Integrates with the app's haptic feedback system
- Fully accessible with proper focus management and screen reader support