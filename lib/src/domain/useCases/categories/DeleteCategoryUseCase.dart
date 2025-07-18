import 'package:ecommerce_flutter/src/domain/repository/categoryRepository.dart';

class DeleteCategoryUseCase {

  CategoryRepository  categoryRepository;

  DeleteCategoryUseCase(this.categoryRepository);
  run(int id) {
    return categoryRepository.deleteCategory(id);
  }
}