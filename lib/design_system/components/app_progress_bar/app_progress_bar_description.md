# AppProgressBar

## Overview

AppProgressBar is a comprehensive component for displaying progress indicators with multiple variants and orientations. It provides consistent progress visualization that integrates with the design system's color and spacing tokens. The component supports determinate and indeterminate progress, timer functionality for time-bound operations, and stepped progress for multi-stage processes.

## Use Cases

- **Loading States**: Display progress during data loading, file uploads, or content processing
- **Timer Operations**: Visual countdown timers for temporary states or time-limited actions
- **Multi-Step Processes**: Show progress through forms, wizards, or guided workflows
- **Background Operations**: Indicate progress of long-running background tasks
- **User Onboarding**: Guide users through setup or tutorial processes
- **Avoid Using When**: Don't use for binary states (use loading indicators instead) or when exact timing is critical

## Component API

### Required Parameters

None - all parameters are optional with sensible defaults.

### Optional Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `value` | `double?` | `null` | Progress value (0.0-1.0) for determinate progress |
| `duration` | `Duration?` | `null` | Duration for timer variant |
| `delay` | `Duration` | `Duration.zero` | Delay before starting timer animation |
| `orientation` | `AppProgressBarOrientation` | `horizontal` | Direction of progress bar |
| `thickness` | `double` | `4.0` | Height (horizontal) or width (vertical) of bar |
| `backgroundColor` | `Color?` | `null` | Background color (defaults to divider color) |
| `progressColor` | `Color?` | `null` | Progress color (defaults to primary color) |
| `borderRadius` | `BorderRadius?` | `null` | Custom border radius |
| `padding` | `EdgeInsetsGeometry?` | `null` | Padding around the progress bar |
| `onComplete` | `VoidCallback?` | `null` | Callback when timer completes |
| `isAnimated` | `bool` | `true` | Whether to animate progress changes |
| `steps` | `int?` | `null` | Total number of steps (stepped variant) |
| `currentStep` | `int?` | `null` | Current step position (stepped variant) |

### Enums & Types

```dart
enum AppProgressBarVariant { linear, timer, stepped }
enum AppProgressBarOrientation { horizontal, vertical }
```

## Variants & States

### Variants

- **Linear**: Standard progress bar for general loading states and determinate progress
- **Timer**: Countdown timer with automatic progression and completion callback
- **Stepped**: Multi-step progress for workflows, forms, and guided processes

### Orientations

- **Horizontal**: Standard left-to-right progress indication
- **Vertical**: Bottom-to-top progress for sidebar or compact layouts

### States

- **Determinate**: Shows specific progress value (0.0 to 1.0)
- **Indeterminate**: Continuous animation without specific progress value
- **Animated**: Smooth transitions between progress states
- **Static**: Immediate progress updates without animation

## Usage Examples

### Basic Usage

```dart
// Simple linear progress bar
AppProgressBar.linear(value: 0.6)

// Timer progress bar
AppProgressBar.timer(
  duration: Duration(seconds: 30),
  onComplete: () => print('Timer finished!'),
)

// Stepped progress
AppProgressBar.stepped(
  steps: 5,
  currentStep: 2,
)
```

### With Customization

```dart
// Custom styled linear progress
AppProgressBar.linear(
  value: 0.75,
  thickness: 8.0,
  progressColor: AppColors.success.resolve(context),
  backgroundColor: AppColors.neutral.resolve(context, shade: 100),
)

// Vertical timer progress
AppProgressBar.timer(
  duration: Duration(minutes: 5),
  orientation: AppProgressBarOrientation.vertical,
  thickness: 6.0,
  delay: Duration(seconds: 1),
)

// Stepped progress with custom styling
AppProgressBar.stepped(
  steps: 4,
  currentStep: 3,
  thickness: 10.0,
  progressColor: AppColors.primary.resolve(context),
  isAnimated: true,
)
```

### Advanced Usage

```dart
// File upload progress with percentage
Row(
  children: [
    Expanded(
      child: AppProgressBar.linear(
        value: uploadProgress,
        thickness: 6.0,
        progressColor: AppColors.success.resolve(context),
      ),
    ),
    AppSpacing.md.gapH,
    Text('${(uploadProgress * 100).toInt()}%'),
  ],
)

// Multi-step form progress
Column(
  children: [
    AppProgressBar.stepped(
      steps: formSteps.length,
      currentStep: currentFormStep,
      thickness: 8.0,
    ),
    AppSpacing.sm.gapV,
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: formSteps.map((step) => Text(step.title)).toList(),
    ),
  ],
)

// Countdown timer with completion action
AppProgressBar.timer(
  duration: Duration(seconds: sessionTimeout),
  thickness: 4.0,
  progressColor: AppColors.warning.resolve(context),
  onComplete: () => Navigator.of(context).pop(),
)
```

## Customization Guidelines

### When to Extend

- Adding new animation curves or timing functions
- Creating specialized variants for domain-specific use cases
- Implementing gradient or multi-color progress indicators
- Adding progress labels or value displays

### How to Modify

1. **Adding Variants**: Extend the variant enum and add corresponding factory constructors
2. **Custom Animations**: Modify animation controllers and curves in the state class
3. **Visual Styling**: Create custom painters for unique visual effects
4. **Interaction**: Add gesture detection for interactive progress bars

### Code Patterns

```dart
// Custom animation timing
AppProgressBar.timer(
  duration: Duration(milliseconds: 2500),
  // Custom curve can be added by modifying the animation setup
)

// Color variations
AppProgressBar.linear(
  value: progress,
  progressColor: isError 
    ? AppColors.error.resolve(context)
    : AppColors.success.resolve(context),
)

// Dynamic thickness
AppProgressBar.linear(
  value: progress,
  thickness: isImportant ? 8.0 : 4.0,
)
```

## Related Components

- **AppLoadingIndicator**: Use for indeterminate loading without progress information
- **AppLoadingOverlay**: Combine with progress bars for full-screen loading states
- **AppButton**: Integrate progress bars into button loading states
- **AppSkeletonLoader**: Use alongside progress bars for content loading

## Design System Integration

### Design Tokens Used

- **Colors**: `AppColors.primary` for progress, `Theme.dividerColor` for background
- **Spacing**: `AppSpacing.sm` for default padding
- **Radius**: `AppRadius.sm` for rounded corners
- **Animation**: Consistent timing and easing curves

### Theme Integration

- Respects Material Design theming with automatic color adaptation
- Uses design system color resolution for consistent appearance
- Integrates with light/dark mode themes
- Maintains proper contrast ratios for accessibility

## Accessibility

- Semantic progress role for screen readers
- Announcements for progress updates (can be configured)
- High contrast support through color system integration
- Reduced motion respect through Flutter's accessibility settings
- Proper focus management for interactive progress bars

## Platform Considerations

- **Web**: Smooth animations with CSS-like performance
- **Mobile**: Battery-efficient animations with lifecycle management
- **Desktop**: Appropriate sizing for different input methods
- **All Platforms**: Consistent visual appearance and timing

## Performance Considerations

- Optimized custom painters for smooth rendering
- Efficient animation controllers with proper disposal
- Minimal rebuild overhead with targeted animation updates
- Memory-efficient timer management
- GPU-accelerated drawing operations

## Examples in Playground

See `app_progress_bar_showcase_page.dart` for comprehensive examples showing:
- All progress bar variants with interactive controls
- Different orientations and thickness options
- Timer functionality with completion callbacks
- Stepped progress with dynamic step updates
- Color and styling customization examples

## Migration Notes

This is a new component designed to consolidate various progress indication patterns. Can replace existing timer progress bars or stepped indicators while providing additional functionality and design system integration.

## Common Use Cases

### File Upload Progress
```dart
Column(
  children: [
    AppProgressBar.linear(
      value: uploadProgress,
      thickness: 6.0,
      progressColor: AppColors.success.resolve(context),
    ),
    AppSpacing.sm.gapV,
    Text('Uploading... ${fileName}'),
  ],
)
```

### Form Wizard Progress
```dart
AppProgressBar.stepped(
  steps: wizardSteps.length,
  currentStep: currentWizardStep,
  thickness: 8.0,
  progressColor: AppColors.primary.resolve(context),
)
```

### Session Timeout Warning
```dart
AppProgressBar.timer(
  duration: Duration(seconds: 60),
  thickness: 3.0,
  progressColor: AppColors.warning.resolve(context),
  onComplete: () => showTimeoutDialog(),
)
```

### Loading State with Progress
```dart
if (isLoading)
  AppProgressBar.linear(
    thickness: 2.0,
    progressColor: AppColors.primary.resolve(context),
  )
```