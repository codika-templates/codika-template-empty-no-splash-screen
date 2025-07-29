# AppDialog

## Overview

Professional dialog component with header, scrollable content, and responsive footer sections. Provides smart scrolling where only the content area scrolls while header and footer remain fixed. Features responsive button layouts that adapt from desktop (right-aligned) to mobile (centered/stacked) configurations. Supports optional icons with adaptive positioning - horizontal layout on desktop and vertical on mobile.

## Use Cases

- **Modal Dialogs**: Forms, confirmations, and information displays that require user interaction
- **Confirmation Dialogs**: Save/cancel, delete confirmations, and destructive action warnings
- **Alert Dialogs**: Simple informational messages with acknowledgment
- **Avoid Using When**: For simple tooltips, popovers, or non-modal overlays - use appropriate lightweight components instead

## Component API

### Required Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `content` | `Widget` | Main scrollable content of the dialog |

### Optional Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | `String?` | `null` | Dialog title text (cannot be used with header) |
| `header` | `Widget?` | `null` | Custom header widget (overrides title) |
| `actions` | `AppDialogActions?` | `null` | Footer action buttons configuration |
| `footer` | `Widget?` | `null` | Custom footer widget (overrides actions) |
| `config` | `AppDialogConfig` | `AppDialogConfig()` | Dialog behavior and appearance configuration |
| `onClose` | `VoidCallback?` | `null` | Callback when close button is pressed |

### Enums & Types

```dart
class AppDialogConfig {
  final bool barrierDismissible;      // Can dismiss by tapping outside
  final bool showCloseButton;         // Show close button in header
  final double? maxWidth;             // Maximum dialog width
  final double? maxHeight;            // Maximum dialog height
  final AppRadius? borderRadius;      // Custom border radius
  final bool fullScreenOnMobile;     // Full screen on mobile devices
  final double mobileBreakpoint;     // Width threshold for mobile layout
  final IconData? icon;               // Optional icon for header
  final Color? iconColor;             // Icon color (defaults to primary)
  final double? iconSize;             // Icon size (defaults to 32 on desktop, 48 on mobile)
}

class AppDialogActions {
  final Widget? primary;              // Primary action button
  final Widget? secondary;            // Secondary action button
  final List<Widget> additional;     // Additional action buttons
  final bool reverseOnMobile;        // Reverse button order on mobile
  final bool stackOnMobile;          // Stack buttons vertically on mobile
}
```

## Variants & States

### Factory Constructors

- **AppDialog()**: Standard dialog with full customization
- **AppDialog.simple()**: Basic dialog with title and actions
- **AppDialog.confirmation()**: Pre-configured save/cancel or delete confirmation
- **AppDialog.alert()**: Simple alert with OK button

### States

- **Default**: Normal interactive state with scrollable content
- **Mobile Layout**: Responsive layout with stacked/centered buttons and vertical icon placement below 600px width
- **Desktop Layout**: Compact layout with right-aligned buttons and horizontal icon placement above 600px width
- **With Icon**: Icon appears next to title on desktop, above title on mobile
- **Loading**: Action buttons can show loading states
- **Non-Dismissible**: Optional configuration to prevent outside dismissal

## Usage Examples

### Basic Usage

```dart
AppDialog.show(
  context: context,
  dialog: AppDialog(
    title: 'Dialog Title',
    content: Text('Dialog content goes here'),
    actions: AppDialogActions(
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
AppDialog.show(
  context: context,
  dialog: AppDialog.simple(
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

### Dialog with Icon

```dart
AppDialog.show(
  context: context,
  dialog: AppDialog.simple(
    title: 'Warning',
    content: Text('This action cannot be undone.'),
    icon: Icons.warning,
    iconColor: Colors.amber,
    primaryAction: AppButton.primary(
      onPressed: () => handleAction(),
      child: Text('Continue'),
    ),
    secondaryAction: AppButton.secondary(
      onPressed: () => Navigator.of(context).pop(),
      child: Text('Cancel'),
    ),
  ),
);
```

### Confirmation Dialog

```dart
AppDialog.show(
  context: context,
  dialog: AppDialog.confirmation(
    title: 'Delete Item',
    content: Text('Are you sure you want to delete this item?'),
    onConfirm: () => handleDelete(),
    isDestructive: true,
    confirmText: 'Delete',
    cancelText: 'Cancel',
  ),
);
```

### Custom Header and Configuration

```dart
AppDialog.show(
  context: context,
  dialog: AppDialog(
    header: Row(
      children: [
        Icon(Icons.warning, color: Colors.amber),
        SizedBox(width: 8),
        Text('Custom Header', style: AppTextStyle.titleLarge.style),
      ],
    ),
    content: Column(
      children: [
        TextField(decoration: InputDecoration(labelText: 'Name')),
        SizedBox(height: 16),
        TextField(decoration: InputDecoration(labelText: 'Email')),
      ],
    ),
    config: AppDialogConfig(
      maxWidth: 400,
      borderRadius: AppRadius.lg,
      barrierDismissible: false,
    ),
    actions: AppDialogActions(
      primary: AppButton.primary(
        isLoading: isProcessing,
        loadingText: 'Saving...',
        onPressed: () => handleSave(),
        child: Text('Save'),
      ),
      secondary: AppButton.secondary(
        onPressed: () => Navigator.of(context).pop(),
        child: Text('Cancel'),
      ),
    ),
  ),
);
```

## Customization Guidelines

### When to Extend

- Adding specialized dialog types for specific workflows (e.g., multi-step wizards)
- Creating domain-specific factory constructors (e.g., user profile, settings)
- Adding custom animation or transition effects
- Implementing specific layout patterns for your app

### How to Modify

1. **New Factory Constructors**: Create semantic constructors for common dialog patterns
2. **Custom Configuration**: Extend AppDialogConfig for new behavioral options
3. **Styling Changes**: Modify shape, shadows, and spacing in the build method
4. **Layout Modifications**: Adjust responsive breakpoints and mobile behavior

### Code Patterns

```dart
// Adding a specialized dialog type
factory AppDialog.userProfile({
  required User user,
  required VoidCallback onSave,
}) {
  return AppDialog(
    title: 'Edit Profile',
    content: UserProfileForm(user: user),
    actions: AppDialogActions(
      primary: AppButton.primary(
        onPressed: onSave,
        child: Text('Save Changes'),
      ),
      secondary: AppButton.secondary(
        onPressed: () => Navigator.pop(),
        child: Text('Cancel'),
      ),
    ),
    config: AppDialogConfig(maxWidth: 500),
  );
}
```

## Related Components

- **AppButton**: Used for dialog actions and close buttons
- **AppCard**: Similar elevated surface styling patterns
- **BottomSheet**: Alternative for mobile-first modal presentations
- **AppSnackBar**: For simple notifications that don't require interaction

## Design System Integration

### Design Tokens Used

- **Colors**: `surface`, `onSurface`, `outline`, `primary`
- **Typography**: `headlineSmall` for titles, `bodyMedium` for content
- **Spacing**: `lg` for padding, `sm` for button gaps
- **Shapes**: AppShape integration with configurable squircle/rounded styles
- **Shadows**: `xl` for elevation and depth
- **Radius**: Configurable via AppRadius tokens

### Theme Integration

- Respects theme color schemes for surface and text colors
- Adapts to light/dark mode automatically with proper contrast
- Uses AppThemeExtension for custom design system properties
- Integrates with global shape configuration (squircle/rounded)

## Accessibility

- Proper focus management with initial focus on close button
- Semantic dialog role for screen readers
- Keyboard navigation with Tab/Shift+Tab between interactive elements
- Escape key support for dismissible dialogs
- Color contrast compliance for all text and interactive elements
- Proper labeling of close button and action buttons

## Platform Considerations

- **Web**: Focus trapping within dialog, hover states on buttons
- **Mobile**: Touch-friendly button sizes, haptic feedback on actions
- **Desktop**: Keyboard shortcuts (Escape to close), proper focus indicators
- **Responsive**: Automatic layout adaptation based on screen width

## Examples in Playground

See `app_dialog_showcase_page.dart` for comprehensive examples showing:

- All factory constructor variations
- Responsive behavior demonstrations
- Form integration examples
- Loading state interactions
- Custom styling options
- Multiple action button configurations

## Migration Notes

This is a new component. When integrating existing dialogs:

1. Replace `showDialog()` calls with `AppDialog.show()`
2. Convert action buttons to use AppButton components
3. Wrap content in appropriate widgets for proper spacing
4. Configure responsive behavior via AppDialogConfig
5. Test mobile layout on different screen sizes
