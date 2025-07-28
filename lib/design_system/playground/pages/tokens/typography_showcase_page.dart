import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../tokens/app_typography.dart';
import '../../../tokens/app_spacing.dart';
import '../../../tokens/app_radius.dart';
import '../../widgets/showcase_section.dart';

@RoutePage()
class TypographyShowcasePage extends StatelessWidget {
  const TypographyShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Typography Tokens',
          style: AppTextStyle.headlineMedium.style,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.lg.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTypographyInAction(context),
            AppSpacing.xl.gapV,
            
            ShowcaseSection(
              title: 'Display Styles',
              description: 'Large text styles for headlines and hero content',
              children: [
                _buildTextStyleDemo(context, 'Display Large', AppTextStyle.displayLarge),
                _buildTextStyleDemo(context, 'Display Medium', AppTextStyle.displayMedium),
                _buildTextStyleDemo(context, 'Display Small', AppTextStyle.displaySmall),
              ],
            ),
            
            ShowcaseSection(
              title: 'Headline Styles',
              description: 'Text styles for section headings',
              children: [
                _buildTextStyleDemo(context, 'Headline Large', AppTextStyle.headlineLarge),
                _buildTextStyleDemo(context, 'Headline Medium', AppTextStyle.headlineMedium),
                _buildTextStyleDemo(context, 'Headline Small', AppTextStyle.headlineSmall),
              ],
            ),
            
            ShowcaseSection(
              title: 'Title Styles',
              description: 'Text styles for titles and prominent text',
              children: [
                _buildTextStyleDemo(context, 'Title Large', AppTextStyle.titleLarge),
                _buildTextStyleDemo(context, 'Title Medium', AppTextStyle.titleMedium),
                _buildTextStyleDemo(context, 'Title Small', AppTextStyle.titleSmall),
              ],
            ),
            
            ShowcaseSection(
              title: 'Body Styles',
              description: 'Text styles for body content',
              children: [
                _buildTextStyleDemo(context, 'Body Large', AppTextStyle.bodyLarge),
                _buildTextStyleDemo(context, 'Body Medium', AppTextStyle.bodyMedium),
                _buildTextStyleDemo(context, 'Body Small', AppTextStyle.bodySmall),
              ],
            ),
            
            ShowcaseSection(
              title: 'Label Styles',
              description: 'Text styles for labels and captions',
              children: [
                _buildTextStyleDemo(context, 'Label Large', AppTextStyle.labelLarge),
                _buildTextStyleDemo(context, 'Label Medium', AppTextStyle.labelMedium),
                _buildTextStyleDemo(context, 'Label Small', AppTextStyle.labelSmall),
              ],
            ),
            
            ShowcaseSection(
              title: 'Style Variations',
              description: 'Text style modifiers and variations',
              children: [
                _buildStyleVariation(context, 'Bold', AppTextStyle.bodyMedium.bold()),
                _buildStyleVariation(context, 'Semi Bold', AppTextStyle.bodyMedium.semiBold()),
                _buildStyleVariation(context, 'Medium', AppTextStyle.bodyMedium.medium()),
                _buildStyleVariation(context, 'Regular', AppTextStyle.bodyMedium.regular()),
                _buildStyleVariation(context, 'Light', AppTextStyle.bodyMedium.light()),
                _buildStyleVariation(context, 'Italic', AppTextStyle.bodyMedium.italic()),
                _buildStyleVariation(context, 'Underline', AppTextStyle.bodyMedium.underline()),
                _buildStyleVariation(context, 'Line Through', AppTextStyle.bodyMedium.lineThrough()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextStyleDemo(BuildContext context, String name, AppTextStyle textStyle) {
    final style = textStyle.style;
    
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: InkWell(
        onTap: () => _copyStyleInfo(context, name, style),
        child: Container(
          padding: AppSpacing.md.padding,
          decoration: BoxDecoration(
            borderRadius: AppRadius.sm.borderRadius,
            border: Border.all(color: Theme.of(context).colorScheme.outline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: AppTextStyle.labelMedium.style,
                        ),
                        AppSpacing.xs.gapV,
                        Text(
                          _getStyleSpecs(style),
                          style: AppTextStyle.bodySmall.style.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.copy,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              AppSpacing.sm.gapV,
              Text(
                _getExampleText(textStyle),
                style: style,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStyleVariation(BuildContext context, String name, TextStyle style) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: InkWell(
        onTap: () => _copyStyleInfo(context, name, style),
        child: Row(
          children: [
            SizedBox(
              width: 120,
              child: Text(
                name,
                style: AppTextStyle.labelMedium.style,
              ),
            ),
            AppSpacing.md.gapH,
            Expanded(
              child: Text(
                'Sample text with $name style',
                style: style,
              ),
            ),
            Icon(
              Icons.copy,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  String _getStyleSpecs(TextStyle style) {
    final fontSize = style.fontSize?.toInt() ?? 0;
    final fontWeight = _getFontWeightName(style.fontWeight);
    final letterSpacing = style.letterSpacing?.toStringAsFixed(2) ?? '0';
    final height = style.height?.toStringAsFixed(2) ?? 'auto';
    
    return '$fontSize px • $fontWeight • Letter: $letterSpacing • Height: $height';
  }

  String _getFontWeightName(FontWeight? weight) {
    if (weight == null) return 'Regular';
    
    switch (weight.index) {
      case 0: return 'Thin';
      case 1: return 'Extra Light';
      case 2: return 'Light';
      case 3: return 'Regular';
      case 4: return 'Medium';
      case 5: return 'Semi Bold';
      case 6: return 'Bold';
      case 7: return 'Extra Bold';
      case 8: return 'Black';
      default: return 'Regular';
    }
  }

  void _copyStyleInfo(BuildContext context, String name, TextStyle style) {
    final styleCode = '''TextStyle(
  fontSize: ${style.fontSize},
  fontWeight: FontWeight.w${style.fontWeight?.value ?? 400},
  letterSpacing: ${style.letterSpacing},
  height: ${style.height},
)''';
    
    Clipboard.setData(ClipboardData(text: styleCode));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied $name style code to clipboard'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildTypographyInAction(BuildContext context) {
    return ShowcaseSection(
      title: 'Typography in Action',
      description: 'See how all text styles work together in a real article',
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Large - Main headline
            Text(
              'The Art of Design Systems',
              style: AppTextStyle.displayLarge.style,
            ),
            AppSpacing.sm.gapV,
            
            // Label Small - Article metadata
            Text(
              'DESIGN • 5 MIN READ • MARCH 2024',
              style: AppTextStyle.labelSmall.style.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            AppSpacing.lg.gapV,
            
            // Headline Large - Section header
            Text(
              'Building Consistency at Scale',
              style: AppTextStyle.headlineLarge.style,
            ),
            AppSpacing.md.gapV,
            
            // Body Large - Introduction
            Text(
              'Design systems have revolutionized how teams create digital products. They provide a shared language between designers and developers, ensuring consistency while enabling rapid iteration.',
              style: AppTextStyle.bodyLarge.style,
            ),
            AppSpacing.md.gapV,
            
            // Body Medium - Regular content
            Text(
              'At the heart of every great design system lies typography. It\'s the foundation that shapes how users consume information, navigate interfaces, and understand hierarchies.',
              style: AppTextStyle.bodyMedium.style,
            ),
            AppSpacing.lg.gapV,
            
            // Headline Medium - Subsection
            Text(
              'Typography Hierarchy in Practice',
              style: AppTextStyle.headlineMedium.style,
            ),
            AppSpacing.md.gapV,
            
            // Title Large - Key point
            Text(
              'Every text style serves a specific purpose in the interface',
              style: AppTextStyle.titleLarge.style,
            ),
            AppSpacing.sm.gapV,
            
            // Body Medium - Explanation
            Text(
              'From display text that captures attention to body text that informs, each style in your system should have clear usage guidelines and semantic meaning.',
              style: AppTextStyle.bodyMedium.style,
            ),
            AppSpacing.md.gapV,
            
            // Title Medium - List header
            Text(
              'Key Principles to Remember:',
              style: AppTextStyle.titleMedium.style,
            ),
            AppSpacing.sm.gapV,
            
            // Body Small - List items with different styles
            Padding(
              padding: AppSpacing.md.paddingLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• Consistency builds trust', style: AppTextStyle.bodySmall.style),
                  AppSpacing.xs.gapV,
                  Text('• Hierarchy guides understanding', style: AppTextStyle.bodySmall.style),
                  AppSpacing.xs.gapV,
                  Text('• Accessibility ensures inclusion', style: AppTextStyle.bodySmall.style),
                ],
              ),
            ),
            AppSpacing.lg.gapV,
            
            // Headline Small - Final section
            Text(
              'The Future of Typography',
              style: AppTextStyle.headlineSmall.style,
            ),
            AppSpacing.sm.gapV,
            
            // Body Medium - Conclusion
            Text(
              'As design systems mature, typography continues to evolve. Variable fonts, responsive type scales, and AI-assisted design are shaping the next generation of digital typography.',
              style: AppTextStyle.bodyMedium.style,
            ),
            AppSpacing.md.gapV,
            
            // Label Large - Call to action
            Row(
              children: [
                Text(
                  'Continue Reading',
                  style: AppTextStyle.labelLarge.style.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                AppSpacing.xs.gapH,
                Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  String _getExampleText(AppTextStyle textStyle) {
    switch (textStyle) {
      case AppTextStyle.displayLarge:
        return 'Design Systems That Scale';
      case AppTextStyle.displayMedium:
        return 'Beautiful Typography';
      case AppTextStyle.displaySmall:
        return 'Crafted with Care';
      
      case AppTextStyle.headlineLarge:
        return 'Building Better Products Together';
      case AppTextStyle.headlineMedium:
        return 'Consistency Meets Creativity';
      case AppTextStyle.headlineSmall:
        return 'Every Detail Matters';
      
      case AppTextStyle.titleLarge:
        return 'Typography is the voice of your design';
      case AppTextStyle.titleMedium:
        return 'Form follows function in every pixel';
      case AppTextStyle.titleSmall:
        return 'Simplicity is the ultimate sophistication';
      
      case AppTextStyle.bodyLarge:
        return 'Great design systems are born from the perfect marriage of consistency and flexibility. They provide structure while embracing creative freedom.';
      case AppTextStyle.bodyMedium:
        return 'Typography serves as the foundation of digital communication, guiding users through content with clarity and purpose.';
      case AppTextStyle.bodySmall:
        return 'Every typeface tells a story. Choose yours wisely to create meaningful connections with your audience.';
      
      case AppTextStyle.labelLarge:
        return 'Primary Action';
      case AppTextStyle.labelMedium:
        return 'Secondary';
      case AppTextStyle.labelSmall:
        return 'Caption';
    }
  }
}