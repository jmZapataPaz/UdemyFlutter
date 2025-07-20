import 'package:ecommerce_flutter/src/domain/models/Product.dart';

abstract class ShoppingBagRepository{

  Future<void>addProduct(Product product);
  Future<List<Product>>getProducts();
  Future<void>deleteitem(Product product);
  Future<void>deleteShoppingBag();

}