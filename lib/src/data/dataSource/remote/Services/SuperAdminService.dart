import 'dart:convert';
import 'package:ecommerce_flutter/src/data/api/ApiConfig.dart';
import 'package:ecommerce_flutter/src/data/api/HttpInterceptor.dart';
import 'package:ecommerce_flutter/src/domain/models/Role.dart';
import 'package:ecommerce_flutter/src/domain/models/User.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';

class SuperAdminService {
  final HttpInterceptor _httpInterceptor = HttpInterceptor();
  Future<String> token;
  SuperAdminService(this.token);

  Future<Resource<List<User>>> getAllUsers() async {
    Uri url = Uri.http(ApiConfig.API_ECOMMERCE, '/api/get_all');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await token
    };
    final response = await _httpInterceptor.get(url, headers: headers); 
    if (response.statusCode == 200) {
      List<User> users = List<User>.from(json.decode(response.body).map((x) => User.fromJson(x)));
      return Success(users);
    }
    return Error('Error al obtener usuarios');
  }

  Future<Resource<List<Role>>> getAllRoles() async {
    Uri url = Uri.http(ApiConfig.API_ECOMMERCE, '/users/roles/');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await token
    };
    final response = await _httpInterceptor.get(url, headers: headers); 
    if (response.statusCode == 200) {
      List<Role> roles = List<Role>.from(json.decode(response.body).map((x) => Role.fromJson(x)));
      return Success(roles);
    }
    return Error('Error al obtener roles');
  }

  Future<Resource<bool>> assignRole(int userId, String roleId) async {
    Uri url = Uri.http(ApiConfig.API_ECOMMERCE, '/users/assign_role/$userId');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await token
    };
    final response = await _httpInterceptor.post(
      url,
      headers: headers,
      body: json.encode({'id_rol': roleId.toUpperCase()}),
    ); 
    if (response.statusCode == 200) {
      return Success(true);
    }
    return Error('Error al asignar rol');
  }

  Future<Resource<bool>> removeRole(int userId, String roleId) async {
    Uri url = Uri.http(ApiConfig.API_ECOMMERCE, '/users/remove_role/$userId/$roleId');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await token
    };
    final response = await _httpInterceptor.delete(url, headers: headers); 
    if (response.statusCode == 200) {
      return Success(true);
    }
    return Error('Error al remover rol');
  }
}