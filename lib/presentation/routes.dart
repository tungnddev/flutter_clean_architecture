import 'package:get/get.dart';
import 'package:flutter_clean_architecture/presentation/login/login_binding.dart';
import 'package:flutter_clean_architecture/presentation/login/login_screen.dart';

import 'home/home_binding.dart';
import 'home/home_screen.dart';

class RouteName {
  static const home = '/';
  static const login = '/login';
}

class RoutePages {
  static final pages = [
    GetPage(
        name: RouteName.home,
        page: () => const HomeScreen(),
        binding: HomeBinding()),
    GetPage(
        name: RouteName.login,
        page: () => const LoginScreen(),
        binding: LoginBinding()),
  ];
}
