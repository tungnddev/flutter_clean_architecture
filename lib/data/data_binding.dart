import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter_clean_architecture/data/data.dart';
import 'package:flutter_clean_architecture/data/local/get_storage_imp.dart';
import 'package:flutter_clean_architecture/data/local/local_service.dart';
import 'package:flutter_clean_architecture/data/remote/client/auth_client.dart';
import 'package:flutter_clean_architecture/data/remote/client/product_client.dart';
import 'package:flutter_clean_architecture/data/remote/mappers/product_mapper.dart';
import 'package:flutter_clean_architecture/data/repositories_imp/auth_repository_imp.dart';
import 'package:flutter_clean_architecture/data/repositories_imp/product_repository_imp.dart';
import 'package:flutter_clean_architecture/domain/repositories/auth_repository.dart';
import 'package:flutter_clean_architecture/domain/repositories/product_repository.dart';

class DataBinding extends Bindings {
  @override
  Future dependencies() async {
    Get.put(BaseOptions(
        baseUrl:
            "https://bbdd19e4-7ba1-4d22-8960-d3f6cf8b2e29.mock.pstmn.io/api/"));
    Get.put(Dio(Get.find<BaseOptions>()));
    Get.put<LocalService>(GetStorageImp());
    await Get.find<LocalService>().initialize();

    // auth
    Get.put(AuthClient(Get.find<Dio>()));
    Get.put<AuthRepository>(
        AuthRepositoryImp(Get.find<LocalService>(), Get.find<AuthClient>()));

    Get.put<AuthInterceptor>(
        AuthInterceptor(Get.find<Dio>(), Get.find<AuthRepository>()));

    Get.find<Dio>().interceptors.add(Get.find<AuthInterceptor>());
    if (kDebugMode) {
      Get.find<Dio>().interceptors.add(LogInterceptor(requestBody: true));
    }

    // product
    Get.put(ProductClient(Get.find<Dio>()));
    Get.put<ProductRepository>(ProductRepositoryImp(
        Get.find<ProductClient>(), Get.find<LocalService>(), ProductMapper()));
  }
}
