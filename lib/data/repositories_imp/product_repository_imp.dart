import 'package:flutter_clean_architecture/domain/models/product/product_item.dart';
import 'package:flutter_clean_architecture/domain/repositories/product_repository.dart';

import '../local/local_service.dart';
import '../remote/mappers/product_mapper.dart';
import '../remote/client/product_client.dart';
import 'exception_mapper.dart';

class ProductRepositoryImp extends ProductRepository with ExceptionMapper {
  LocalService localService;
  ProductClient client;
  ProductMapper mapper;

  ProductRepositoryImp(this.client, this.localService, this.mapper);

  @override
  Future<List<ProductItem>> fetchProductItems(int page, int limit) async {
    try {
      final response = await client.fetchProductItems(page, limit);
      return response.data?.map((e) => mapper.mapProductItem(e)).toList() ?? [];
    } catch (e) {
      throw mapException(e);
    }
  }
}
