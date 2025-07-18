import 'package:ecommerce_flutter/src/domain/repository/productRepository.dart';

class GetProductByCategoryUseCase{

  ProductRepository productRepository;
  GetProductByCategoryUseCase(this.productRepository);

  run (int id_category) {
    return productRepository.getProductsByCategory(id_category);
  }

}