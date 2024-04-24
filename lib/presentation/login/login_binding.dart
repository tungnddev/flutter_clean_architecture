import 'package:get/get.dart';
import 'package:flutter_clean_architecture/domain/repositories/auth_repository.dart';
import 'package:flutter_clean_architecture/domain/use_cases/login_use_case.dart';

import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.put(LoginUseCase(Get.find<AuthRepository>()));
  }
}
