import 'dart:convert';
import 'package:ecommerce_flutter/src/data/dataSource/local/sharedPref.dart';
import 'package:ecommerce_flutter/src/domain/models/Product.dart';
import 'package:ecommerce_flutter/src/domain/repository/shoppingBagRepository.dart';

class ShoppingBagRepositoryIMP implements ShoppingBagRepository {

  SharedPref sharedPref;
  ShoppingBagRepositoryIMP(this.sharedPref);

  @override
  Future<void> addProduct(Product product) async {
    try {
      List<Product> products = await getProducts();
      int index = products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        products[index].quantity = (products[index].quantity ?? 0) + (product.quantity ?? 1);
      } else {
        products.add(product);
      }
      
      List<Map<String, dynamic>> productsJson = products.map((p) => p.toJson()).toList();
      await sharedPref.save('shopping_bag', productsJson);
    } catch (e) {
      print('Error al agregar producto al carrito: $e');
    }
  }

  @override
  Future<void> deleteShoppingBag()async {
    await sharedPref.remove('shopping_bag');
  }



  @override
  Future<void> deleteitem(Product product) async{
    final data = await sharedPref?.read('shopping_bag');
    if(data == null){
      return;
    }
    List<Product> selectedProducts = Product.fromJsonList(data).toList();
    selectedProducts.removeWhere((p) => p.id == product.id);
    await sharedPref.save('shopping_bag', selectedProducts);
  }



  @override
  Future<List<Product>> getProducts() async {
    try {
      final data = await sharedPref.read('shopping_bag');
      
      if (data == null) {
        print('No hay productos en el carrito');
        return [];
      }
      List<dynamic> productsJson;
      
      if (data is String) {
        productsJson = json.decode(data) as List<dynamic>;
      } else if (data is List) {
        productsJson = data;
      } else {
        print('Formato de datos no reconocido: ${data.runtimeType}');
        return [];
      }
      
      List<Product> products = productsJson.map((productJson) {
        if (productJson is Map<String, dynamic>) {
          return Product.fromJson(productJson);
        } else {
          print('Elemento del carrito no es Map: ${productJson.runtimeType}');
          return null;
        }
      }).where((product) => product != null).cast<Product>().toList();
      
      print('Productos recuperados del carrito: ${products.length}');
      return products;
      
    } catch (e) {
      print('Error al obtener productos del carrito: $e');
      return [];
    }
  }




}