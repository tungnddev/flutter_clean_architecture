import 'package:flutter_clean_architecture/data/models/product/product.dart';
import 'package:flutter_clean_architecture/domain/models/product/product_item.dart';

class ProductMapper {
  ProductItem mapProductItem(ProductItemModel? model) {
    return ProductItem(id: model?.id ?? 0, name: model?.name ?? "");
  }
}
