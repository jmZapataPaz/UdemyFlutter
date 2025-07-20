import 'package:ecommerce_flutter/src/domain/repository/shoppingBagRepository.dart';

class DeleteShoppingBagUseCase{
  ShoppingBagRepository shoppingBagRepository;

  DeleteShoppingBagUseCase(this.shoppingBagRepository);

  run() => shoppingBagRepository.deleteShoppingBag();
}