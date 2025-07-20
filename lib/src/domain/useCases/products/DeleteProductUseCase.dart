import 'package:ecommerce_flutter/src/domain/repository/productRepository.dart';

class DeleteProductUseCase{

  ProductRepository productRepository;

  DeleteProductUseCase(this.productRepository);

  run(int id) => productRepository.deleteProduct(id);
}