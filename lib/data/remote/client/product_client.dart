import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:flutter_clean_architecture/data/models/product/product.dart';

import '../../models/models.dart';

part 'product_client.g.dart';

@RestApi()
abstract class ProductClient {
  factory ProductClient(Dio dio, {String baseUrl}) = _ProductClient;

  @GET('/product')
  Future<BaseResponse<List<ProductItemModel>>> fetchProductItems(
      @Query("page") int page, @Query("limit") int limit);
}
