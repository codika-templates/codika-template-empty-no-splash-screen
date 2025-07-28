import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../tokens/app_density.dart';
import '../../tokens/app_radius.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';
import '../showcase_card.dart';
import 'app_bottom_bar.dart';

@RoutePage()
class AppBottomBarShowcasePage extends StatefulWidget {
  const AppBottomBarShowcasePage({super.key});

  @override
  State<AppBottomBarShowcasePage> createState() =>
      _AppBottomBarShowcasePageState();
}

class _AppBottomBarShowcasePageState extends State<AppBottomBarShowcasePage> {
  int _standardIndex = 0;
  int _floatingIndex = 1;
  int _notchedIndex = 2;
  int _compactIndex = 0;

  final List<AppBottomBarItem> _basicItems = [
    const AppBottomBarItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
    ),
    const AppBottomBarItem(
      icon: Icons.search_outlined,
      activeIcon: Icons.search,
      label: 'Search',
    ),
    const AppBottomBarItem(
      icon: Icons.favorite_border,
      activeIcon: Icons.favorite,
      label: 'Favorites',
    ),
    const AppBottomBarItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profile',
    ),
  ];

  final List<AppBottomBarItem> _itemsWithBadges = [
    const AppBottomBarItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
    ),
    AppBottomBarItem(
      icon: Icons.chat_bubble_outline,
      activeIcon: Icons.chat_bubble,
      label: 'Messages',
      badge: const Text('3'),
    ),
    AppBottomBarItem(
      icon: Icons.notifications_outlined,
      activeIcon: Icons.notifications,
      label: 'Notifications',
      badge: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    ),
    const AppBottomBarItem(
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings,
      label: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBottomBar', style: AppTextStyle.headlineMedium.style),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.lg.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Navigation bottom bars for switching between primary destinations',
              style: AppTextStyle.bodyLarge.style.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),

            AppSpacing.xl.gapV,

            // Basic Variants Section
            _buildSection(
              title: 'Variants',
              description: 'Different styles for various use cases',
              children: [
                ShowcaseCard(
                  title: 'Standard',
                  description: 'Default bottom navigation bar',
                  child: _buildPreviewContainer(
                    AppBottomBar.standard(
                      items: _basicItems,
                      currentIndex: _standardIndex,
                      onTap: (index) => setState(() => _standardIndex = index),
                    ),
                  ),
                ),
                ShowcaseCard(
                  title: 'Floating',
                  description: 'Elevated bottom bar with rounded corners',
                  child: _buildPreviewContainer(
                    AppBottomBar.floating(
                      items: _basicItems,
                      currentIndex: _floatingIndex,
                      onTap: (index) => setState(() => _floatingIndex = index),
                      margin: AppSpacing.md.padding,
                    ),
                  ),
                ),
                ShowcaseCard(
                  title: 'Notched',
                  description: 'Bottom bar designed to work with FAB',
                  child: _buildPreviewContainer(
                    AppBottomBar.notched(
                      items: _basicItems,
                      currentIndex: _notchedIndex,
                      onTap: (index) => setState(() => _notchedIndex = index),
                    ),
                    showFab: true,
                  ),
                ),
                ShowcaseCard(
                  title: 'Compact',
                  description: 'Icon-only navigation without labels',
                  child: _buildPreviewContainer(
                    AppBottomBar.compact(
                      items: _basicItems,
                      currentIndex: _compactIndex,
                      onTap: (index) => setState(() => _compactIndex = index),
                    ),
                  ),
                ),
              ],
            ),

            // Sizes Section
            _buildSection(
              title: 'Sizes',
              description: 'Different size variants',
              children: [
                ShowcaseCard(
                  title: 'Compact Size',
                  description: 'Smaller icons and text',
                  child: _buildPreviewContainer(
                    AppBottomBar.standard(
                      items: _basicItems,
                      currentIndex: 0,
                      size: AppBottomBarSize.compact,
                      onTap: (index) {},
                    ),
                  ),
                ),
                ShowcaseCard(
                  title: 'Standard Size',
                  description: 'Default size',
                  child: _buildPreviewContainer(
                    AppBottomBar.standard(
                      items: _basicItems,
                      currentIndex: 0,
                      size: AppBottomBarSize.standard,
                      onTap: (index) {},
                    ),
                  ),
                ),
                ShowcaseCard(
                  title: 'Comfortable Size',
                  description: 'Larger icons and text for better accessibility',
                  child: _buildPreviewContainer(
                    AppBottomBar.standard(
                      items: _basicItems,
                      currentIndex: 0,
                      size: AppBottomBarSize.comfortable,
                      onTap: (index) {},
                    ),
                  ),
                ),
              ],
            ),

            // Special Features Section
            _buildSection(
              title: 'Special Features',
              description: 'Advanced functionality and customizations',
              children: [
                ShowcaseCard(
                  title: 'With Badges',
                  description: 'Items with notification badges',
                  child: _buildPreviewContainer(
                    AppBottomBar.standard(
                      items: _itemsWithBadges,
                      currentIndex: 1,
                      onTap: (index) {},
                    ),
                  ),
                ),
                ShowcaseCard(
                  title: 'Custom Colors',
                  description: 'Bottom bar with custom background',
                  child: _buildPreviewContainer(
                    AppBottomBar.standard(
                      items: _basicItems,
                      currentIndex: 2,
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      onTap: (index) {},
                    ),
                  ),
                ),
                ShowcaseCard(
                  title: 'No Unselected Labels',
                  description: 'Hide labels for unselected items',
                  child: _buildPreviewContainer(
                    AppBottomBar.standard(
                      items: _basicItems,
                      currentIndex: 1,
                      showUnselectedLabels: false,
                      onTap: (index) {},
                    ),
                  ),
                ),
                ShowcaseCard(
                  title: 'High Density',
                  description: 'Compact spacing for dense layouts',
                  child: _buildPreviewContainer(
                    AppBottomBar.standard(
                      items: _basicItems,
                      currentIndex: 3,
                      density: AppDensity.compact,
                      onTap: (index) {},
                    ),
                  ),
                ),
              ],
            ),

            // Real App Example Section
            _buildSection(
              title: 'Real App Examples',
              description: 'Bottom bars in realistic app contexts',
              children: [
                ShowcaseCard(
                  title: 'E-commerce App',
                  description: 'Typical shopping app navigation',
                  child: _buildPreviewContainer(
                    AppBottomBar.standard(
                      items: const [
                        AppBottomBarItem(
                          icon: Icons.storefront_outlined,
                          activeIcon: Icons.storefront,
                          label: 'Shop',
                        ),
                        AppBottomBarItem(
                          icon: Icons.category_outlined,
                          activeIcon: Icons.category,
                          label: 'Categories',
                        ),
                        AppBottomBarItem(
                          icon: Icons.shopping_cart_outlined,
                          activeIcon: Icons.shopping_cart,
                          label: 'Cart',
                        ),
                        AppBottomBarItem(
                          icon: Icons.account_circle_outlined,
                          activeIcon: Icons.account_circle,
                          label: 'Account',
                        ),
                      ],
                      currentIndex: 0,
                      onTap: (index) {},
                    ),
                  ),
                ),
                ShowcaseCard(
                  title: 'Social Media App',
                  description: 'Social app with message badges',
                  child: _buildPreviewContainer(
                    AppBottomBar.floating(
                      items: [
                        const AppBottomBarItem(
                          icon: Icons.home_outlined,
                          activeIcon: Icons.home,
                          label: 'Feed',
                        ),
                        const AppBottomBarItem(
                          icon: Icons.explore_outlined,
                          activeIcon: Icons.explore,
                          label: 'Explore',
                        ),
                        AppBottomBarItem(
                          icon: Icons.chat_outlined,
                          activeIcon: Icons.chat,
                          label: 'Messages',
                          badge: const Text('5'),
                        ),
                        const AppBottomBarItem(
                          icon: Icons.person_outline,
                          activeIcon: Icons.person,
                          label: 'Profile',
                        ),
                      ],
                      currentIndex: 2,
                      onTap: (index) {},
                    ),
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String description,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.headlineSmall.style),
        AppSpacing.xs.gapV,
        Text(
          description,
          style: AppTextStyle.bodyMedium.style.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        AppSpacing.lg.gapV,
        ...children.map(
          (child) => Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.md.value),
            child: child,
          ),
        ),
        AppSpacing.xl.gapV,
      ],
    );
  }

  Widget _buildPreviewContainer(Widget bottomBar, {bool showFab = false}) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
        borderRadius: AppRadius.md.borderRadius,
      ),
      child: Stack(
        children: [
          // Mock screen content
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone_android,
                    size: 48,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  AppSpacing.sm.gapV,
                  Text(
                    'App Screen Preview',
                    style: AppTextStyle.bodyMedium.style.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom bar
          Positioned(bottom: 0, left: 0, right: 0, child: bottomBar),
          // FAB if needed
          if (showFab)
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: () {},
                mini: true,
                child: const Icon(Icons.add),
              ),
            ),
        ],
      ),
    );
  }
}
