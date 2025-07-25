import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_flutter/src/data/api/ApiConfig.dart';
import 'package:ecommerce_flutter/src/data/api/HttpInterceptor.dart';
import 'package:ecommerce_flutter/src/domain/models/Category.dart';
import 'package:ecommerce_flutter/src/domain/utils/ListToString.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class CategoryService {

  Future<String> token;
  final HttpInterceptor _httpInterceptor = HttpInterceptor();
  
  CategoryService(this.token);

  Future<Resource<Category>> create(Category category, File? file) async{
    try{
      Uri url = Uri.http(ApiConfig.API_ECOMMERCE, '/categories/');
      
      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = await token;
      if (file != null) {
        request.files.add(http.MultipartFile(
          'file', 
          http.ByteStream(file.openRead().cast()), 
          await file.length(),
          filename: basename(file.path),
          contentType: MediaType('image', 'jpg')
          ),
        );
      }
      print ('CategoryService: ${category.toJson()}');
      request.fields['name'] = category.name;
      request.fields['description'] = category.description;

      final response = await _httpInterceptor.send(request);
      final data = json.decode(await response.stream.transform(utf8.decoder).first);

      if(response.statusCode == 200 || response.statusCode == 201){
        Category categoryResponse = Category.fromJson(data);
        return Success(categoryResponse);
      }
      else{
        return Error(listToString(data['message']));
      }

    } catch (e) {
      print('Error al crear la solicitud: $e');
      return Error(e.toString());
    }
  }

  Future<Resource<List<Category>>> getAll() async{
    try{
      Uri url = Uri.http(ApiConfig.API_ECOMMERCE, '/categories/getCategories');
      
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token
      };
      
      print('URL para obtener categorías: $url');
      print('Headers: $headers');
      print('Token: $token');
      
      final response = await _httpInterceptor.get(url, headers: headers);
      
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      
      if (response.body.isEmpty) {
        return Error('Respuesta vacía del servidor');
      }
      
      final data = json.decode(response.body);
      
      if(response.statusCode == 200 || response.statusCode == 201){
        List<Category> categories = List<Category>.from(data.map((x) => Category.fromJson(x)));
        return Success(categories);
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

 Future<Resource<Category>> updateCategory(int id, Category category, File? file) async{
    try{
      Uri url = Uri.http(ApiConfig.API_ECOMMERCE, '/categories/update/$id');
      
      final request = http.MultipartRequest('PUT', url);
      request.headers['Authorization'] = await token;
      if (file != null) {
        request.files.add(http.MultipartFile(
          'file', 
          http.ByteStream(file.openRead().cast()), 
          await file.length(),
          filename: basename(file.path),
          contentType: MediaType('image', 'jpg')
          ),
        );
      }
      
      request.fields['name'] = category.name;
      request.fields['description'] = category.description;

      final response = await _httpInterceptor.send(request);
      final data = json.decode(await response.stream.transform(utf8.decoder).first);

      if(response.statusCode == 200 || response.statusCode == 201){
        Category categoryResponse = Category.fromJson(data);
        return Success(categoryResponse);
      }
      else{
        return Error(listToString(data['message']));
      }

    } catch (e) {
      print('Error al actualizar la solicitud: $e');
      return Error(e.toString());
    }
  }

  Future<Resource<bool>> deleteCategory(int id) async{
    try{
      Uri url = Uri.http(ApiConfig.API_ECOMMERCE, '/categories/delete/$id');
      
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token
      };
      
      print('Eliminando categoría ID: $id');
      print('URL: $url');
      print('Token: $token');
      
      final response = await _httpInterceptor.delete(url, headers: headers);
      
      print('Delete Status Code: ${response.statusCode}');
      print('Delete Response Body: ${response.body}');
      
      if(response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204){
        return Success(true);
      }
      else{
        if (response.body.isNotEmpty) {
          final data = json.decode(response.body);
          String errorMessage = data['message'] != null ? listToString(data['message']) : 'Error al eliminar categoría';
          return Error(errorMessage);
        } else {
          return Error('Error al eliminar categoría: Status ${response.statusCode}');
        }
      }

    } catch (e) {
      print('Error al eliminar la categoría: $e');
      return Error(e.toString());
    }
  }
}
