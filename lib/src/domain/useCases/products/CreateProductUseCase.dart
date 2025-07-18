import 'dart:io';
import 'package:ecommerce_flutter/src/domain/models/Product.dart';
import 'package:ecommerce_flutter/src/domain/repository/productRepository.dart';

class CreateProductUseCase{
  ProductRepository productRepository;
  CreateProductUseCase(this.productRepository);

  run(Product product, List<File> files) {
    return productRepository.createProduct(product, files);
  }
}