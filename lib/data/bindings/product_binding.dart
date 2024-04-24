import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../domain/repositories/product_repository.dart';
import '../local/local_service.dart';
import '../remote/client/product_client.dart';
import '../remote/mappers/product_mapper.dart';
import '../repositories_imp/product_repository_imp.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductClient(Get.find<Dio>()));
    Get.put<ProductRepository>(ProductRepositoryImp(
        Get.find<ProductClient>(), Get.find<LocalService>(), ProductMapper()));
  }
}
