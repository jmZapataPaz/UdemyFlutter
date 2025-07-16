import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_flutter/src/data/dataSource/local/sharedPref.dart';
import 'package:ecommerce_flutter/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_flutter/src/domain/utils/ListToString.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_flutter/src/data/api/ApiConfig.dart';
import 'package:ecommerce_flutter/src/domain/models/User.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class UserService {
  SharedPref sharedPref;
  UserService(this.sharedPref);

  Future<Resource<User>> update(int id, User user, File? image) async{
    try{
      Uri url = Uri.http(ApiConfig.API_ECOMMERCE, '/api/upload/$id');
      String token = "";
      final userSession = await sharedPref.read('user');
      if(userSession != null){
        AuthResponse authResponse = AuthResponse.fromJson(userSession);
        token = authResponse.token ;
      }
      final request = http.MultipartRequest('PUT', url);
      request.headers['Authorization'] = token;
      if (image != null) {
        request.files.add(http.MultipartFile(
          'file', 
          http.ByteStream(image.openRead().cast()), 
          await image.length(),
          filename: basename(image.path),
          contentType: MediaType('image', 'jpg')
          ),
        );
      }
      
      request.fields['name'] = user.name;
      request.fields['lastname'] = user.lastname;
      request.fields['phone'] = user.phone;

      final response = await request.send();
      final data = json.decode(await response.stream.transform(utf8.decoder).first);

      if(response.statusCode == 200 || response.statusCode == 201){
        User userResponse = User.fromJson(data);
        return Success(userResponse);
      }
      else{
        return Error(listToString(data['message']));
      }

    } catch (e) {
      print('Error al crear la solicitud: $e');
      return Error(e.toString());
    }
  }
}