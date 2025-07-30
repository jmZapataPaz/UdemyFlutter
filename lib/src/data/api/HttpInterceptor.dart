import 'package:ecommerce_flutter/main.dart';
import 'package:ecommerce_flutter/src/data/dataSource/local/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpInterceptor {
  static final HttpInterceptor _instance = HttpInterceptor._internal();
  factory HttpInterceptor() => _instance;
  HttpInterceptor._internal();

  GlobalKey<NavigatorState>? navigatorKey;
  late SharedPref _sharedPref;

  void initialize(SharedPref sharedPref) {
    _sharedPref = sharedPref;
  }

  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    final response = await http.get(url, headers: headers);
    return _handleResponse(response);
  }

  Future<http.Response> post(Uri url, {Map<String, String>? headers, Object? body}) async {
    final response = await http.post(url, headers: headers, body: body);
    return _handleResponse(response);
  }

  Future<http.Response> put(Uri url, {Map<String, String>? headers, Object? body}) async {
    final response = await http.put(url, headers: headers, body: body);
    return _handleResponse(response);
  }

  Future<http.Response> delete(Uri url, {Map<String, String>? headers}) async {
    final response = await http.delete(url, headers: headers);
    return _handleResponse(response);
  }

  Future<http.StreamedResponse> send(http.MultipartRequest request) async {
    final response = await request.send();
    if (response.statusCode == 401) {
      await _handleUnauthorized();
    }
    return response;
  }

  http.Response _handleResponse(http.Response response) {
    if (response.statusCode == 401) {
      _handleUnauthorized();
    }
    return response;
  }

  Future<void> _handleUnauthorized() async {
    await _sharedPref.remove('user');
    
    final context = navigatorKey?.currentContext;
    if (context != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainApp()),
        (route) => false,
      );
    }
  }
}