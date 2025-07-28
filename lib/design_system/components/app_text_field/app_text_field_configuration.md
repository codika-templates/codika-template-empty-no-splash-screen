# AppTextField Configuration Guide

## Overview
This guide provides detailed configuration options for customizing AppTextField components. Use this for AI agents or developers who need to understand all possible customization parameters.

## Component Architecture

### Base Component: AppTextField
- **Purpose**: Clean, minimal text input field
- **Default behavior**: No hints, no animated labels, no character counters
- **Usage**: Direct instantiation or through factory constructors

### Wrapper Component: AppTextFieldWrapper  
- **Purpose**: External labels, descriptions, and additional UI elements
- **Usage**: Wraps any AppTextField for enhanced labeling

## Configuration Parameters

### Visual Variants
```dart
enum AppTextFieldVariant { outlined, filled, underlined }
```

**Questions for customization:**
- "Do you want a bordered outline (outlined), filled background (filled), or just an underline (underlined)?"
- "Which visual style fits your design: outlined (default), filled, or underlined?"

### Sizes
```dart
enum AppTextFieldSize { sm, md, lg }
```

**Questions for customization:**
- "What size do you need: small (compact), medium (default), or large (prominent)?"
- "Is this for a dense layout (sm), normal form (md), or key input field (lg)?"

### Label Animation
```dart
bool animateLabel = false // Default
```

**Questions for customization:**
- "Do you want the label to animate/float when focused? (false = static, true = animated)"
- "Should the label move up when typing (animated) or stay in place (static)?"

### Content Configuration

#### Text Content
```dart
String? labelText        // Animated label (when animateLabel: true)
String? hintText         // Placeholder text (null by default)
String? errorText        // Error message
String? prefixText       // Text before input (e.g., "https://")
String? suffixText       // Text after input (e.g., ".com")
```

**Questions for customization:**
- "Do you need placeholder text inside the field?"
- "Do you need text prefixes or suffixes (like https:// or .com)?"
- "What should the label text be?"

#### Icons
```dart
Widget? prefixIcon       // Icon at start of field
Widget? suffixIcon       // Icon at end of field
```

**Questions for customization:**
- "Do you need an icon before the text (like email, lock, search)?"
- "Do you need an icon after the text (like check mark, arrow)?"

### Behavior Configuration

#### Input Behavior
```dart
bool obscureText = false        // Hide text (passwords)
bool readOnly = false          // Prevent editing
bool enabled = true            // Enable/disable field
bool autofocus = false         // Auto-focus on load
int? maxLines = 1              // Maximum lines (null = unlimited)
int? minLines                  // Minimum lines
int? maxLength                 // Character limit
```

**Questions for customization:**
- "Should the text be hidden (for passwords)?"
- "Should this field be editable or read-only?"
- "Do you need multi-line input? How many lines?"
- "Is there a character limit?"

#### Keyboard & Input
```dart
TextInputType? keyboardType              // Virtual keyboard type
TextInputAction? textInputAction         // Return key action
TextCapitalization textCapitalization    // Auto-capitalization
List<TextInputFormatter>? inputFormatters // Input validation/formatting
```

**Questions for customization:**
- "What type of keyboard: email, phone, number, text, or multiline?"
- "What should the return key do: next, done, search, or new line?"
- "Should text be auto-capitalized: sentences, words, characters, or none?"

#### Validation
```dart
String? Function(String?)? validator     // Validation function
AutovalidateMode? autovalidateMode       // When to validate
```

**Questions for customization:**
- "Do you need input validation?"
- "When should validation occur: while typing, on submit, or on interaction?"

### Utility Features

#### Clear Button
```dart
bool allowClear = false  // Show clear button when text is present
```

**Questions for customization:**
- "Do you want a clear button to empty the field?"

#### Character Counter
```dart
bool showCounter = false  // Show character count (only with maxLength)
```

**Questions for customization:**
- "Do you want to show the character count (requires maxLength)?"

#### Haptic Feedback
```dart
FeedbackType? feedbackType  // Haptic feedback on interaction
```

**Questions for customization:**
- "What haptic feedback: light, medium, heavy, selection, impact, or none?"

### Styling Overrides

#### Colors
```dart
Color? fillColor         // Background fill color
Color? focusColor        // Border color when focused  
Color? hoverColor        // Background color on hover
```

**Questions for customization:**
- "Do you need custom colors for background, focus border, or hover state?"

#### Shape
```dart
AppRadius? borderRadius  // Custom border radius
```

**Questions for customization:**
- "Do you need custom corner rounding: none, sm, md, lg, xl, or pill?"

#### Density
```dart
AppDensity? density      // Spacing density override
```

**Questions for customization:**
- "Do you need custom spacing: compact, comfortable, or standard?"

## Factory Constructors

### Pre-configured Types
Each factory constructor has sensible defaults but can be customized:

#### AppTextField.email()
- **Default**: Email keyboard, email icon, no hint text
- **Customizable**: All parameters above
- **Questions**: "Do you need custom hint text or validation?"

#### AppTextField.password()
- **Default**: Password keyboard, lock icon, obscured text, visibility toggle
- **Customizable**: All parameters above
- **Questions**: "Do you need custom hint text or validation?"

#### AppTextField.search()
- **Default**: Filled variant, search icon, clear button enabled
- **Customizable**: All parameters above
- **Questions**: "Do you need custom hint text or search behavior?"

#### AppTextField.phone()
- **Default**: Phone keyboard, phone icon
- **Customizable**: All parameters above
- **Questions**: "Do you need phone formatting or validation?"

#### AppTextField.number()
- **Default**: Number keyboard, digit-only input
- **Additional**: `bool allowDecimal = false`
- **Questions**: "Do you need decimal numbers or integer only?"

#### AppTextField.multiline()
- **Default**: Multiline keyboard, 3 max lines, sentence capitalization
- **Additional**: `bool showCounter = false` (can be enabled)
- **Questions**: "How many lines? Do you need character counting?"

## Wrapper Configuration

### AppTextFieldWrapper Parameters
```dart
String? title                    // External label above field
String? preText                  // Text above title
String? postText                 // Text below field
String? description              // Description/help text
bool isMandatory = false         // Show asterisk for required fields
VoidCallback? onDescriptionTap   // Make description interactive
Widget? titleSuffix              // Additional UI next to title
```

### Styling Overrides
```dart
TextStyle? titleTextStyle        // Title text style
TextStyle? preTextStyle          // Pre-text style
TextStyle? postTextStyle         // Post-text style  
TextStyle? descriptionTextStyle  // Description text style
CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start
```

**Questions for wrapper customization:**
- "Do you need external labels above the field?"
- "Do you need help text or descriptions below?"
- "Should any fields be marked as required?"
- "Do you need interactive help descriptions?"

## Common Customization Patterns

### Form Field with External Label
```dart
AppTextFieldWrapper(
  title: 'Email Address',
  isMandatory: true,
  child: AppTextField.email(),
)
```

### Field with Hint Text
```dart
AppTextField.email(
  hintText: 'Enter your work email',
)
```

### Animated Label Field
```dart
AppTextField.email(
  labelText: 'Email',
  animateLabel: true,
)
```

### Multi-line with Counter
```dart
AppTextField.multiline(
  maxLength: 500,
  showCounter: true,
  maxLines: 5,
)
```

### Custom Validation
```dart
AppTextField.email(
  validator: (value) {
    if (value?.isEmpty ?? true) return 'Required';
    if (!value!.contains('@')) return 'Invalid email';
    return null;
  },
  autovalidateMode: AutovalidateMode.onUserInteraction,
)
```

### Search with Custom Behavior
```dart
AppTextField.search(
  hintText: 'Search products...',
  onSubmitted: (query) => performSearch(query),
  onChanged: (query) => showSuggestions(query),
)
```

## Decision Tree for AI Agents

### Step 1: Basic Type
1. "What type of input: email, password, search, phone, number, multiline, or basic text?"

### Step 2: Label Approach  
2. "Do you want external labels (wrapper) or internal labels (animated/static)?"

### Step 3: Visual Style
3. "What visual style: outlined (default), filled, or underlined?"

### Step 4: Size & Density
4. "What size: small, medium (default), or large?"

### Step 5: Content
5. "Do you need placeholder text, prefix/suffix text, or icons?"

### Step 6: Behavior
6. "Any special behavior: validation, character limits, multi-line, clear button?"

### Step 7: Advanced
7. "Any custom styling, haptic feedback, or special keyboard behavior?"

## Integration with Design System

### Uses Design Tokens
- **AppSpacing**: For padding and gaps
- **AppTextStyle**: For text styling
- **AppRadius**: For corner rounding
- **AppColors**: For color schemes
- **AppDensity**: For spacing density

### Theme Integration
- Automatically adapts to light/dark themes
- Uses theme color schemes
- Respects accessibility settings
- Supports high contrast modes

This configuration guide enables AI agents to ask the right questions and developers to understand all customization options available in the AppTextField system.