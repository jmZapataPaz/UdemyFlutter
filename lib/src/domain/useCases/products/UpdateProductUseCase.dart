import 'dart:io';
import 'package:ecommerce_flutter/src/domain/models/Product.dart';
import 'package:ecommerce_flutter/src/domain/repository/productRepository.dart';

class UpdateProductUseCase{
  ProductRepository productRepository;
  UpdateProductUseCase(this.productRepository);

  run(int id, Product product, List<File>? files, List<int>? imagesToUpdate) {
    return productRepository.updateProductById(id, product, files ?? [], imagesToUpdate);
  }
}