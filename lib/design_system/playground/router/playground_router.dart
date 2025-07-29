import 'package:auto_route/auto_route.dart';

import '../../components/app_bottom_bar/app_bottom_bar_showcase_page.dart';
import '../../components/app_bottom_sheet/app_bottom_sheet_showcase_page.dart';
import '../../components/app_button/app_button_showcase_page.dart';
import '../../components/app_card/app_card_showcase_page.dart';
import '../../components/app_dialog/app_dialog_showcase_page.dart';
import '../../components/app_divider/app_divider_showcase_page.dart';
import '../../components/app_dropdown_button/app_dropdown_button_showcase_page.dart';
import '../../components/app_loading_indicator/app_loading_indicator_showcase_page.dart';
import '../../components/app_selectable_buttons/app_selectable_buttons_showcase_page.dart';
import '../../components/app_loading_overlay/app_loading_overlay_showcase_page.dart';
import '../../components/app_progress_bar/app_progress_bar_showcase_page.dart';
import '../../components/app_skeleton_loader/app_skeleton_loader_showcase_page.dart';
import '../../components/app_text_field/app_text_field_showcase_page.dart';
import '../../components/app_wolt_modal/app_wolt_modal_showcase_page.dart';
import '../pages/dashboard_page.dart';
import '../pages/tokens/colors_showcase_page.dart';
import '../pages/tokens/radius_showcase_page.dart';
import '../pages/tokens/shadows_showcase_page.dart';
import '../pages/tokens/spacing_showcase_page.dart';
import '../pages/tokens/typography_showcase_page.dart';

part 'playground_router.gr.dart';

@AutoRouterConfig()
class PlaygroundRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> routes = [
    // Dashboard route
    AutoRoute(page: PlaygroundDashboardRoute.page, path: '/', initial: true),

    // Component routes
    AutoRoute(
      page: AppBottomBarShowcaseRoute.page,
      path: '/components/bottom-bar',
    ),
    AutoRoute(
      page: BottomSheetShowcaseRoute.page,
      path: '/components/bottom-sheet',
    ),
    AutoRoute(page: ButtonShowcaseRoute.page, path: '/components/button'),
    AutoRoute(page: CardShowcaseRoute.page, path: '/components/card'),
    AutoRoute(page: DialogShowcaseRoute.page, path: '/components/dialog'),
    AutoRoute(
      page: AppDividerShowcaseRoute.page,
      path: '/components/divider',
    ),
    AutoRoute(
      page: SelectableButtonsShowcaseRoute.page,
      path: '/components/selectable-buttons',
    ),
    AutoRoute(
      page: AppLoadingIndicatorShowcaseRoute.page,
      path: '/components/loading-indicator',
    ),
    AutoRoute(
      page: AppLoadingOverlayShowcaseRoute.page,
      path: '/components/loading-overlay',
    ),
    AutoRoute(
      page: AppProgressBarShowcaseRoute.page,
      path: '/components/progress-bar',
    ),
    AutoRoute(
      page: AppSkeletonLoaderShowcaseRoute.page,
      path: '/components/skeleton-loader',
    ),
    AutoRoute(
      page: AppTextFieldShowcaseRoute.page,
      path: '/components/text-field',
    ),
    AutoRoute(
      page: AppDropdownButtonShowcaseRoute.page,
      path: '/components/dropdown-button',
    ),
    AutoRoute(
      page: WoltModalShowcaseRoute.page,
      path: '/components/wolt-modal',
    ),

    // Token routes
    AutoRoute(page: ColorsShowcaseRoute.page, path: '/tokens/colors'),
    AutoRoute(page: TypographyShowcaseRoute.page, path: '/tokens/typography'),
    AutoRoute(page: SpacingShowcaseRoute.page, path: '/tokens/spacing'),
    AutoRoute(page: ShadowsShowcaseRoute.page, path: '/tokens/shadows'),
    AutoRoute(page: RadiusShowcaseRoute.page, path: '/tokens/radius'),
  ];
}
