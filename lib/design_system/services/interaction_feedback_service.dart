import 'package:flutter/services.dart';

/// Types of interaction feedback available
enum FeedbackType {
  /// Light haptic feedback for subtle interactions
  light,
  /// Medium haptic feedback for normal interactions  
  medium,
  /// Heavy haptic feedback for important interactions
  heavy,
  /// Selection feedback for picking items
  selection,
  /// Impact feedback for button presses
  impact,
  /// Error feedback for mistakes or failures
  error,
  /// Success feedback for completed actions
  success,
}

/// Audio feedback types
enum AudioFeedbackType {
  /// Subtle click sound
  click,
  /// Button press sound
  press,
  /// Selection sound
  select,
  /// Error sound
  error,
  /// Success sound
  success,
}

/// Global service for managing interaction feedback (haptics, audio, etc.)
/// This service can be enabled/disabled globally and provides consistent
/// feedback patterns across all components in the design system.
class InteractionFeedbackService {
  static InteractionFeedbackService? _instance;
  static InteractionFeedbackService get instance {
    _instance ??= InteractionFeedbackService._();
    return _instance!;
  }

  InteractionFeedbackService._();

  /// Whether haptic feedback is enabled globally
  bool _hapticsEnabled = true;
  
  /// Whether audio feedback is enabled globally  
  bool _audioEnabled = false;
  
  /// Custom haptic patterns (for future extensibility)
  final Map<String, List<int>> _customHapticPatterns = {};
  
  /// Custom audio feedback callbacks (for future extensibility)
  final Map<AudioFeedbackType, VoidCallback> _audioCallbacks = {};

  // Getters
  bool get hapticsEnabled => _hapticsEnabled;
  bool get audioEnabled => _audioEnabled;

  // Global configuration
  void configure({
    bool? enableHaptics,
    bool? enableAudio,
  }) {
    if (enableHaptics != null) _hapticsEnabled = enableHaptics;
    if (enableAudio != null) _audioEnabled = enableAudio;
  }

  /// Register custom audio feedback callback
  void registerAudioCallback(AudioFeedbackType type, VoidCallback callback) {
    _audioCallbacks[type] = callback;
  }

  /// Register custom haptic pattern
  void registerHapticPattern(String name, List<int> pattern) {
    _customHapticPatterns[name] = pattern;
  }

  /// Trigger haptic feedback based on interaction type
  Future<void> haptic(FeedbackType type) async {
    if (!_hapticsEnabled) return;

    try {
      switch (type) {
        case FeedbackType.light:
          await HapticFeedback.lightImpact();
          break;
        case FeedbackType.medium:
          await HapticFeedback.mediumImpact();
          break;
        case FeedbackType.heavy:
          await HapticFeedback.heavyImpact();
          break;
        case FeedbackType.selection:
          await HapticFeedback.selectionClick();
          break;
        case FeedbackType.impact:
          await HapticFeedback.lightImpact();
          break;
        case FeedbackType.error:
          // Double vibration for errors
          await HapticFeedback.heavyImpact();
          await Future.delayed(const Duration(milliseconds: 100));
          await HapticFeedback.heavyImpact();
          break;
        case FeedbackType.success:
          // Success pattern: light, pause, medium
          await HapticFeedback.lightImpact();
          await Future.delayed(const Duration(milliseconds: 50));
          await HapticFeedback.mediumImpact();
          break;
      }
    } catch (e) {
      // Haptic feedback might not be available on all platforms
      // Silently fail
    }
  }

  /// Trigger audio feedback
  void audio(AudioFeedbackType type) {
    if (!_audioEnabled) return;
    
    final callback = _audioCallbacks[type];
    callback?.call();
  }

  /// Convenient method to trigger both haptic and audio feedback
  Future<void> feedback({
    FeedbackType? haptic,
    AudioFeedbackType? audio,
  }) async {
    if (haptic != null) {
      await this.haptic(haptic);
    }
    if (audio != null) {
      this.audio(audio);
    }
  }

  /// Execute custom haptic pattern
  Future<void> customHaptic(String patternName) async {
    if (!_hapticsEnabled) return;
    
    final pattern = _customHapticPatterns[patternName];
    if (pattern == null) return;

    try {
      for (int i = 0; i < pattern.length; i++) {
        if (i % 2 == 0) {
          // Even indices are vibration durations (convert to feedback type)
          final intensity = pattern[i];
          if (intensity > 100) {
            await HapticFeedback.heavyImpact();
          } else if (intensity > 50) {
            await HapticFeedback.mediumImpact();
          } else {
            await HapticFeedback.lightImpact();
          }
        } else {
          // Odd indices are pause durations
          await Future.delayed(Duration(milliseconds: pattern[i]));
        }
      }
    } catch (e) {
      // Silently fail if haptics not available
    }
  }

  /// Disable all feedback temporarily
  void disable() {
    _hapticsEnabled = false;
    _audioEnabled = false;
  }

  /// Re-enable feedback with previous settings
  void enable({bool? haptics, bool? audio}) {
    _hapticsEnabled = haptics ?? true;
    _audioEnabled = audio ?? false;
  }

  /// Reset to default settings
  void reset() {
    _hapticsEnabled = true;
    _audioEnabled = false;
    _customHapticPatterns.clear();
    _audioCallbacks.clear();
  }
}

/// Convenient global access to feedback service
final feedbackService = InteractionFeedbackService.instance;