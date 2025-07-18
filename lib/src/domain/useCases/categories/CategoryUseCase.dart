import 'package:ecommerce_flutter/src/domain/useCases/categories/CreateCategoryUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/categories/DeleteCategoryUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/categories/GetCategoryUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/categories/UpdateCategoryUseCase.dart';

class CategoryUseCase{

  CreateCategoryUseCase createCategoryUseCase;
  UpdateCategoryUseCase updateCategoryUseCase;
  DeleteCategoryUseCase deleteCategoryUsecase;

  GetCategoryUseCase getCategoryUseCase;
  CategoryUseCase({
    required this.createCategoryUseCase,
    required this.getCategoryUseCase,
    required this.updateCategoryUseCase,
    required this.deleteCategoryUsecase,
  });
} 