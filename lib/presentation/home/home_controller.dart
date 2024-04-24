import 'package:get/get.dart';
import 'package:flutter_clean_architecture/domain/models/product/product_item.dart';
import 'package:flutter_clean_architecture/domain/use_cases/home_product_use_case.dart';

import '../base/base_controller.dart';
import '../base/base_view_status.dart';

class HomeController extends BaseController {
  List<ProductItem> items = <ProductItem>[];
  bool canLoadMore = true;

  final limit = 10;
  int currentPage = 1;

  @override
  void onInit() {
    super.onInit();
    fetchNewData();
  }

  void fetchNewData() async {
    items.clear();
    currentPage = 1;
    canLoadMore = true;
    viewStatus.value = BaseViewStatus.loading;
    await fetchData();
    viewStatus.value = BaseViewStatus.success;
  }

  void loadMore() async {
    currentPage++;
    await fetchData();
  }

  Future<void> fetchData() async {
    final result =
        await Get.find<HomeProductUseCase>().execute(currentPage, limit);
    result.fold((left) {
      canLoadMore = left.length == limit;
      items.addAll(left);
      update();
    }, (right) {
      showError(right);
    });
  }
}
