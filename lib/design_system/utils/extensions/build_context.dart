import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void maybePopN(int n) {
    if (n > 0) {
      int count = 0;
      router.popUntil((route) {
        return count++ == n;
      });
    }
  }

  double get height {
    return MediaQuery.of(this).size.height;
  }

  double get width {
    return MediaQuery.of(this).size.width;
  }

  double get bottomPadding {
    return MediaQuery.of(this).padding.bottom;
  }

  double get topPadding {
    return MediaQuery.of(this).padding.top;
  }

  ThemeData get theme {
    return Theme.of(this);
  }

  String get languageCode {
    return Localizations.localeOf(this).languageCode;
  }

  void removeKeyboardFocus() {
    FocusScopeNode currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  TextTheme get textTheme {
    return Theme.of(this).textTheme;
  }

  ColorScheme get colorScheme {
    return Theme.of(this).colorScheme;
  }
}
