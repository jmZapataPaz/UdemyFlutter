import 'dart:io';
import 'package:ecommerce_flutter/src/data/dataSource/remote/Services/CategoryService.dart';
import 'package:ecommerce_flutter/src/domain/models/Category.dart';
import 'package:ecommerce_flutter/src/domain/repository/categoryRepository.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';

class CategoryRepositoryIMP implements CategoryRepository {
  
  CategoryService categoryService;
  CategoryRepositoryIMP(this.categoryService);

  @override
  Future<Resource<Category>> create(Category category, File? file) {
    return categoryService.create(category, file);
  }
  
  @override
  Future<Resource<List<Category>>> getAll() {
    return categoryService.getAll();
  }
  
  @override
  Future<Resource<Category>> updateCategory(int id, Category category, File? file) {
    return categoryService.updateCategory(id, category, file);
  }
  
  @override
  Future<Resource<bool>> deleteCategory(int id) {
    return categoryService.deleteCategory(id);
  }
  

}