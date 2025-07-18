import 'package:ecommerce_flutter/src/domain/models/Category.dart';
import 'package:ecommerce_flutter/src/domain/repository/categoryRepository.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';

class GetCategoryUseCase {
  CategoryRepository categoryRepository;
  GetCategoryUseCase(this.categoryRepository);

  Future<Resource<List<Category>>> run() {
    return categoryRepository.getAll();
  }
}