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
      
      print('URL para obtener categorías: $url');
      print('Token: $token');
      
      final response = await http.get(url, headers: headers);
      
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      
      if (response.body.isEmpty) {
        return Error('Respuesta vacía del servidor');
      }
      
      final data = json.decode(response.body);
      
      if(response.statusCode == 200 || response.statusCode == 201){
        List<Product> products = List<Product>.from(data.map((x) => Product.fromJson(x)));
        return Success(products);
      }
      else{
        String errorMessage = data['message'] != null ? listToString(data['message']) : 'Error desconocido del servidor';
        return Error(errorMessage);
      }
    } catch (e) {
      print('Error al obtener categorías: $e');
      return Error('Error de conexión: ${e.toString()}');
    }
  }

}