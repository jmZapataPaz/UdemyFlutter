import 'dart:io';
import 'package:ecommerce_flutter/src/domain/models/Category.dart';
import 'package:ecommerce_flutter/src/domain/repository/categoryRepository.dart';

class CreateCategoryUseCase {
  CategoryRepository categoryRepository;

  CreateCategoryUseCase(this.categoryRepository);

  run(Category category, File? file) {
    return categoryRepository.create(category, file);
  }
}
