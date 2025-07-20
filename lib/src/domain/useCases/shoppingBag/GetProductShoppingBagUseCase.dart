import 'package:ecommerce_flutter/src/domain/repository/shoppingBagRepository.dart';

class GetProductShoppingBagUseCase {
  ShoppingBagRepository shoppingBagRepository;
  GetProductShoppingBagUseCase(this.shoppingBagRepository);

  run() => shoppingBagRepository.getProducts();
}