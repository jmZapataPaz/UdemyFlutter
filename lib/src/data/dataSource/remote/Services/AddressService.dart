import 'dart:convert';
import 'package:ecommerce_flutter/src/data/api/ApiConfig.dart';
import 'package:ecommerce_flutter/src/domain/models/Address.dart';
import 'package:ecommerce_flutter/src/domain/utils/ListToString.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;

class AddressService{

  Future<String> token;
  AddressService(this.token);
  Future<Resource<Address>> createAddress(Address address) async{
    try{
      print('Creating address: ${address.toJson()}');
      Uri url = Uri.http(ApiConfig.API_ECOMMERCE, '/address/');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token
      };
      String body = json.encode(address.toJson());
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if(response.statusCode == 200 || response.statusCode == 201){
        Address addressResponse = Address.fromJson(data);
        return Success(addressResponse);
      }
      else{
        return Error(data['message'] ?? 'Error al crear la dirección');
      }
    }
    catch (e) {
      print('Error al crear la dirección: $e');
      return Error(e.toString());
    }
  }


  Future<Resource<List<Address>>> getUserAddress(int idUser) async{
    try{
      Uri url = Uri.http(ApiConfig.API_ECOMMERCE, '/address/user/$idUser');
      
      
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token
      };
      
      print('URL para obtener las direcciones: $url');
      print('Token: $token');
      
      final response = await http.get(url, headers: headers);
      
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      
      if (response.body.isEmpty) {
        return Error('Respuesta vacía del servidor');
      }
      
      final data = json.decode(response.body);
      
      if(response.statusCode == 200 || response.statusCode == 201){
        List<Address> categories = Address.fromJsonList(data);
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

Future<Resource<bool>> deleteAddress(int id) async{
    try{
      Uri url = Uri.http(ApiConfig.API_ECOMMERCE, '/address/$id');
      
      
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token
      };
      
      print('Eliminando address ID: $id');
      print('URL: $url');
      print('Token: $token');
      
      final response = await http.delete(url, headers: headers);
      
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
          return Error('Error al eliminar la dirección: Status ${response.statusCode}');
        }
      }

    } catch (e) {
      print('Error al eliminar la dirección: $e');
      return Error(e.toString());
    }
  }



}