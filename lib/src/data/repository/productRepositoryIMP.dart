import 'dart:io';
import 'package:ecommerce_flutter/src/data/dataSource/remote/Services/ProductService.dart';
import 'package:ecommerce_flutter/src/domain/models/Product.dart';
import 'package:ecommerce_flutter/src/domain/repository/productRepository.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';

class ProductRepositoryIMP implements ProductRepository {

  ProductService productService;
  ProductRepositoryIMP(this.productService);

  
  @override
  Future<Resource<Product>> createProduct(Product product, List<File> files) {
    return productService.createProduct(product, files);
  }
  
  @override
  Future<Resource<List<Product>>> getProductsByCategory(int id_category) {
    return productService.getProductsByCategoryt(id_category);
  }
  
  @override
  Future<Resource<Product>> updateProductById(int id, Product product, List<File>? files, List<int>? imagesToUpdate) {
  if(files != null && imagesToUpdate != null) {
    return productService.updateProductById(id, product, files, imagesToUpdate);
  } else{
    return productService.updateProductById(id, product, [], null);
  }
}

  @override
  Future<Resource<bool>> deleteProduct(int id) {
    return productService.deleteProduct(id);
  }


}