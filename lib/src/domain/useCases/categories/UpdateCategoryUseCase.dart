import 'dart:io';
import 'package:ecommerce_flutter/src/domain/models/Category.dart';
import 'package:ecommerce_flutter/src/domain/repository/categoryRepository.dart';

class UpdateCategoryUseCase {
  CategoryRepository categoryRepository;

  UpdateCategoryUseCase(this.categoryRepository);

  run(int id, Category category, File? file) {
    return categoryRepository.updateCategory(id, category, file);
  }
}