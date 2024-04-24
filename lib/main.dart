import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_clean_architecture/presentation/routes.dart';

import 'main_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    MainBindings().dependencies(),
  ]);
  runApp(GetMaterialApp(
    initialRoute: RouteName.login,
    getPages: RoutePages.pages,
  ));
}
