# AppWoltModal

## Overview

Advanced multi-page modal component built on Wolt Modal Sheet for sophisticated user flows. Provides smooth navigation between pages with professional animations and adaptive sizing. Features responsive design that automatically adapts between dialog style on desktop and bottom sheet on mobile. Perfect for complex workflows like onboarding, forms, galleries, and multi-step processes.

## Use Cases

- **Onboarding Flows**: Multi-step user introductions with smooth transitions
- **Complex Forms**: Multi-page forms with validation and progress tracking
- **Galleries**: Image/content browsing with navigation controls
- **Settings Wizards**: Step-by-step configuration flows
- **Avoid Using When**: For simple confirmations or single-page content - use AppDialog or AppBottomSheet instead

## Component API

### Required Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `context` | `BuildContext` | Build context for showing the modal |

### Optional Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `config` | `AppWoltModalConfig` | `AppWoltModalConfig()` | Modal behavior and appearance configuration |
| `pageIndexNotifier` | `ValueNotifier<int>?` | `null` | Controls current page (required for multi-page) |
| `pages` | `List<WoltModalSheetPage>` | `[]` | List of pages for multi-page modals |
| `onCancel` | `VoidCallback?` | `null` | Callback for cancel/close actions |

### Enums & Types

```dart
class AppWoltModalConfig {
  final double maxWidth;                    // Maximum modal width on desktop
  final double minHeight;                   // Minimum modal height
  final double maxHeight;                   // Maximum modal height
  final bool enableDrag;                    // Enable drag to dismiss
  final bool barrierDismissible;           // Can dismiss by tapping outside
  final Color? backgroundColor;             // Custom background color
  final AppRadius? borderRadius;           // Custom border radius
  final double mobileBreakpoint;           // Width threshold for mobile layout
}

class AppWoltModalPageActions {
  final Widget? primary;                   // Primary action button
  final Widget? secondary;                 // Secondary action button
  final List<Widget> additional;          // Additional action buttons
  final bool stackOnMobile;               // Stack buttons vertically on mobile
  final MainAxisAlignment alignment;      // Button alignment
}
```

## Variants & States

### Factory Constructors

- **AppWoltModal.simple()**: Single page modal with title and content
- **AppWoltModal.form()**: Form modal with validation and actions
- **AppWoltModal.workflow()**: Multi-page workflow with navigation
- **AppWoltModal.loading()**: Loading modal with progress indication
- **AppWoltModal.showPages()**: Custom multi-page configuration

### States

- **Single Page**: Standard modal with one content page
- **Multi-Page**: Navigation between multiple pages with smooth transitions
- **Loading**: Shows progress indicator with optional cancel button
- **Responsive**: Adapts between dialog (desktop) and bottom sheet (mobile)
- **Drag Enabled**: Supports drag-to-dismiss gestures on mobile

## Page Types

### AppWoltModalPage Types

- **AppWoltModalPage.standard()**: General purpose page with title and content
- **AppWoltModalPage.form()**: Optimized for form inputs with validation
- **AppWoltModalPage.simple()**: Minimal page with basic content
- **AppWoltModalPage.confirmation()**: Confirmation page with primary/secondary actions
- **AppWoltModalPage.loading()**: Loading page with progress indicator

## Usage Examples

### Simple Modal

```dart
AppWoltModal.simple(
  context: context,
  title: 'Information',
  content: Column(
    children: [
      Icon(Icons.info, size: 48),
      SizedBox(height: 16),
      Text('This is important information for the user.'),
    ],
  ),
  primaryAction: AppButton.primary(
    onPressed: () => Navigator.of(context).pop(),
    child: Text('Got it'),
  ),
);
```

### Multi-Page Workflow

```dart
final pageNotifier = ValueNotifier<int>(0);

AppWoltModal.workflow(
  context: context,
  pageIndexNotifier: pageNotifier,
  pages: [
    AppWoltModalPage.standard(
      id: 'step1',
      title: 'Step 1: Welcome',
      content: Text('Welcome to our app!'),
      actions: AppWoltModalPageActions(
        primary: AppButton.primary(
          onPressed: () => pageNotifier.value = 1,
          child: Text('Next'),
        ),
      ),
    ),
    AppWoltModalPage.standard(
      id: 'step2',
      title: 'Step 2: Setup',
      content: Text('Let\'s set up your account.'),
      actions: AppWoltModalPageActions(
        primary: AppButton.primary(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Finish'),
        ),
        secondary: AppButton.secondary(
          onPressed: () => pageNotifier.value = 0,
          child: Text('Back'),
        ),
      ),
    ),
  ],
);
```

### Form Modal

```dart
AppWoltModal.form(
  context: context,
  title: 'Contact Form',
  content: Column(
    children: [
      TextField(
        decoration: InputDecoration(
          labelText: 'Name',
          border: OutlineInputBorder(),
        ),
      ),
      SizedBox(height: 16),
      TextField(
        decoration: InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
        ),
      ),
    ],
  ),
  primaryAction: AppButton.primary(
    onPressed: () => handleSubmit(),
    child: Text('Send'),
  ),
  secondaryAction: AppButton.secondary(
    onPressed: () => Navigator.of(context).pop(),
    child: Text('Cancel'),
  ),
);
```

### Loading Modal with Cancel

```dart
AppWoltModal.loading(
  context: context,
  title: 'Processing',
  subtitle: 'Please wait while we process your request...',
  onCancel: () {
    cancelOperation();
    Navigator.of(context).pop();
  },
);
```

### Complex Multi-Page Example

```dart
AppWoltModal.showPages(
  context: context,
  pageIndexNotifier: pageNotifier,
  config: AppWoltModalConfig(
    maxWidth: 500,
    enableDrag: true,
    barrierDismissible: false,
  ),
  pages: [
    AppWoltModalPage.form(
      id: 'personal',
      title: 'Personal Information',
      content: PersonalInfoForm(),
      primaryAction: AppButton.primary(
        onPressed: () => validateAndNext(),
        child: Text('Continue'),
      ),
    ),
    AppWoltModalPage.standard(
      id: 'review',
      title: 'Review Information',
      content: ReviewPage(),
      actions: AppWoltModalPageActions(
        primary: AppButton.primary(
          onPressed: () => submitForm(),
          child: Text('Submit'),
        ),
        secondary: AppButton.secondary(
          onPressed: () => pageNotifier.value = 0,
          child: Text('Back'),
        ),
      ),
    ),
  ],
);
```

## Customization Guidelines

### When to Extend

- Creating domain-specific workflows (e.g., user registration, product configuration)
- Adding custom page transitions or animations
- Implementing specialized validation patterns
- Creating reusable multi-step processes

### How to Modify

1. **Custom Page Types**: Create specialized page builders for common patterns
2. **Workflow Helpers**: Build helper methods for common multi-page flows
3. **Configuration Extensions**: Extend AppWoltModalConfig for new options
4. **Animation Customization**: Modify page transition animations

### Code Patterns

```dart
// Creating a specialized workflow
class UserOnboardingModal {
  static void show(BuildContext context, User user) {
    final pageNotifier = ValueNotifier<int>(0);
    
    AppWoltModal.workflow(
      context: context,
      pageIndexNotifier: pageNotifier,
      pages: [
        _buildWelcomePage(pageNotifier),
        _buildPreferencesPage(pageNotifier, user),
        _buildCompletePage(context),
      ],
    );
  }
  
  static WoltModalSheetPage _buildWelcomePage(ValueNotifier<int> notifier) {
    return AppWoltModalPage.standard(
      id: 'welcome',
      title: 'Welcome!',
      content: WelcomeContent(),
      actions: AppWoltModalPageActions(
        primary: AppButton.primary(
          onPressed: () => notifier.value = 1,
          child: Text('Get Started'),
        ),
      ),
    );
  }
}
```

## Related Components

- **AppDialog**: For simple single-page modals and confirmations
- **AppBottomSheet**: For mobile-first single-page sheets
- **AppButton**: Used for all modal actions and navigation
- **AppCard**: Similar elevated surface styling patterns

## Design System Integration

### Design Tokens Used

- **Colors**: `surface`, `onSurface`, `outline`, `primary`
- **Typography**: `headlineSmall` for titles, `bodyMedium` for content
- **Spacing**: `lg` for padding, `md` for content spacing
- **Shapes**: AppShape integration with configurable borders
- **Shadows**: Built-in Wolt modal elevation
- **Radius**: Configurable via AppRadius tokens

### Theme Integration

- Respects theme color schemes automatically
- Adapts to light/dark mode with proper contrast
- Uses design system typography and spacing tokens
- Integrates with app-wide shape configuration

## Accessibility

- Full keyboard navigation support with Tab/Shift+Tab
- Screen reader compatibility with proper ARIA labels
- Focus management between pages and interactive elements
- Escape key support for dismissible modals
- Color contrast compliance for all text elements
- Proper button labeling and roles

## Platform Considerations

- **Web**: Full keyboard navigation, focus trapping, hover states
- **Mobile**: Touch gestures, drag-to-dismiss, haptic feedback
- **Desktop**: Keyboard shortcuts, proper focus indicators
- **Responsive**: Automatic adaptation between dialog and sheet modes

## Examples in Playground

See `app_wolt_modal_showcase_page.dart` for comprehensive examples showing:

- Basic single-page modals
- Multi-page workflow demonstrations
- Form integration examples
- Loading states with cancellation
- Gallery and image browsing
- Complex e-commerce checkout flows
- Settings configuration wizards
- Onboarding flow examples

## Migration Notes

When upgrading from basic dialogs to Wolt modals:

1. Replace single-page dialogs with `AppWoltModal.simple()`
2. Convert multi-step flows to use `pageIndexNotifier` pattern
3. Update action buttons to use AppButton components
4. Configure responsive behavior via AppWoltModalConfig
5. Test drag gestures and navigation on mobile devices
6. Ensure proper lifecycle management for async operations

## Performance Considerations

- Pages are built lazily as needed for better performance
- Use `ValueNotifier` for page state to minimize rebuilds
- Implement proper disposal of controllers and notifiers
- Consider using `AutomaticKeepAliveClientMixin` for complex pages
- Monitor memory usage with image-heavy gallery implementations