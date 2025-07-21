import 'package:ecommerce_flutter/src/domain/useCases/shoppingBag/AddShoppingBagUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/shoppingBag/DeleteItemShoppingBagUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/shoppingBag/DeleteShoppingBagUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/shoppingBag/GetProductShoppingBagUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/shoppingBag/GetTotalShoppingBagUseCase.dart';

class ShoppingBagUseCases{
  AddShoppingBagUseCase addShoppingBagUseCase;
  GetProductShoppingBagUseCase getProductShoppingBagUseCase;
  DeleteItemShoppingBagUseCase deleteItemShoppingBagUseCase;
  DeleteShoppingBagUseCase deleteShoppingBagUseCase;
  GetTotalShoppingBagUseCase getTotalShoppingBagUseCase;

  ShoppingBagUseCases({
    required this.addShoppingBagUseCase,
    required this.getProductShoppingBagUseCase,
    required this.deleteItemShoppingBagUseCase,
    required this.deleteShoppingBagUseCase,
    required this.getTotalShoppingBagUseCase,
  });

}