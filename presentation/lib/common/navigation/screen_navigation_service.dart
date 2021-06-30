import 'package:flutter/material.dart';
import 'package:presentation/common/navigation/routes.dart';
import 'package:presentation/common/navigation/screen_arguments.dart';
import 'package:presentation/features/product_detail/product_detail_screen.dart';
import 'package:presentation/features/product_list/product_list_screen.dart';
import 'package:presentation/features/product_detail/product_detail_screen_arg.dart';
class ScreenNavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _currentState => navigatorKey.currentState!;

  Future<T?> navigateTo<T extends Object>(Routes route,
      {ScreenArguments? arguments,Duration duration = const Duration(milliseconds: 300)}) {
    return _currentState.push(_buildRoute<T>(route, arguments: arguments,duration: duration));
  }

  bool canNavigateBack() {
    return _currentState.canPop();
  }

  void navigateBack<T extends Object>([T? result]) {
    if (_currentState.canPop()) {
      _currentState.pop(result);
    }
  }

  void navigateBackTo<T extends Object>(Routes route, [T? result]) {
    if (_currentState.canPop()) {
      _currentState.popUntil((route) {
        return route.settings.name == route.toString() ||
            route.settings.name == Routes.product_list.toString();
      });
    }
  }

  Future<T?> replaceWithRoute<T extends Object>(Routes route,
      {ScreenArguments? arguments, T? result,Duration duration = const Duration(milliseconds: 300)}) {
    return _currentState
        .pushReplacement(_buildRoute(route, arguments: arguments,duration: duration));
  }

  Future<T?> replaceEntireStackWithRoute<T extends Object>(Routes route) {
    return _currentState.pushAndRemoveUntil(_buildRoute(route), (_) => false);
  }

  PageRoute<T> _buildRoute<T>(Routes route,
      {ScreenArguments? arguments, Duration duration = const Duration(milliseconds: 300)}) {
    final destination = getScreenByRoute(route, arguments: arguments);

    return PageRouteBuilder(
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      pageBuilder: (context,animation , second) => destination,
      settings: RouteSettings(name: route.toString()),
    );
  }

  Widget getScreenByRoute(Routes route, {ScreenArguments? arguments}) {
    // Order by alphabet
    switch (route) {
      case Routes.product_list:
        return ProductListScreen();
      case Routes.product_detail:
        return ProductDetailScreen(args: arguments as ProductDetailScreenArg,);
    }
  }
}

class CustomTransitionPageRoute<T> extends MaterialPageRoute<T> {
  CustomTransitionPageRoute({
    required WidgetBuilder builder,
    required RouteSettings settings,
  }) : super(builder: builder, settings: settings);

}
