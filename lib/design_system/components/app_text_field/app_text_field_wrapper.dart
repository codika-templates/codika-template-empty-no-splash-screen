import 'package:flutter/material.dart';

import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';

/// Wrapper component for AppTextField that provides external labels, descriptions, and additional UI elements
class AppTextFieldWrapper extends StatelessWidget {
  final String? title;
  final String? preText;
  final String? postText;
  final String? description;
  final bool isMandatory;
  final Widget child;
  final VoidCallback? onDescriptionTap;
  final Widget? titleSuffix;
  final TextStyle? titleTextStyle;
  final TextStyle? preTextStyle;
  final TextStyle? postTextStyle;
  final TextStyle? descriptionTextStyle;
  final CrossAxisAlignment crossAxisAlignment;

  const AppTextFieldWrapper({
    super.key,
    required this.child,
    this.title,
    this.preText,
    this.postText,
    this.description,
    this.isMandatory = false,
    this.onDescriptionTap,
    this.titleSuffix,
    this.titleTextStyle,
    this.preTextStyle,
    this.postTextStyle,
    this.descriptionTextStyle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        // Pre-text (above title)
        if (preText != null) ...[
          Text(
            preText!,
            style: preTextStyle ?? 
                AppTextStyle.bodySmall.style.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
          ),
          AppSpacing.xs.gapV,
        ],

        // Title with optional mandatory indicator and suffix
        if (title != null) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  title!,
                  style: titleTextStyle ?? 
                      AppTextStyle.labelLarge.style.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              if (isMandatory) ...[
                AppSpacing.xs.gapH,
                Text(
                  '*',
                  style: AppTextStyle.labelLarge.style.copyWith(
                    color: theme.colorScheme.error,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              if (titleSuffix != null) ...[
                AppSpacing.xs.gapH,
                titleSuffix!,
              ],
            ],
          ),
          AppSpacing.sm.gapV,
        ],

        // The actual input field
        child,

        // Post-text and description (below input)
        if (postText != null) ...[
          AppSpacing.sm.gapV,
          Text(
            postText!,
            style: postTextStyle ?? 
                AppTextStyle.bodySmall.style.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
          ),
        ],

        if (description != null) ...[
          AppSpacing.sm.gapV,
          if (onDescriptionTap != null)
            InkWell(
              onTap: onDescriptionTap,
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: AppSpacing.xs.padding,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        description!,
                        style: descriptionTextStyle ?? 
                            AppTextStyle.bodySmall.style.copyWith(
                              color: theme.colorScheme.primary,
                              decoration: TextDecoration.underline,
                              decorationColor: theme.colorScheme.primary,
                            ),
                      ),
                    ),
                    AppSpacing.xs.gapH,
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                  ],
                ),
              ),
            )
          else
            Text(
              description!,
              style: descriptionTextStyle ?? 
                  AppTextStyle.bodySmall.style.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
            ),
        ],
      ],
    );
  }
}