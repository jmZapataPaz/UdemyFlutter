import 'package:ecommerce_flutter/src/domain/useCases/products/CreateProductUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/products/GetProductByCategoryUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/products/UpdateProductUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/products/DeleteProductUseCase.dart';


class ProductUseCase{

  CreateProductUseCase createProductUseCase;
  GetProductByCategoryUseCase getProductByCategoryUseCase;
  UpdateProductUseCase updateProductUseCase;
  DeleteProductUseCase deleteProductUseCase;
  ProductUseCase({
    required this.createProductUseCase,
    required this.getProductByCategoryUseCase,
    required this.updateProductUseCase,
    required this.deleteProductUseCase,
  });


}