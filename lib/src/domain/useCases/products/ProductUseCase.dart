import 'package:ecommerce_flutter/src/domain/useCases/products/CreateProductUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/products/GetProductByCategoryUseCase.dart';

class ProductUseCase{

  CreateProductUseCase createProductUseCase;
  GetProductByCategoryUseCase getProductByCategoryUseCase;
  ProductUseCase({
    required this.createProductUseCase,
    required this.getProductByCategoryUseCase,
  });


}