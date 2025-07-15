import 'dart:convert';
import 'package:ecommerce_flutter/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_flutter/data/Api/ApiConfig.dart';
import 'package:ecommerce_flutter/domain/models/AuthResponse.dart';

class AuthService {
  Future<Resource> login (String email, String password) async {
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
      final data = json.decode(response.body);
      if(response.statusCode == 200 || response.statusCode == 201){
        AuthResponse authResponse = AuthResponse.fromJson(data);
        return Success(authResponse);
      }
      else{
        return Error(data['message']);
      }

    } catch (e) {
      print('Error, $e');
      return Error(e.toString());
    }
  }
}