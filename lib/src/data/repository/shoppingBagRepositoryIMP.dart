import 'dart:convert';
import 'package:ecommerce_flutter/src/data/dataSource/local/sharedPref.dart';
import 'package:ecommerce_flutter/src/domain/models/Product.dart';
import 'package:ecommerce_flutter/src/domain/repository/shoppingBagRepository.dart';
import 'package:ecommerce_flutter/src/data/api/ApiConfig.dart'; 

class ShoppingBagRepositoryIMP implements ShoppingBagRepository {

  SharedPref sharedPref;
  ShoppingBagRepositoryIMP(this.sharedPref);

  String _normalizeImageUrl(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) return '';
    
    final mediaIndex = imageUrl.indexOf('/media/');
    if (mediaIndex == -1) {
      return imageUrl;
    }
    final mediaPath = imageUrl.substring(mediaIndex);
    final normalizedUrl = 'http://${ApiConfig.API_ECOMMERCE}$mediaPath';
    if (imageUrl != normalizedUrl) {
      print('🔧 URL normalizada: ${imageUrl} → ${normalizedUrl}');
    }
    
    return normalizedUrl;
  }

  Product _normalizeProductUrls(Product product) {
    String? originalImage1 = product.image1;
    String? originalImage2 = product.image2;
    
    product.image1 = _normalizeImageUrl(product.image1);
    product.image2 = _normalizeImageUrl(product.image2);
    if (originalImage1 != product.image1 || originalImage2 != product.image2) {
      print('🔧 Producto ${product.id} URLs normalizadas automáticamente');
    }
    
    return product;
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
      
      productsJson.forEach((item) {
        print('📦 Item: $item');
        if (item is Map && item.containsKey('image1')) {
          print('🖼️ Image1 en JSON: ${item['image1']}');
        }
      });
      
      List<Product> products = productsJson.map((productJson) {
        if (productJson is Map<String, dynamic>) {
          Product product = Product.fromJson(productJson);
          
          product = _normalizeProductUrls(product);
          
          print('🔄 Producto convertido - Image1: ${product.image1}');
          return product;
        } else {
          print('Elemento del carrito no es Map: ${productJson.runtimeType}');
          return null;
        }
      }).where((product) => product != null).cast<Product>().toList();
      
      List<Map<String, dynamic>> normalizedProductsJson = products.map((p) => p.toJson()).toList();
      await sharedPref.save('shopping_bag', normalizedProductsJson);
      
      print('Productos recuperados del carrito: ${products.length}');
      return products;
      
    } catch (e) {
      print('Error al obtener productos del carrito: $e');
      return [];
    }
  }

  @override
  Future<void> addProduct(Product product) async {
    try {
      product = _normalizeProductUrls(product);
      List<Product> products = await getProducts();
      int index = products.indexWhere((p) => p.id == product.id);
      
      if (index != -1) {
        products[index].quantity = product.quantity ?? 1;
        products[index] = _normalizeProductUrls(products[index]);
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
  Future<void> deleteShoppingBag() async {
    try {
      await sharedPref.remove('shopping_bag');
      print('Carrito de compras limpiado');
    } catch (e) {
      print('Error al limpiar carrito: $e');
    }
  }

  @override
  Future<void> deleteitem(Product product) async {
    try {
      List<Product> products = await getProducts();
      products.removeWhere((p) => p.id == product.id);
      
      List<Map<String, dynamic>> productsJson = products.map((p) => p.toJson()).toList();
      await sharedPref.save('shopping_bag', productsJson);
      
      print('Producto eliminado del carrito: ${product.id}');
    } catch (e) {
      print('Error al eliminar producto del carrito: $e');
    }
  }

  @override
  Future<double> getTotal() async  {
    final data = await sharedPref.read('shopping_bag');
    if (data == null) {
      return 0;
    } 
    double total = 0;
    List<Product> selectedProducts = await getProducts(); 
    selectedProducts.forEach((product){
      total = total + (product.price * (product.quantity ?? 1));
    });
    return total;
  }
}