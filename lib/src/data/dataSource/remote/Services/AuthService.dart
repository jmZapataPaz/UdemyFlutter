import 'dart:convert';
import 'package:ecommerce_flutter/src/data/api/ApiConfig.dart';
import 'package:ecommerce_flutter/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_flutter/src/domain/models/User.dart';
import 'package:ecommerce_flutter/src/domain/utils/ListToString.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Resource<AuthResponse>> login (String email, String password) async {
    try{
      Uri url = Uri.http(ApiConfig.API_ECOMMERCE,'/auth/login');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      String body = json.encode({
        'email': email,
        'password': password,
      });

      final response = await http.post(url, headers: headers, body: body);
      
      if (response.body.isEmpty) {
        return Error<AuthResponse>('Respuesta vacía del servidor');
      }
      
      final data = json.decode(response.body);
      
      // VALIDAR QUE data NO SEA NULL:
      if (data == null) {
        return Error<AuthResponse>('Respuesta inválida del servidor');
      }
      
      if(response.statusCode == 200 || response.statusCode == 201){
        AuthResponse authResponse = AuthResponse.fromJson(data);
        return Success(authResponse);
      }
      else{
        return Error(listToString(data['message']));
      }

    } catch (e) {
      print('Error, $e');
      return Error<AuthResponse>(e.toString());
    }
  }

  Future<Resource<AuthResponse>> register (User user) async {
    try{
      Uri url = Uri.http(ApiConfig.API_ECOMMERCE,'/auth/register');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      String body = json.encode(user.toJson());
      
      print('URL: $url');
      print('Body enviado: $body');
      
      final response = await http.post(url, headers: headers, body: body);
      
      print('Status Code: ${response.statusCode}');
      print('Response Body: "${response.body}"');
      print('Response Headers: ${response.headers}');
      
      if (response.body.isEmpty) {
        return Error<AuthResponse>('Respuesta vacía del servidor');
      }
      
      final data = json.decode(response.body);
      
      if (data == null) {
        return Error<AuthResponse>('Respuesta inválida del servidor');
      }
      
      if(response.statusCode == 200 || response.statusCode == 201){
        User registeredUser = User.fromJson(data);
        AuthResponse authResponse = AuthResponse(
          user: registeredUser,
          token: '', // Token vacío para registro
        );
        return Success(authResponse);
      }
      else{
        String errorMessage = data['message'] != null ? listToString(data['message']) : 'Error desconocido';
        return Error<AuthResponse>(errorMessage);
      }

    } catch (e) {
      print('Error, $e');
      return Error<AuthResponse>(e.toString());
    }
  }
}