# AppLoadingOverlay

## Overview

AppLoadingOverlay is a comprehensive component for creating loading states that block user interaction while maintaining visual context. It provides multiple overlay variants with customizable loading indicators, messages, and styling. The component integrates seamlessly with the design system's color, spacing, and typography tokens, offering both individual overlay controls and pre-built presets for common use cases.

## Use Cases

- **Form Submissions**: Block interaction during save/submit operations with clear feedback
- **Data Loading**: Prevent user actions while fetching or processing data
- **File Operations**: Show progress during uploads, downloads, or file processing
- **Navigation Transitions**: Display loading states during page or section transitions
- **Background Operations**: Indicate long-running processes without hiding content
- **Modal Operations**: Create focused loading experiences for specific actions
- **Avoid Using When**: Don't use for very short operations (< 500ms) or when users need access to other parts of the interface

## Component API

### Required Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `isLoading` | `bool` | - | Whether the overlay is active |
| `child` | `Widget` | - | Content to overlay (placed last in constructor) |

### Optional Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `message` | `String?` | `null` | Text message displayed with loading indicator |
| `loadingIndicator` | `Widget?` | `null` | Custom loading widget (defaults to circular indicator) |
| `backgroundColor` | `Color?` | `null` | Background color of overlay content area |
| `overlayColor` | `Color?` | `null` | Semi-transparent overlay color |
| `borderRadius` | `BorderRadius?` | `null` | Border radius for modal/inline variants |
| `padding` | `EdgeInsetsGeometry?` | `null` | Padding around loading content |
| `alignment` | `Alignment` | `center` | Alignment of loading content |
| `textStyle` | `TextStyle?` | `null` | Custom text style for message |

### Enums & Types

```dart
enum AppLoadingOverlayVariant { fullScreen, modal, inline }
```

## Variants & States

### Variants

- **Full Screen**: Covers entire screen with semi-transparent overlay, used for app-wide loading states
- **Modal**: Centered modal dialog with shadow, used for focused actions like saving or processing
- **Inline**: Overlays specific content areas, used for section-specific loading without affecting other UI

### Pre-built Presets

- **Saving**: Optimized for save operations with appropriate messaging and indicators
- **Processing**: Designed for data processing with animated dots indicator
- **Loading**: General content loading with pulse animation
- **Uploading**: File upload operations with bars indicator and success coloring

### States

- **Active**: Overlay visible, user interaction blocked
- **Inactive**: Overlay hidden, normal interaction restored
- **Animated**: Smooth transitions between states
- **Customized**: Custom colors, indicators, and messaging

## Usage Examples

### Basic Usage

```dart
// Full screen loading overlay
AppLoadingOverlay.fullScreen(
  isLoading: isLoading,
  message: 'Loading application...',
  child: MainContent(),
)

// Modal loading overlay
AppLoadingOverlay.modal(
  isLoading: isSaving,
  message: 'Saving changes...',
  child: FormContent(),
)

// Inline loading overlay
AppLoadingOverlay.inline(
  isLoading: isContentLoading,
  message: 'Loading content...',
  child: ContentArea(),
)
```

### With Customization

```dart
// Custom styled modal overlay
AppLoadingOverlay.modal(
  isLoading: isProcessing,
  message: 'Processing your request...',
  backgroundColor: AppColors.primary.resolve(context, shade: 50),
  overlayColor: AppColors.primary.resolve(context).withOpacity(0.2),
  borderRadius: BorderRadius.circular(16),
  loadingIndicator: AppLoadingIndicator.dots(
    size: AppLoadingIndicatorSize.large,
    color: AppColors.primary.resolve(context),
  ),
  textStyle: AppTextStyle.bodyLarge.style.copyWith(
    fontWeight: FontWeight.w600,
  ),
  child: ProcessingContent(),
)

// Custom inline overlay
AppLoadingOverlay.inline(
  isLoading: isImageLoading,
  backgroundColor: Colors.white.withOpacity(0.95),
  borderRadius: BorderRadius.circular(12),
  loadingIndicator: AppLoadingIndicator.pulse(
    size: AppLoadingIndicatorSize.medium,
    color: AppColors.neutral.resolve(context, shade: 400),
  ),
  child: ImageContainer(),
)
```

### Pre-built Presets

```dart
// Saving operation
AppLoadingOverlayPresets.saving(
  isLoading: isSaving,
  child: UserForm(),
)

// Data processing
AppLoadingOverlayPresets.processing(
  isLoading: isProcessing,
  message: 'Analyzing data...',
  variant: AppLoadingOverlayVariant.fullScreen,
  child: DataVisualization(),
)

// Content loading
AppLoadingOverlayPresets.loading(
  isLoading: isContentLoading,
  child: ArticleContent(),
)

// File uploading
AppLoadingOverlayPresets.uploading(
  isLoading: isUploading,
  message: 'Uploading files...',
  child: FileDropZone(),
)
```

### Advanced Usage

```dart
// Loading wrapper for convenience
AppLoadingWrapper(
  isLoading: isLoading,
  variant: AppLoadingOverlayVariant.modal,
  message: 'Please wait...',
  child: ComplexWidget(),
)

// Conditional loading with state management
class DataPage extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return AppLoadingOverlay.fullScreen(
      isLoading: context.read<DataBloc>().state.isLoading,
      message: 'Loading data...',
      child: BlocBuilder<DataBloc, DataState>(
        builder: (context, state) {
          if (state.hasError) {
            return ErrorWidget(state.error);
          }
          return DataContent(state.data);
        },
      ),
    );
  }
}

// Multiple overlay states
Widget buildContent() {
  return AppLoadingOverlay.inline(
    isLoading: isInitialLoading,
    message: 'Loading...',
    child: AppLoadingOverlay.modal(
      isLoading: isSaving,
      message: 'Saving...',
      child: EditableContent(),
    ),
  );
}
```

## Customization Guidelines

### When to Extend

- Creating domain-specific overlay presets (e.g., authentication, checkout)
- Adding new overlay variants for specific UI patterns
- Implementing custom animation effects or transitions
- Adding progress indicators or detailed status information

### How to Modify

1. **Custom Presets**: Add static methods to `AppLoadingOverlayPresets` for reusable configurations
2. **New Variants**: Extend the variant enum and add corresponding build methods
3. **Animation Effects**: Modify transition durations and curves in build methods
4. **Custom Indicators**: Create specialized loading indicators for different contexts

### Code Patterns

```dart
// Custom preset example
static Widget authenticating({
  required bool isLoading,
  required Widget child,
  String message = 'Authenticating...',
}) {
  return AppLoadingWrapper(
    isLoading: isLoading,
    variant: AppLoadingOverlayVariant.fullScreen,
    message: message,
    loadingIndicator: AppLoadingIndicator.pulse(
      size: AppLoadingIndicatorSize.large,
      color: AppColors.secondary.resolve(context),
    ),
    child: child,
  );
}

// Conditional overlay with multiple states
Widget buildOverlay() {
  if (isError) {
    return ErrorOverlay(error: error, child: content);
  }
  if (isLoading) {
    return AppLoadingOverlay.modal(
      isLoading: true,
      message: loadingMessage,
      child: content,
    );
  }
  return content;
}
```

## Related Components

- **AppLoadingIndicator**: Used within overlays for loading animations
- **AppProgressBar**: Use for determinate progress within overlays
- **AppSkeletonLoader**: Alternative for maintaining content structure during loading
- **Modal/Dialog**: Integrate with modal components for enhanced loading experiences

## Design System Integration

### Design Tokens Used

- **Colors**: Surface colors for backgrounds, primary colors for indicators
- **Spacing**: Consistent padding and margins using `AppSpacing` tokens
- **Typography**: Message text styling using `AppTextStyle` tokens
- **Animation**: Standardized transition durations and easing curves

### Theme Integration

- Automatic adaptation to light/dark themes
- Uses design system color resolution for consistent appearance
- Respects theme color schemes and contrast ratios
- Maintains accessibility compliance across different themes

## Accessibility

- Blocks user interaction appropriately during loading states
- Provides semantic loading information for screen readers
- Supports custom announcement messages for loading states
- Maintains focus management during overlay transitions
- Respects reduced motion preferences for animations

## Platform Considerations

- **Web**: Proper z-index management and overlay positioning
- **Mobile**: Touch interaction blocking and safe area handling
- **Desktop**: Mouse interaction prevention and hover state management
- **All Platforms**: Consistent visual appearance and behavior

## Performance Considerations

- Efficient overlay rendering with minimal impact on underlying content
- Optimized animation controllers with proper disposal
- Minimal rebuild overhead when overlay state changes
- Memory-efficient management of overlay content
- GPU-accelerated animations for smooth performance

## Examples in Playground

See `app_loading_overlay_showcase_page.dart` for comprehensive examples showing:
- All overlay variants with interactive controls
- Pre-built presets in different configurations
- Custom styling and theming options
- Real-world usage patterns and timing
- Guidelines for choosing appropriate variants

## Migration Notes

This component consolidates various loading overlay patterns into a single, consistent API. Can replace existing disabled overlays, loading screens, and modal loading components while providing better design system integration.

## Common Use Cases

### Form Saving
```dart
AppLoadingOverlay.modal(
  isLoading: isSaving,
  message: 'Saving changes...',
  child: UserProfileForm(),
)
```

### Data Loading
```dart
AppLoadingOverlay.fullScreen(
  isLoading: isInitialLoading,
  message: 'Loading application data...',
  child: DashboardContent(),
)
```

### Content Area Loading
```dart
AppLoadingOverlay.inline(
  isLoading: isContentLoading,
  child: ArticleViewer(),
)
```

### File Upload
```dart
AppLoadingOverlayPresets.uploading(
  isLoading: isUploading,
  child: FileUploadArea(),
)
```

### Background Processing
```dart
AppLoadingWrapper(
  isLoading: isProcessing,
  variant: AppLoadingOverlayVariant.modal,
  message: 'Processing data...',
  child: DataVisualization(),
)
```

## Best Practices

### Do ✅
- Use appropriate variants for different contexts (fullScreen for app-wide, modal for actions, inline for sections)
- Provide clear, actionable messages that explain what's happening
- Use consistent loading indicators within the same application area
- Implement proper error handling for loading failures
- Test overlay behavior with different content sizes and layouts

### Don't ❌
- Use overlays for very quick operations (< 500ms)
- Block the entire interface for minor section updates
- Use vague messages like "Loading..." without context
- Forget to handle loading failure states
- Stack multiple overlays of the same variant