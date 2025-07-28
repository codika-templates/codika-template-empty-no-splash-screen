import 'package:auto_route/auto_route.dart';

import '../../components/app_bottom_bar/app_bottom_bar_showcase_page.dart';
import '../../components/app_button/app_button_showcase_page.dart';
import '../../components/app_card/app_card_showcase_page.dart';
import '../../components/app_dialog/app_dialog_showcase_page.dart';
import '../../components/app_text_field/app_text_field_showcase_page.dart';
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
    AutoRoute(page: ButtonShowcaseRoute.page, path: '/components/button'),
    AutoRoute(page: CardShowcaseRoute.page, path: '/components/card'),
    AutoRoute(page: DialogShowcaseRoute.page, path: '/components/dialog'),
    AutoRoute(
      page: AppTextFieldShowcaseRoute.page,
      path: '/components/text-field',
    ),

    // Token routes
    AutoRoute(page: ColorsShowcaseRoute.page, path: '/tokens/colors'),
    AutoRoute(page: TypographyShowcaseRoute.page, path: '/tokens/typography'),
    AutoRoute(page: SpacingShowcaseRoute.page, path: '/tokens/spacing'),
    AutoRoute(page: ShadowsShowcaseRoute.page, path: '/tokens/shadows'),
    AutoRoute(page: RadiusShowcaseRoute.page, path: '/tokens/radius'),
  ];
}
