import 'package:flutter/material.dart';
import 'app_spacing.dart';

enum AppDensity {
  compact,
  standard,
  comfortable;

  double get scale {
    switch (this) {
      case AppDensity.compact:
        return 0.8;
      case AppDensity.standard:
        return 1.0;
      case AppDensity.comfortable:
        return 1.2;
    }
  }

  AppSpacing get buttonPadding {
    switch (this) {
      case AppDensity.compact:
        return AppSpacing.sm;
      case AppDensity.standard:
        return AppSpacing.md;
      case AppDensity.comfortable:
        return AppSpacing.lg;
    }
  }

  AppSpacing get cardPadding {
    switch (this) {
      case AppDensity.compact:
        return AppSpacing.md;
      case AppDensity.standard:
        return AppSpacing.lg;
      case AppDensity.comfortable:
        return AppSpacing.xl;
    }
  }

  AppSpacing get listItemPadding {
    switch (this) {
      case AppDensity.compact:
        return AppSpacing.xs;
      case AppDensity.standard:
        return AppSpacing.sm;
      case AppDensity.comfortable:
        return AppSpacing.md;
    }
  }

  double get iconSize {
    switch (this) {
      case AppDensity.compact:
        return 16.0;
      case AppDensity.standard:
        return 20.0;
      case AppDensity.comfortable:
        return 24.0;
    }
  }

  double get buttonIconSize {
    switch (this) {
      case AppDensity.compact:
        return 14.0;
      case AppDensity.standard:
        return 18.0;
      case AppDensity.comfortable:
        return 20.0;
    }
  }

  double get buttonMinHeight {
    switch (this) {
      case AppDensity.compact:
        return 32.0;
      case AppDensity.standard:
        return 40.0;
      case AppDensity.comfortable:
        return 48.0;
    }
  }

  double get inputHeight {
    switch (this) {
      case AppDensity.compact:
        return 36.0;
      case AppDensity.standard:
        return 44.0;
      case AppDensity.comfortable:
        return 52.0;
    }
  }

  double get listItemHeight {
    switch (this) {
      case AppDensity.compact:
        return 40.0;
      case AppDensity.standard:
        return 48.0;
      case AppDensity.comfortable:
        return 56.0;
    }
  }

  double get appBarHeight {
    switch (this) {
      case AppDensity.compact:
        return 48.0;
      case AppDensity.standard:
        return 56.0;
      case AppDensity.comfortable:
        return 64.0;
    }
  }

  double get tabHeight {
    switch (this) {
      case AppDensity.compact:
        return 36.0;
      case AppDensity.standard:
        return 44.0;
      case AppDensity.comfortable:
        return 52.0;
    }
  }

  VisualDensity get visualDensity {
    switch (this) {
      case AppDensity.compact:
        return VisualDensity.compact;
      case AppDensity.standard:
        return VisualDensity.standard;
      case AppDensity.comfortable:
        return VisualDensity.comfortable;
    }
  }

  EdgeInsets get buttonPaddingEdgeInsets {
    switch (this) {
      case AppDensity.compact:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case AppDensity.standard:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case AppDensity.comfortable:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
    }
  }

  EdgeInsets get iconButtonPadding {
    switch (this) {
      case AppDensity.compact:
        return const EdgeInsets.all(4);
      case AppDensity.standard:
        return const EdgeInsets.all(8);
      case AppDensity.comfortable:
        return const EdgeInsets.all(12);
    }
  }
}