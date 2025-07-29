import 'package:auto_route/auto_route.dart';
import 'package:codika_template_empty_no_splash_screen/design_system/playground/router/playground_router.dart';
import 'package:flutter/material.dart';

import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';
import '../widgets/showcase_card.dart';

@RoutePage()
class PlaygroundDashboardPage extends StatelessWidget {
  const PlaygroundDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Design System Playground',
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
            Text('Components', style: AppTextStyle.headlineSmall.style),
            AppSpacing.md.gapV,
            _buildComponentsGrid(context),
            AppSpacing.xl.gapV,
            Text('Design Tokens', style: AppTextStyle.headlineSmall.style),
            AppSpacing.md.gapV,
            _buildTokensGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildComponentsGrid(BuildContext context) {
    return _buildResponsiveGrid(
      context: context,
      children: [
        ShowcaseCard(
          title: 'Bottom Bar',
          description:
              'Navigation bottom bars for switching between destinations',
          icon: Icons.navigation,
          onTap: () {
            print(
              'BottomBar card tapped - navigating to AppBottomBarShowcaseRoute',
            );
            context.pushRoute(const AppBottomBarShowcaseRoute());
          },
        ),
        ShowcaseCard(
          title: 'Bottom Sheet',
          description:
              'Modal bottom sheets with headers, actions, and responsive layouts',
          icon: Icons.vertical_align_bottom,
          onTap: () {
            print(
              'BottomSheet card tapped - navigating to BottomSheetShowcaseRoute',
            );
            context.pushRoute(const BottomSheetShowcaseRoute());
          },
        ),
        ShowcaseCard(
          title: 'Button',
          description: 'Interactive button components with various styles',
          icon: Icons.smart_button,
          onTap: () {
            print('Button card tapped - navigating to ButtonShowcaseRoute');
            context.pushRoute(const ButtonShowcaseRoute());
          },
        ),
        ShowcaseCard(
          title: 'Card',
          description: 'Container components with interactive variants',
          icon: Icons.credit_card,
          onTap: () {
            print('Card card tapped - navigating to CardShowcaseRoute');
            context.pushRoute(const CardShowcaseRoute());
          },
        ),
        ShowcaseCard(
          title: 'Dialog',
          description:
              'Modal dialogs with header, content, and responsive footer',
          icon: Icons.open_in_new,
          onTap: () {
            print('Dialog card tapped - navigating to DialogShowcaseRoute');
            context.pushRoute(const DialogShowcaseRoute());
          },
        ),
        ShowcaseCard(
          title: 'Divider',
          description:
              'Visual separators with multiple styles and gradient effects',
          icon: Icons.horizontal_rule,
          onTap: () {
            print('Divider card tapped - navigating to AppDividerShowcaseRoute');
            context.pushRoute(const AppDividerShowcaseRoute());
          },
        ),
        ShowcaseCard(
          title: 'Selectable Buttons',
          description:
              'Checkboxes, radio buttons, and toggle switches with consistent styling',
          icon: Icons.check_box,
          onTap: () {
            print('SelectableButtons card tapped - navigating to SelectableButtonsShowcaseRoute');
            context.pushRoute(const SelectableButtonsShowcaseRoute());
          },
        ),
        ShowcaseCard(
          title: 'Text Field',
          description: 'Input components with validation and specialized types',
          icon: Icons.text_fields,
          onTap: () {
            print(
              'TextField card tapped - navigating to AppTextFieldShowcaseRoute',
            );
            context.pushRoute(const AppTextFieldShowcaseRoute());
          },
        ),
        ShowcaseCard(
          title: 'Dropdown Button',
          description: 'Dropdown selection components with overlay behavior',
          icon: Icons.arrow_drop_down_circle,
          onTap: () {
            print(
              'DropdownButton card tapped - navigating to AppDropdownButtonShowcaseRoute',
            );
            context.pushRoute(const AppDropdownButtonShowcaseRoute());
          },
        ),
        ShowcaseCard(
          title: 'Wolt Modal',
          description: 'Advanced multi-page modals with smooth navigation and animations',
          icon: Icons.view_carousel,
          onTap: () {
            print(
              'WoltModal card tapped - navigating to WoltModalShowcaseRoute',
            );
            context.pushRoute(const WoltModalShowcaseRoute());
          },
        ),
        ShowcaseCard(
          title: 'Loading Indicator',
          description: 'Animated loading indicators with multiple animation variants',
          icon: Icons.refresh,
          onTap: () {
            print(
              'LoadingIndicator card tapped - navigating to AppLoadingIndicatorShowcaseRoute',
            );
            context.pushRoute(const AppLoadingIndicatorShowcaseRoute());
          },
        ),
        ShowcaseCard(
          title: 'Loading Overlay',
          description: 'Full-screen and modal loading overlays for blocking interactions',
          icon: Icons.layers,
          onTap: () {
            print(
              'LoadingOverlay card tapped - navigating to AppLoadingOverlayShowcaseRoute',
            );
            context.pushRoute(const AppLoadingOverlayShowcaseRoute());
          },
        ),
        ShowcaseCard(
          title: 'Progress Bar',
          description: 'Progress indicators with timer, linear, and stepped variants',
          icon: Icons.linear_scale,
          onTap: () {
            print(
              'ProgressBar card tapped - navigating to AppProgressBarShowcaseRoute',
            );
            context.pushRoute(const AppProgressBarShowcaseRoute());
          },
        ),
        ShowcaseCard(
          title: 'Skeleton Loader',
          description: 'Skeleton loading placeholders with shimmer animations',
          icon: Icons.view_headline,
          onTap: () {
            print(
              'SkeletonLoader card tapped - navigating to AppSkeletonLoaderShowcaseRoute',
            );
            context.pushRoute(const AppSkeletonLoaderShowcaseRoute());
          },
        ),
      ],
    );
  }

  Widget _buildTokensGrid(BuildContext context) {
    return _buildResponsiveGrid(
      context: context,
      children: [
        ShowcaseCard(
          title: 'Colors',
          description: 'Color palette and schemes',
          icon: Icons.palette,
          onTap: () {
            print('Colors card tapped - navigating to ColorsShowcaseRoute');
            context.pushRoute(const ColorsShowcaseRoute());
          },
        ),
        ShowcaseCard(
          title: 'Typography',
          description: 'Text styles and font scales',
          icon: Icons.text_format,
          onTap: () => context.pushRoute(const TypographyShowcaseRoute()),
        ),
        ShowcaseCard(
          title: 'Spacing',
          description: 'Padding and margin values',
          icon: Icons.space_bar,
          onTap: () => context.pushRoute(const SpacingShowcaseRoute()),
        ),
        ShowcaseCard(
          title: 'Shadows',
          description: 'Elevation and shadow styles',
          icon: Icons.layers,
          onTap: () => context.pushRoute(const ShadowsShowcaseRoute()),
        ),
        ShowcaseCard(
          title: 'Radius',
          description: 'Border radius values',
          icon: Icons.rounded_corner,
          onTap: () => context.pushRoute(const RadiusShowcaseRoute()),
        ),
      ],
    );
  }

  /// Builds a responsive grid that adapts column count based on screen width
  /// Cards have a maximum width to prevent them from becoming too wide
  /// Minimum 1 column, maximum 4 columns
  Widget _buildResponsiveGrid({
    required BuildContext context,
    required List<Widget> children,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Define card constraints
        const double minCardWidth = 280.0; // Minimum card width
        const double maxCardWidth = 350.0; // Maximum card width
        const int minColumns = 1;
        const int maxColumns = 4;

        // Calculate optimal number of columns
        final availableWidth = constraints.maxWidth;
        final spacingWidth = AppSpacing.md.value;

        // Calculate how many cards can fit with spacing
        int columns =
            ((availableWidth + spacingWidth) / (minCardWidth + spacingWidth))
                .floor();

        // Clamp columns to our min/max range
        columns = columns.clamp(minColumns, maxColumns);

        // Check if cards would be too wide with current column count
        final cardWidth =
            (availableWidth - (spacingWidth * (columns - 1))) / columns;
        if (cardWidth > maxCardWidth && columns < maxColumns) {
          columns++;
        }

        // Ensure we don't exceed our maximum columns
        columns = columns.clamp(minColumns, maxColumns);

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: columns,
          crossAxisSpacing: AppSpacing.md.value,
          mainAxisSpacing: AppSpacing.md.value,
          childAspectRatio: 1.2,
          children: children,
        );
      },
    );
  }
}
