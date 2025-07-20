import 'package:ecommerce_flutter/src/domain/models/Product.dart';
import 'package:ecommerce_flutter/src/domain/repository/shoppingBagRepository.dart';

class AddShoppingBagUseCase{
  ShoppingBagRepository shoppingBagRepository;
  AddShoppingBagUseCase(this.shoppingBagRepository);

  run(Product product)  {
    shoppingBagRepository.addProduct(product);
  }
}