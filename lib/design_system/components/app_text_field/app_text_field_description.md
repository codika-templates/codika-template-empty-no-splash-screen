# AppTextField

## Overview
AppTextField provides a comprehensive text input system with consistent styling, behavior, and accessibility features. It offers multiple variants, sizes, and specialized factory constructors for common input types like email, password, search, and multiline text. The component integrates seamlessly with form validation, haptic feedback, and responsive design patterns.

## Use Cases
- **Form Inputs**: User registration, login, settings, and data entry forms
- **Search Interfaces**: Search bars, filters, and query inputs
- **Content Creation**: Comments, messages, descriptions, and long-form text
- **Data Entry**: Numbers, phone numbers, emails, and structured data
- **Settings & Configuration**: User preferences, account information, and app settings
- **Avoid Using When**: For selecting from predefined options (use dropdowns), binary choices (use switches), or read-only data display

## Component API

### AppTextField (Base Component)

#### Required Parameters
None - all parameters are optional with sensible defaults

#### Optional Parameters
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `controller` | `TextEditingController?` | `null` | Controls the text being edited |
| `initialValue` | `String?` | `null` | Initial text value (cannot use with controller) |
| `focusNode` | `FocusNode?` | `null` | Controls focus behavior |
| `labelText` | `String?` | `null` | Floating label text |
| `hintText` | `String?` | `null` | Placeholder text when empty |
| `helperText` | `String?` | `null` | Helper text below field |
| `errorText` | `String?` | `null` | Error text (overrides validation) |
| `prefixIcon` | `Widget?` | `null` | Icon at the start of field |
| `suffixIcon` | `Widget?` | `null` | Icon at the end of field |
| `prefixText` | `String?` | `null` | Text prefix inside field |
| `suffixText` | `String?` | `null` | Text suffix inside field |
| `variant` | `AppTextFieldVariant` | `outlined` | Visual style variant |
| `size` | `AppTextFieldSize` | `md` | Size variant |
| `density` | `AppDensity?` | `theme default` | Spacing density |
| `obscureText` | `bool` | `false` | Hide text for passwords |
| `readOnly` | `bool` | `false` | Prevent editing |
| `enabled` | `bool` | `true` | Enable/disable interaction |
| `autofocus` | `bool` | `false` | Auto-focus on build |
| `maxLines` | `int?` | `1` | Maximum lines (null = unlimited) |
| `minLines` | `int?` | `null` | Minimum lines |
| `maxLength` | `int?` | `null` | Maximum character count |
| `keyboardType` | `TextInputType?` | `null` | Virtual keyboard type |
| `textInputAction` | `TextInputAction?` | `null` | Action button on keyboard |
| `textCapitalization` | `TextCapitalization` | `none` | Auto-capitalization behavior |
| `inputFormatters` | `List<TextInputFormatter>?` | `null` | Input formatting/validation |
| `onChanged` | `ValueChanged<String>?` | `null` | Text change callback |
| `onTap` | `VoidCallback?` | `null` | Tap callback |
| `onSubmitted` | `ValueChanged<String>?` | `null` | Submit callback |
| `onEditingComplete` | `VoidCallback?` | `null` | Editing complete callback |
| `validator` | `String? Function(String?)?` | `null` | Form validation function |
| `autovalidateMode` | `AutovalidateMode?` | `null` | When to auto-validate |
| `borderRadius` | `AppRadius?` | `theme default` | Border radius override |
| `fillColor` | `Color?` | `null` | Background fill color |
| `focusColor` | `Color?` | `null` | Focus border color |
| `hoverColor` | `Color?` | `null` | Hover background color |
| `feedbackType` | `FeedbackType?` | `null` | Haptic feedback type |
| `allowClear` | `bool` | `false` | Show clear button when text present |
| `showCounter` | `bool` | `false` | Show character counter |

### Factory Constructors

#### AppTextField.email()
Pre-configured email input with appropriate keyboard and validation hints.
```dart
AppTextField.email({
  String? labelText = 'Email',
  String? hintText = 'Enter your email',
  bool allowClear = true,
  // ... other standard parameters
})
```

#### AppTextField.password()
Password input with visibility toggle and secure text handling.
```dart
AppTextField.password({
  String? labelText = 'Password',
  String? hintText = 'Enter your password',
  // ... other standard parameters
})
```

#### AppTextField.search()
Search input with filled styling and search-optimized keyboard.
```dart
AppTextField.search({
  String? hintText = 'Search...',
  bool allowClear = true,
  AppTextFieldVariant variant = AppTextFieldVariant.filled,
  // ... other standard parameters
})
```

#### AppTextField.multiline()
Multi-line text area with character counting and sentence capitalization.
```dart
AppTextField.multiline({
  int maxLines = 3,
  bool showCounter = true,
  TextCapitalization textCapitalization = TextCapitalization.sentences,
  // ... other standard parameters
})
```

#### AppTextField.phone()
Phone number input with numeric keyboard and phone-specific formatting.
```dart
AppTextField.phone({
  String? labelText = 'Phone Number',
  String? hintText = 'Enter your phone number',
  // ... other standard parameters
})
```

#### AppTextField.number()
Numeric input with optional decimal support and number validation.
```dart
AppTextField.number({
  bool allowDecimal = false,
  // ... other standard parameters
})
```

### Enums & Types
```dart
enum AppTextFieldVariant { outlined, filled, underlined }
enum AppTextFieldSize { sm, md, lg }
enum AppTextFieldState { normal, focused, error, disabled, success }
enum FeedbackType { light, medium, heavy, selection, impact, error, success }
```

## Variants & States

### Variants
- **Outlined**: Default style with visible border and transparent background
- **Filled**: Filled background with optional border, ideal for forms on colored backgrounds
- **Underlined**: Minimalist style with only bottom border, good for clean interfaces

### Sizes
- **Small (sm)**: Compact size for dense layouts and secondary inputs
- **Medium (md)**: Standard size for most use cases and forms
- **Large (lg)**: Prominent size for key inputs and accessibility needs

### States
- **Normal**: Default appearance ready for interaction
- **Focused**: Active state with enhanced border and haptic feedback
- **Error**: Red styling when validation fails or errorText is provided
- **Disabled**: Grayed out appearance when enabled=false
- **Success**: Green styling for successful validation (coming soon)

## Usage Examples

### Basic Text Field
```dart
AppTextField(
  labelText: 'First Name',
  hintText: 'Enter your first name',
  onChanged: (value) {
    print('Text changed: $value');
  },
)
```

### Email Input with Validation
```dart
AppTextField.email(
  controller: emailController,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  },
  autovalidateMode: AutovalidateMode.onUserInteraction,
)
```

### Password Field with Visibility Toggle
```dart
AppTextField.password(
  controller: passwordController,
  helperText: 'Must be at least 8 characters',
  validator: (value) {
    if (value == null || value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  },
)
```

### Search Bar
```dart
AppTextField.search(
  controller: searchController,
  hintText: 'Search products...',
  onSubmitted: (query) {
    performSearch(query);
  },
  onChanged: (query) {
    if (query.length > 2) {
      showSearchSuggestions(query);
    }
  },
)
```

### Multi-line Text Area
```dart
AppTextField.multiline(
  labelText: 'Description',
  hintText: 'Describe your issue in detail...',
  maxLines: 5,
  maxLength: 500,
  showCounter: true,
  validator: (value) {
    if (value != null && value.length < 10) {
      return 'Please provide at least 10 characters';
    }
    return null;
  },
)
```

### Phone Number Input
```dart
AppTextField.phone(
  controller: phoneController,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    // Add phone number format validation
    return null;
  },
)
```

### Numeric Input
```dart
AppTextField.number(
  labelText: 'Age',
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }
    final age = int.tryParse(value);
    if (age == null || age < 0) {
      return 'Please enter a valid age';
    }
    return null;
  },
)
```

### Advanced Customization
```dart
AppTextField(
  labelText: 'Custom Field',
  variant: AppTextFieldVariant.filled,
  size: AppTextFieldSize.lg,
  prefixIcon: Icon(Icons.person),
  suffixIcon: Icon(Icons.check),
  prefixText: '\$',
  suffixText: 'USD',
  borderRadius: AppRadius.lg,
  fillColor: Colors.blue.shade50,
  maxLength: 100,
  allowClear: true,
  showCounter: true,
  feedbackType: FeedbackType.medium,
  helperText: 'This is a customized text field',
  inputFormatters: [
    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
  ],
)
```

## Form Integration

### Complete Form Example
```dart
class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextField(
            controller: _nameController,
            labelText: 'Full Name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Name is required';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          AppTextField.email(
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              }
              if (!value.contains('@')) {
                return 'Invalid email format';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          AppTextField.password(
            controller: _passwordController,
            validator: (value) {
              if (value == null || value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              return null;
            },
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Process form data
                submitForm();
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
```

## Customization Guidelines

### When to Extend
- Creating domain-specific input types (e.g., CreditCardField, DateField)
- Adding new validation patterns or input formatters
- Implementing custom keyboard layouts or input methods
- Adding specialized feedback or animation behaviors

### How to Modify
1. **New Variants**: Add to `AppTextFieldVariant` enum and update styling logic
2. **Custom Inputs**: Create wrapper components using AppTextField as base
3. **Validation**: Extend validator functions or create reusable validation utilities
4. **Styling**: Override colors, fonts, or spacing through parameters or theme

### Code Patterns
```dart
// Custom credit card input component
class CreditCardField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  
  const CreditCardField({
    this.controller,
    this.validator,
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      labelText: 'Credit Card Number',
      hintText: '1234 5678 9012 3456',
      prefixIcon: Icon(Icons.credit_card),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CreditCardInputFormatter(), // Custom formatter
      ],
      validator: validator ?? _defaultValidator,
      maxLength: 19, // 16 digits + 3 spaces
    );
  }
  
  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Credit card number is required';
    }
    // Add Luhn algorithm validation
    return null;
  }
}
```

## Interaction Feedback

AppTextField integrates with the global `InteractionFeedbackService` to provide consistent haptic feedback across the application.

### Feedback Types
- **light**: Subtle feedback for gentle interactions (default for most inputs)
- **medium**: Standard feedback for password and important fields
- **selection**: Feedback for dropdown-like interactions
- **impact**: Strong feedback for critical actions

### Usage
```dart
AppTextField(
  feedbackType: FeedbackType.medium,
  onTap: () {
    // Haptic feedback is automatically triggered
    showCustomKeyboard();
  },
)
```

### Automatic Feedback
- **Focus**: Light haptic when field gains focus
- **Clear**: Light haptic when clear button is pressed  
- **Password Toggle**: Selection haptic when visibility is toggled
- **Submit**: Feedback type specified by feedbackType parameter

## Accessibility

### Built-in Features
- Semantic labels and hints for screen readers
- Focus indicators with proper contrast ratios
- Keyboard navigation support (Tab, Shift+Tab)
- Touch target requirements met (minimum 44x44pt)
- Screen reader announcements for validation errors
- High contrast mode support

### Implementation
```dart
AppTextField(
  labelText: 'Email Address', // Read by screen readers
  hintText: 'Enter your email', // Additional context
  helperText: 'We will never share your email', // Additional info
  errorText: validationError, // Announced when present
  // Automatically handles:
  // - Focus announcements
  // - State change announcements  
  // - Error announcements
  // - Character count announcements
)
```

## Platform Considerations

### Web
- Hover states for visual feedback
- Focus rings meeting accessibility standards
- Keyboard shortcuts (Ctrl+A, Ctrl+C, etc.)
- Copy/paste integration
- Browser autofill support

### Mobile
- Haptic feedback for interactions
- Appropriate keyboard types (email, numeric, etc.)
- Touch target optimization
- Platform-specific input behaviors

### Desktop
- Keyboard navigation (Tab order, Enter to submit)
- Context menus for cut/copy/paste
- Precise mouse interactions
- Window resizing considerations

## Performance Considerations

### Optimization Tips
- Use `controller` for text fields that need external state management
- Use `initialValue` for simple, non-changing default values
- Implement `onChanged` callbacks efficiently to avoid excessive rebuilds
- Use `autovalidateMode.onUserInteraction` for better UX than `always`
- Consider `inputFormatters` for real-time input validation instead of `onChanged`

### Memory Management
```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose(); // Important: prevent memory leaks
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: _controller,
      focusNode: _focusNode,
    );
  }
}
```

## Design System Integration

### Design Tokens Used
- **Colors**: `primary`, `onSurface`, `surfaceContainerHighest`, `outline`, `error`
- **Spacing**: Size-based padding using `AppSpacing` tokens
- **Typography**: Size-based text styles using `AppTextStyle` tokens  
- **Radius**: `defaultRadius` from theme, customizable with `AppRadius`
- **Density**: Adaptive spacing based on `AppDensity` settings

### Theme Integration
- Automatically adapts to light/dark themes
- Uses theme color scheme for consistent appearance
- Respects theme typography scale and font families
- Supports custom theme extensions and overrides

## Validation Patterns

### Common Validators
```dart
class TextFieldValidators {
  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? Function(String?) minLength(int min) {
    return (String? value) {
      if (value == null || value.length < min) {
        return 'Must be at least $min characters';
      }
      return null;
    };
  }

  static String? Function(String?) maxLength(int max) {
    return (String? value) {
      if (value != null && value.length > max) {
        return 'Must be no more than $max characters';
      }
      return null;
    };
  }
}
```

## Related Components
- **AppButton**: Use for form submission and actions
- **AppCard**: Container for form layouts and grouping
- **AppDropdown**: For selecting from predefined options  
- **AppCheckbox**: For boolean input fields
- **AppDatePicker**: For date/time input (future component)

## Examples in Playground
See `app_text_field_showcase_page.dart` for comprehensive examples including:
- All variants with different styling options
- All factory constructors with appropriate use cases
- Form validation patterns and error handling
- Advanced features like clear buttons and character counters
- Accessibility features and platform-specific behaviors
- Performance optimization examples
- Real-world form implementations

## Migration Notes
- Replaces custom text input implementations with standardized design
- Factory constructors eliminate boilerplate for common input types
- Built-in validation states reduce custom error handling code
- Haptic feedback is automatically integrated for better UX
- Theme integration ensures consistent appearance across app
- Accessibility features are enabled by default