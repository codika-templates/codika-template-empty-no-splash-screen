import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../tokens/app_colors.dart';
import '../tokens/app_density.dart';
import '../tokens/app_radius.dart';
import '../tokens/app_spacing.dart';
import '../tokens/app_typography.dart';
import 'app_theme_extension.dart';

class AppTheme {
  static ThemeData light({AppDensity? density}) {
    final selectedDensity = density ?? AppDensity.standard;
    final colorScheme = AppColors.primary.lightScheme;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      visualDensity: selectedDensity.visualDensity,

      // Typography
      textTheme: AppTextTheme.light,

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        titleTextStyle: AppTextStyle.titleLarge.style.copyWith(
          color: colorScheme.onSurface,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        toolbarHeight: selectedDensity.appBarHeight,
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          disabledForegroundColor: AppColors.neutral.materialSwatch[400],
          disabledBackgroundColor: AppColors.neutral.materialSwatch[100],
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: AppRadius.lg.buttonShape,
          padding: selectedDensity.buttonPaddingEdgeInsets,
          minimumSize: Size.fromHeight(selectedDensity.buttonMinHeight),
          textStyle: AppTextStyle.labelLarge.style,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: AppColors.neutral.materialSwatch[200]!),
          shape: AppRadius.lg.buttonShape,
          padding: selectedDensity.buttonPaddingEdgeInsets,
          minimumSize: Size.fromHeight(selectedDensity.buttonMinHeight),
          textStyle: AppTextStyle.labelLarge.style,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          shape: AppRadius.lg.buttonShape,
          padding: selectedDensity.buttonPaddingEdgeInsets,
          minimumSize: Size.fromHeight(selectedDensity.buttonMinHeight),
          textStyle: AppTextStyle.labelLarge.style,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          disabledForegroundColor: AppColors.neutral.materialSwatch[400],
          disabledBackgroundColor: AppColors.neutral.materialSwatch[100],
          shape: AppRadius.lg.buttonShape,
          padding: selectedDensity.buttonPaddingEdgeInsets,
          minimumSize: Size.fromHeight(selectedDensity.buttonMinHeight),
          textStyle: AppTextStyle.labelLarge.style,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: AppRadius.md.borderRadius,
          borderSide: BorderSide(color: AppColors.neutral.materialSwatch[200]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.md.borderRadius,
          borderSide: BorderSide(color: AppColors.neutral.materialSwatch[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.md.borderRadius,
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.md.borderRadius,
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.md.borderRadius,
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        contentPadding: AppSpacing.md.padding,
        hintStyle: AppTextStyle.bodyMedium.style.copyWith(
          color: AppColors.neutral.materialSwatch[400],
        ),
        labelStyle: AppTextStyle.bodyMedium.style.copyWith(
          color: AppColors.neutral.materialSwatch[600],
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.xl.borderRadius,
          side: BorderSide(color: AppColors.neutral.materialSwatch[200]!),
        ),
        color: colorScheme.surface,
        shadowColor: Colors.transparent,
        margin: EdgeInsets.zero,
      ),

      // List Tile Theme
      listTileTheme: ListTileThemeData(
        contentPadding: selectedDensity.listItemPadding.paddingHorizontal,
        minVerticalPadding: selectedDensity.listItemPadding.value,
        shape: AppRadius.lg.shapeBorder,
        titleTextStyle: AppTextStyle.bodyLarge.style.copyWith(
          color: colorScheme.onSurface,
        ),
        subtitleTextStyle: AppTextStyle.bodyMedium.style.copyWith(
          color: AppColors.neutral.materialSwatch[600],
        ),
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: AppColors.neutral.materialSwatch[100],
        thickness: 1,
        space: 1,
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: AppRadius.xxl.shapeBorder,
        backgroundColor: colorScheme.surface,
        titleTextStyle: AppTextStyle.titleLarge.style.copyWith(
          color: colorScheme.onSurface,
        ),
        contentTextStyle: AppTextStyle.bodyMedium.style.copyWith(
          color: colorScheme.onSurface,
        ),
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        elevation: 0,
        modalElevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.xxxl.topOnly),
        backgroundColor: colorScheme.surface,
        modalBackgroundColor: colorScheme.surface,
        shadowColor: Colors.transparent,
        modalBarrierColor: Colors.black.withOpacity(0.5),
      ),

      // Tab Bar Theme
      tabBarTheme: TabBarThemeData(
        labelColor: colorScheme.primary,
        unselectedLabelColor: AppColors.neutral.materialSwatch[600],
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        labelStyle: AppTextStyle.labelLarge.style,
        unselectedLabelStyle: AppTextStyle.labelLarge.style,
        overlayColor: WidgetStateProperty.all(
          colorScheme.primary.withOpacity(0.1),
        ),
      ),

      // Scaffold background
      scaffoldBackgroundColor: colorScheme.surface,

      // Custom extension
      extensions: [
        AppThemeExtension.light().copyWith(density: selectedDensity),
      ],
    );
  }

  static ThemeData dark({AppDensity? density}) {
    final selectedDensity = density ?? AppDensity.standard;
    final colorScheme = AppColors.primary.darkScheme;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      visualDensity: selectedDensity.visualDensity,

      // Typography
      textTheme: AppTextTheme.dark,

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        titleTextStyle: AppTextStyle.titleLarge.style.copyWith(
          color: colorScheme.onSurface,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        toolbarHeight: selectedDensity.appBarHeight,
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          disabledForegroundColor: AppColors.neutral.materialSwatch[600],
          disabledBackgroundColor: AppColors.neutral.materialSwatch[800],
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: AppRadius.lg.buttonShape,
          padding: selectedDensity.buttonPaddingEdgeInsets,
          minimumSize: Size.fromHeight(selectedDensity.buttonMinHeight),
          textStyle: AppTextStyle.labelLarge.style,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: AppColors.neutral.materialSwatch[700]!),
          shape: AppRadius.lg.buttonShape,
          padding: selectedDensity.buttonPaddingEdgeInsets,
          minimumSize: Size.fromHeight(selectedDensity.buttonMinHeight),
          textStyle: AppTextStyle.labelLarge.style,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          shape: AppRadius.lg.buttonShape,
          padding: selectedDensity.buttonPaddingEdgeInsets,
          minimumSize: Size.fromHeight(selectedDensity.buttonMinHeight),
          textStyle: AppTextStyle.labelLarge.style,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          disabledForegroundColor: AppColors.neutral.materialSwatch[600],
          disabledBackgroundColor: AppColors.neutral.materialSwatch[800],
          shape: AppRadius.lg.buttonShape,
          padding: selectedDensity.buttonPaddingEdgeInsets,
          minimumSize: Size.fromHeight(selectedDensity.buttonMinHeight),
          textStyle: AppTextStyle.labelLarge.style,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: AppRadius.md.borderRadius,
          borderSide: BorderSide(color: AppColors.neutral.materialSwatch[700]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.md.borderRadius,
          borderSide: BorderSide(color: AppColors.neutral.materialSwatch[700]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.md.borderRadius,
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.md.borderRadius,
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.md.borderRadius,
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        contentPadding: AppSpacing.md.padding,
        hintStyle: AppTextStyle.bodyMedium.style.copyWith(
          color: AppColors.neutral.materialSwatch[600],
        ),
        labelStyle: AppTextStyle.bodyMedium.style.copyWith(
          color: AppColors.neutral.materialSwatch[400],
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.xl.borderRadius,
          side: BorderSide(color: AppColors.neutral.materialSwatch[700]!),
        ),
        color: colorScheme.surface,
        shadowColor: Colors.transparent,
        margin: EdgeInsets.zero,
      ),

      // List Tile Theme
      listTileTheme: ListTileThemeData(
        contentPadding: selectedDensity.listItemPadding.paddingHorizontal,
        minVerticalPadding: selectedDensity.listItemPadding.value,
        shape: AppRadius.lg.shapeBorder,
        titleTextStyle: AppTextStyle.bodyLarge.style.copyWith(
          color: colorScheme.onSurface,
        ),
        subtitleTextStyle: AppTextStyle.bodyMedium.style.copyWith(
          color: AppColors.neutral.materialSwatch[400],
        ),
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: AppColors.neutral.materialSwatch[800],
        thickness: 1,
        space: 1,
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: AppRadius.xxl.shapeBorder,
        backgroundColor: colorScheme.surface,
        titleTextStyle: AppTextStyle.titleLarge.style.copyWith(
          color: colorScheme.onSurface,
        ),
        contentTextStyle: AppTextStyle.bodyMedium.style.copyWith(
          color: colorScheme.onSurface,
        ),
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        elevation: 0,
        modalElevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.xxxl.topOnly),
        backgroundColor: colorScheme.surface,
        modalBackgroundColor: colorScheme.surface,
        shadowColor: Colors.transparent,
        modalBarrierColor: Colors.black.withOpacity(0.7),
      ),

      // Tab Bar Theme
      tabBarTheme: TabBarThemeData(
        labelColor: colorScheme.primary,
        unselectedLabelColor: AppColors.neutral.materialSwatch[400],
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        labelStyle: AppTextStyle.labelLarge.style,
        unselectedLabelStyle: AppTextStyle.labelLarge.style,
        overlayColor: WidgetStateProperty.all(
          colorScheme.primary.withOpacity(0.1),
        ),
      ),

      // Scaffold background
      scaffoldBackgroundColor: colorScheme.surface,

      // Custom extension
      extensions: [AppThemeExtension.dark().copyWith(density: selectedDensity)],
    );
  }

  // Client-specific themes can be created by customizing the color schemes
  static ThemeData clientA({bool isDark = false, AppDensity? density}) {
    // Example: customize primary colors for Client A
    return isDark ? dark(density: density) : light(density: density);
  }

  static ThemeData clientB({bool isDark = false, AppDensity? density}) {
    // Example: customize primary colors for Client B
    return isDark ? dark(density: density) : light(density: density);
  }
}
