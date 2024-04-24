import 'package:get/get.dart';
import 'package:flutter_clean_architecture/domain/models/exceptions/exceptions.dart';
import 'package:flutter_clean_architecture/domain/use_cases/login_use_case.dart';
import 'package:flutter_clean_architecture/domain/utils/either.dart';
import 'package:flutter_clean_architecture/presentation/login/models/field_vm.dart';
import 'package:flutter_clean_architecture/presentation/routes.dart';

import '../base/base_controller.dart';

class LoginController extends BaseController {
  final Rx<FieldVM> username = FieldVM("").obs;
  final Rx<FieldVM> password = FieldVM("").obs;

  bool get isValid =>
      username.value.validate() == null && password.value.validate() == null;

  @override
  void onInit() {
    super.onInit();
  }

  void changePassword(String password) {
    this.password.update((val) {
      val?.content = password;
    });
  }

  void changeUsername(String username) {
    this.username.update((val) {
      val?.content = username;
    });
  }

  void startLogin() async {
    showLoadingDialog();
    final Either<void, AppException> result = await Get.find<LoginUseCase>()
        .execute(username.value.content, password.value.content);
    hideLoadingDialog();
    result.fold((left) {
      Get.offNamed(RouteName.home);
    }, (right) {
      showError(right);
      return;
    });
  }
}
