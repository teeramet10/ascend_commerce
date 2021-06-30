import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/common/navigation/screen_navigation_service.dart';
import 'app.dart';
import 'package:presentation/di/injection_container.dart' as di;

void main() async{
  await di.init();
  runApp(App());
}
