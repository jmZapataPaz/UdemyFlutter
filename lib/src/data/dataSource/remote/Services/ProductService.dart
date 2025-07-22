import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_flutter/src/data/api/ApiConfig.dart';
import 'package:ecommerce_flutter/src/domain/models/Product.dart';
import 'package:ecommerce_flutter/src/domain/utils/ListToString.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class ProductService{
  
  Future<String> token;
  ProductService(this.token);

  Future<Resource<Product>> createProduct(Product product, List<File> files) async{
    try{
      Uri url = Uri.http(ApiConfig.API_ECOMMERCE, '/products/');
      
      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = await token;
      files.forEach((file) async{
        if (file != null) {
          request.files.add(http.MultipartFile(
            'files', 
            http.ByteStream(file.openRead().cast()), 
            await file.length(),
            filename: basename(file.path),
            contentType: MediaType('image', 'jpg')
            ),
          );
        }
      });
      print ('ProductService: ${product.toJson()}');
      request.fields['name'] = product.name;
      request.fields['description'] = product.description;
      request.fields['price'] = product.price.toString();
      request.fields['id_category'] = product.id_category.toString();
      

      final response = await request.send();
      final data = json.decode(await response.stream.transform(utf8.decoder).first);

      if(response.statusCode == 200 || response.statusCode == 201){
        Product productResponse = Product.fromJson(data);
        return Success(productResponse);
      }
      else{
        return Error(listToString(data['message']));
      }

    } catch (e) {
      print('Error al crear la solicitud: $e');
      return Error(e.toString());
    }
  }

  Future<Resource<List<Product>>> getProductsByCategoryt(int id_category) async{
    try{
      Uri url = Uri.http(ApiConfig.API_ECOMMERCE, '/products/category/$id_category');
      
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token
      };
      
      final response = await http.get(url, headers: headers);
      
      if (response.body.isEmpty) {
        return Error('Respuesta vacía del servidor');
      }
      
      final data = json.decode(response.body);
      
      if(response.statusCode == 200 || response.statusCode == 201){
        List<Product> products = List<Product>.from(data.map((x) => Product.fromJson(x)));
        
        products.forEach((product) {
          print('🖼️ ═══ PRODUCTO DESDE API ═══');
          print('🆔 ID: ${product.id}');
          print('🏷️ Nombre: ${product.name}');
          print('🖼️ Image1: ${product.image1}');
          print('🖼️ Image2: ${product.image2}');
          print('═══════════════════════════');
        });
        
        return Success(products);
      }
      else{
        String errorMessage = data['message'] != null ? listToString(data['message']) : 'Error desconocido del servidor';
        return Error(errorMessage);
      }
    } catch (e) {
      print('❌ Error al obtener productos: $e');
      return Error('Error de conexión: ${e.toString()}');
    }
  }

  Future<Resource<Product>> updateProductById(int id, Product product, List<File> files, List<int>? imagesToUpdate) async {
    try {
      Uri url = Uri.http(ApiConfig.API_ECOMMERCE, '/products/update/$id');
      
      final request = http.MultipartRequest('PUT', url);
      request.headers['Authorization'] = await token;
      
      files.forEach((file) {
        if (file != null) {
          request.files.add(http.MultipartFile(
            'files',
            http.ByteStream(file.openRead().cast()),
            file.lengthSync(),
            filename: basename(file.path),
            contentType: MediaType('image', 'jpg')
          ));
        }
      });

      request.fields['name'] = product.name;
      request.fields['description'] = product.description;
      request.fields['price'] = product.price.toString();
      
      if (imagesToUpdate != null && imagesToUpdate.isNotEmpty) {
        request.fields['images_to_update'] = imagesToUpdate.join(',');
      }

      final response = await request.send();
      final data = json.decode(await response.stream.transform(utf8.decoder).first);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Product updatedProduct = Product.fromJson(data);
        return Success(updatedProduct);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      print('Error al actualizar el producto: $e');
      return Error(e.toString());
    }
  }

  Future<Resource<bool>> deleteProduct(int id) async {
    try {
      Uri url = Uri.http(ApiConfig.API_ECOMMERCE, '/products/$id'); 

      
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token
      };
      
      print('Eliminando producto ID: $id');
      print('URL: $url');
      
      final response = await http.delete(url, headers: headers); 
      
      print('Delete Status Code: ${response.statusCode}');
      print('Delete Response Body: ${response.body}');
      
      if(response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204){
        return Success(true); 
      }
      else{
        if (response.body.isNotEmpty) {
          final data = json.decode(response.body);
          String errorMessage = data['message'] != null ? listToString(data['message']) : 'Error al eliminar producto';
          return Error(errorMessage);
        } else {
          return Error('Error al eliminar producto: Status ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error al eliminar el producto: $e');
      return Error(e.toString());
    }
  }

}