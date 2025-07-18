import 'dart:io';
import 'package:ecommerce_flutter/src/domain/models/Category.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';

abstract class CategoryRepository {
  Future<Resource<Category>> create(Category category, File? file);
  Future<Resource<List<Category>>> getAll();
  Future<Resource<Category>> updateCategory(int id, Category category, File? file);
  Future<Resource<bool>> deleteCategory(int id);
}