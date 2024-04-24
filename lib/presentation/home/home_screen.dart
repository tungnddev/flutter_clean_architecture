import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_clean_architecture/domain/models/product/product_item.dart';

import '../base/base_screen.dart';
import '../ui/list_view/list_view_load_more.dart';
import 'home_controller.dart';

class HomeScreen extends BaseScreen<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget successView(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (HomeController controller) {
        return ListViewLoadMore<ProductItem>(
          itemBuilder: (ProductItem item, int index) {
            return _buildItem(context, item);
          },
          onLoadMore: () => controller.loadMore(),
          list: controller.items,
          canLoadMore: controller.canLoadMore,
          onRefresh: () => controller.fetchNewData(),
        );
      },
    );
  }

  Widget _buildItem(BuildContext context, ProductItem item) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 19),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              "id: ${item.id}",
              style:
                  Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16),
            ),
          ],
        ));
  }
}
