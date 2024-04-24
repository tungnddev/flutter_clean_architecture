import 'package:flutter_clean_architecture/domain/models/product/product_item.dart';
import 'package:flutter_clean_architecture/domain/repositories/product_repository.dart';

import '../models/exceptions/exceptions.dart';
import '../utils/either.dart';

class HomeProductUseCase {
  final ProductRepository _productRepository;

  HomeProductUseCase(this._productRepository);

  Future<Either<List<ProductItem>, AppException>> execute(
      int page, int limit) async {
    try {
      final result = await _productRepository.fetchProductItems(page, limit);
      return Left(result);
    } on AppException catch (e) {
      return Right(e);
    }
  }
}
