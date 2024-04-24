import 'package:flutter_clean_architecture/domain/models/product/product_item.dart';

abstract class ProductRepository {
  Future<List<ProductItem>> fetchProductItems(int page, int limit);
}