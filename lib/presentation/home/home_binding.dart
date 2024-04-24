import 'package:get/get.dart';
import 'package:flutter_clean_architecture/domain/repositories/product_repository.dart';
import 'package:flutter_clean_architecture/domain/use_cases/home_product_use_case.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.put(HomeProductUseCase(Get.find<ProductRepository>()));
  }

}