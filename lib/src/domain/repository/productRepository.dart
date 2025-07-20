import 'dart:io';
import 'package:ecommerce_flutter/src/domain/models/Product.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';

abstract class ProductRepository{

  Future<Resource<Product>> createProduct(Product product, List<File> files);
  Future<Resource<List<Product>>> getProductsByCategory(int id_category);
  Future<Resource<Product>>updateProductById(int id, Product product, List<File> files, List<int>? imagesToUpdate);
  Future<Resource<bool>>deleteProduct(int id);
}