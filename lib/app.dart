import 'dart:async';

import 'package:ascend_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/app_theme.dart';
import 'package:presentation/common/navigation/routes.dart';
import 'package:presentation/common/navigation/screen_navigation_service.dart';
import 'package:presentation/di/injection_container.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: sl<ScreenNavigationService>().navigatorKey,
        theme: AppTheme.lightTheme,
        home: sl<ScreenNavigationService>()
            .getScreenByRoute(Routes.product_list));
  }
}
