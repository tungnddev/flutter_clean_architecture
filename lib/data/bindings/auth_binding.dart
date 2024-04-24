import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../domain/repositories/auth_repository.dart';
import '../local/local_service.dart';
import '../remote/client/auth_client.dart';
import '../remote/interceptors/auth_interceptor.dart';
import '../repositories_imp/auth_repository_imp.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthClient(Get.find<Dio>()));
    Get.put<AuthRepository>(
        AuthRepositoryImp(Get.find<LocalService>(), Get.find<AuthClient>()));

    Get.put<AuthInterceptor>(
        AuthInterceptor(Get.find<Dio>(), Get.find<AuthRepository>()));

    Get.find<Dio>().interceptors.add(Get.find<AuthInterceptor>());
  }
}
