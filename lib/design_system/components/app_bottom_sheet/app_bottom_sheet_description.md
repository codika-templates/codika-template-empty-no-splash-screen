# AppBottomSheet

## Overview

Professional bottom sheet component with header, scrollable content, and responsive footer sections. Provides smart slide indicator that's automatically linked to drag capability, configurable dismissal behavior, and responsive layouts that adapt from desktop to mobile configurations. Supports both fixed-height and full-height scrollable presentations with seamless keyboard handling for form inputs.

## Use Cases

- **Modal Presentations**: Forms, confirmations, and information displays that slide up from the bottom
- **Menu Systems**: Action menus, option lists, and contextual choices
- **Form Inputs**: Data entry forms with keyboard-aware behavior and proper spacing
- **Confirmation Dialogs**: Save/cancel, delete confirmations, and destructive action warnings
- **Content Viewers**: Scrollable content that requires focused attention
- **Avoid Using When**: For simple tooltips, popovers, or persistent UI elements - use appropriate lightweight components instead

## Component API

### Required Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `content` | `Widget` | Main scrollable content of the bottom sheet |

### Optional Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | `String?` | `null` | Bottom sheet title text (cannot be used with header) |
| `header` | `Widget?` | `null` | Custom header widget (overrides title) |
| `actions` | `AppBottomSheetActions?` | `null` | Footer action buttons configuration |
| `footer` | `Widget?` | `null` | Custom footer widget (overrides actions) |
| `config` | `AppBottomSheetConfig` | `AppBottomSheetConfig()` | Bottom sheet behavior and appearance configuration |
| `onClose` | `VoidCallback?` | `null` | Callback when close button is pressed |

### Enums & Types

```dart
class AppBottomSheetConfig {
  final bool isDismissible;          // Can dismiss by tapping outside/gestures
  final bool enableDrag;             // Enable drag-to-dismiss gesture
  final bool? showSlideIndicator;    // Show slide handle (auto-linked to enableDrag)
  final bool showCloseButton;        // Show close button in header
  final bool isScrollControlled;     // Full height scrollable behavior
  final double? maxHeight;           // Maximum height constraint
  final AppRadius? borderRadius;     // Custom border radius (default: xxxl)
  final bool safeAreaBottom;         // Handle bottom safe area padding
  final Color? backgroundColor;      // Custom background color
  final double mobileBreakpoint;     // Width threshold for mobile layout
}

class AppBottomSheetActions {
  final Widget? primary;             // Primary action button
  final Widget? secondary;           // Secondary action button
  final List<Widget> additional;    // Additional action buttons
  final bool stackOnMobile;          // Stack buttons vertically on mobile
  final MainAxisAlignment alignment; // Button alignment (end, center, start)
  final bool reverseOnMobile;        // Reverse button order on mobile
}
```

## Variants & States

### Factory Constructors

- **AppBottomSheet()**: Standard bottom sheet with full customization
- **AppBottomSheet.simple()**: Basic bottom sheet with title and actions
- **AppBottomSheet.scrollable()**: Pre-configured for full-height scrollable content
- **AppBottomSheet.form()**: Optimized for form inputs with keyboard handling
- **AppBottomSheet.menu()**: List-style menu presentation with fit-content behavior
- **AppBottomSheet.confirmation()**: Pre-configured save/cancel or delete confirmation

### States

- **Default**: Normal interactive state with slide indicator and drag capability
- **Mobile Layout**: Responsive layout with stacked buttons and centered content below 600px width
- **Desktop Layout**: Compact layout with horizontal buttons and left-aligned content above 600px width
- **Form Mode**: Keyboard-aware behavior with disabled drag and visible close button
- **Menu Mode**: Fit-content height with minimal chrome for list presentations
- **Loading**: Action buttons can show loading states with spinners and text
- **Non-Dismissible**: Optional configuration to prevent outside dismissal
- **Persistent**: Special presentation mode that requires explicit action to close

## Usage Examples

### Basic Usage

```dart
AppBottomSheet.show(
  context: context,
  bottomSheet: AppBottomSheet(
    title: 'Bottom Sheet Title',
    content: Text('Bottom sheet content goes here'),
    actions: AppBottomSheetActions(
      primary: AppButton.primary(
        onPressed: () => Navigator.of(context).pop(),
        child: Text('OK'),
      ),
    ),
  ),
);
```

### Simple Factory Constructor

```dart
AppBottomSheet.show(
  context: context,
  bottomSheet: AppBottomSheet.simple(
    title: 'Save Changes',
    content: Text('Do you want to save your changes?'),
    primaryAction: AppButton.primary(
      onPressed: () => handleSave(),
      child: Text('Save'),
    ),
    secondaryAction: AppButton.secondary(
      onPressed: () => Navigator.of(context).pop(),
      child: Text('Cancel'),
    ),
  ),
);
```

### Scrollable Bottom Sheet

```dart
AppBottomSheet.showScrollable(
  context: context,
  bottomSheet: AppBottomSheet.scrollable(
    title: 'Long Content',
    content: Column(
      children: [
        // Long scrollable content here
        ...List.generate(20, (i) => ListTile(title: Text('Item $i'))),
      ],
    ),
  ),
);
```

### Form Bottom Sheet

```dart
AppBottomSheet.show(
  context: context,
  bottomSheet: AppBottomSheet.form(
    title: 'User Information',
    content: Column(
      children: [
        TextField(decoration: InputDecoration(labelText: 'Name')),
        SizedBox(height: 16),
        TextField(decoration: InputDecoration(labelText: 'Email')),
      ],
    ),
    primaryAction: AppButton.primary(
      onPressed: () => handleSave(),
      child: Text('Save'),
    ),
    secondaryAction: AppButton.secondary(
      onPressed: () => Navigator.of(context).pop(),
      child: Text('Cancel'),
    ),
  ),
);
```

### Menu Bottom Sheet

```dart
AppBottomSheet.show(
  context: context,
  bottomSheet: AppBottomSheet.menu(
    title: 'Options',
    content: Column(
      children: [
        ListTile(
          leading: Icon(Icons.share),
          title: Text('Share'),
          onTap: () => handleShare(),
        ),
        ListTile(
          leading: Icon(Icons.bookmark),
          title: Text('Bookmark'),
          onTap: () => handleBookmark(),
        ),
      ],
    ),
  ),
);
```

### Confirmation Bottom Sheet

```dart
AppBottomSheet.show(
  context: context,
  bottomSheet: AppBottomSheet.confirmation(
    title: 'Delete Item',
    content: Text('Are you sure you want to delete this item?'),
    onConfirm: () => handleDelete(),
    isDestructive: true,
    confirmText: 'Delete',
    cancelText: 'Cancel',
  ),
);
```

### Custom Configuration

```dart
AppBottomSheet.show(
  context: context,
  bottomSheet: AppBottomSheet(
    title: 'Custom Bottom Sheet',
    content: YourCustomContent(),
    config: AppBottomSheetConfig(
      maxHeight: 400,
      borderRadius: AppRadius.lg,
      enableDrag: false,
      showSlideIndicator: false,
      showCloseButton: true,
      backgroundColor: Colors.blue.shade50,
    ),
    actions: AppBottomSheetActions(
      primary: AppButton.primary(
        isLoading: isProcessing,
        loadingText: 'Processing...',
        onPressed: () => handleProcess(),
        child: Text('Process'),
      ),
      secondary: AppButton.secondary(
        onPressed: () => Navigator.of(context).pop(),
        child: Text('Cancel'),
      ),
      alignment: MainAxisAlignment.center,
      stackOnMobile: true,
    ),
  ),
);
```

### Persistent Bottom Sheet

```dart
AppBottomSheet.showPersistent(
  context: context,
  bottomSheet: AppBottomSheet(
    title: 'Important Notice',
    content: Text('This requires acknowledgment before continuing.'),
    config: AppBottomSheetConfig(showCloseButton: true),
    actions: AppBottomSheetActions(
      primary: AppButton.primary(
        onPressed: () => Navigator.of(context).pop(),
        child: Text('Acknowledge'),
      ),
    ),
  ),
);
```

## Customization Guidelines

### When to Extend

- Adding specialized bottom sheet types for specific workflows (e.g., media picker, location selector)
- Creating domain-specific factory constructors (e.g., product details, user profile)
- Adding custom animation or transition effects
- Implementing specific layout patterns for your app (e.g., tabs, carousels)

### How to Modify

1. **New Factory Constructors**: Create semantic constructors for common bottom sheet patterns
2. **Custom Configuration**: Extend AppBottomSheetConfig for new behavioral options
3. **Styling Changes**: Modify shape, shadows, and spacing in the build method
4. **Layout Modifications**: Adjust responsive breakpoints and mobile behavior
5. **Action Layouts**: Customize AppBottomSheetActions for specific button arrangements

### Code Patterns

```dart
// Adding a specialized bottom sheet type
factory AppBottomSheet.mediaPicker({
  required Function(String) onMediaSelected,
  List<String> mediaTypes = const ['photo', 'video'],
}) {
  return AppBottomSheet.menu(
    title: 'Select Media',
    content: MediaPickerContent(
      mediaTypes: mediaTypes,
      onSelected: onMediaSelected,
    ),
    config: AppBottomSheetConfig(
      maxHeight: 500,
      enableDrag: true,
    ),
  );
}

// Custom action layout
factory AppBottomSheet.workflow({
  required String title,
  required Widget content,
  required List<WorkflowAction> actions,
}) {
  return AppBottomSheet(
    title: title,
    content: content,
    actions: AppBottomSheetActions(
      primary: actions.isNotEmpty ? actions.first.button : null,
      additional: actions.skip(1).map((a) => a.button).toList(),
      alignment: MainAxisAlignment.spaceEvenly,
      stackOnMobile: false, // Keep horizontal on mobile
    ),
  );
}
```

## Related Components

- **AppDialog**: Use for modal dialogs that require focused attention without bottom presentation
- **AppButton**: Used for all bottom sheet actions and close buttons
- **AppCard**: Similar elevated surface styling patterns for content presentation
- **AppTextField**: Commonly used within form bottom sheets for input collection
- **AppSnackBar**: For simple notifications that don't require modal interaction

## Design System Integration

### Design Tokens Used

- **Colors**: `surface`, `onSurface`, `outline`, `primary`, `onSurfaceVariant`
- **Typography**: `headlineSmall` for titles, `bodyMedium` for content, `labelLarge` for buttons
- **Spacing**: `lg` for padding, `md` for content spacing, `sm` for button gaps, `xs` for slide indicator
- **Shapes**: AppShape integration with configurable squircle/rounded styles, `xxxl` radius for modern corners
- **Shadows**: `xl` for elevation and depth perception
- **Radius**: Default `xxxl` for bottom sheet corners, configurable via AppRadius tokens

### Theme Integration

- Respects theme color schemes for surface and text colors
- Adapts to light/dark mode automatically with proper contrast
- Uses AppThemeExtension for custom design system properties
- Integrates with global shape configuration (squircle/rounded)
- Responsive behavior based on screen size and orientation

## Accessibility

- Proper focus management with initial focus on first interactive element
- Semantic modal role for screen readers with appropriate labels
- Keyboard navigation with Tab/Shift+Tab between interactive elements
- Escape key support for dismissible bottom sheets
- Swipe gesture recognition for drag-to-dismiss behavior
- Color contrast compliance for all text and interactive elements
- Proper labeling of slide indicator, close button, and action buttons
- Announcements for state changes (opening, closing, loading)

## Platform Considerations

- **Web**: Hover states on buttons, proper focus indicators, mouse wheel scrolling
- **Mobile**: Touch-friendly button sizes, haptic feedback on actions, gesture recognition
- **Desktop**: Keyboard shortcuts (Escape to close), proper focus management, mouse interactions
- **Responsive**: Automatic layout adaptation based on screen width (600px breakpoint)
- **Keyboard**: Smart keyboard avoidance for form bottom sheets with proper resizing

## Smart Features

### Slide Indicator Intelligence
- Automatically shown when `enableDrag: true`
- Hidden when `enableDrag: false` or explicitly set to `false`
- Styled consistently using design tokens for visual harmony

### Keyboard Awareness
- Form bottom sheets automatically handle keyboard appearance
- Content resizes appropriately to maintain visibility
- Safe area handling for devices with different keyboard behaviors

### Responsive Button Layout
- Desktop: Horizontal button layout with end alignment
- Mobile: Vertical stacked buttons for better touch targets
- Configurable alignment and ordering for different use cases

### Content Height Management
- Fit-content for menu-style presentations
- Full-height scrollable for long content
- Fixed height constraints with proper overflow handling
- Smart maximum height calculation based on screen size

## Examples in Playground

See `app_bottom_sheet_showcase_page.dart` for comprehensive examples showing:

- All factory constructor variations
- Responsive behavior demonstrations across screen sizes
- Form integration examples with keyboard handling
- Loading state interactions and feedback
- Custom styling options and configuration
- Multiple action button configurations and layouts
- Menu and list presentations
- Behavioral variations (dismissible, persistent, drag states)

## Migration Notes

This is a new component designed to replace multiple existing bottom sheet implementations. When integrating:

1. Replace `showModalBottomSheet()` calls with `AppBottomSheet.show()`
2. Convert action buttons to use AppButton components for consistency
3. Wrap content in appropriate widgets for proper spacing and layout
4. Configure responsive behavior via AppBottomSheetConfig
5. Test mobile layout on different screen sizes and orientations
6. Update drag and dismissal behavior using the new configuration options
7. Leverage factory constructors for common use cases to reduce boilerplate

## Best Practices

### Performance
- Use factory constructors for common patterns to reduce widget tree complexity
- Implement proper disposal of controllers and listeners in content widgets
- Avoid rebuilding heavy content widgets unnecessarily

### UX Guidelines
- Use slide indicators for draggable bottom sheets to communicate interaction
- Provide clear action hierarchies with primary/secondary button distinction
- Ensure sufficient contrast between bottom sheet content and background
- Test touch targets on mobile devices for accessibility compliance

### Responsive Design
- Test layouts on both mobile and desktop breakpoints
- Consider button stacking behavior on narrow screens
- Ensure content remains readable at all supported screen sizes
- Verify safe area handling on devices with notches or bottom bars