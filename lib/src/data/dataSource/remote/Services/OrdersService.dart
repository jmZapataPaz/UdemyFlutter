import 'dart:convert';
import 'package:ecommerce_flutter/src/data/api/ApiConfig.dart';
import 'package:ecommerce_flutter/src/domain/models/Order.dart';
import 'package:ecommerce_flutter/src/domain/utils/ListToString.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;

class OrdersService {

  Future<String> token;

  OrdersService(this.token);

  Future<Resource<Order>> createOrder(Order order) async{
    try{
      print('Creating orders: ${order.toJsonCreate()}'); 
      Uri url = Uri.http(ApiConfig.API_ECOMMERCE, '/orders/');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token
      };
      String body = json.encode(order.toJsonCreate());
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if(response.statusCode == 200 || response.statusCode == 201){
        Order orderResponse = Order.fromJson(data);
        return Success(orderResponse);
      }
      else{
        return Error(data['message'] ?? 'Error al crear la orden');
      }
    }
    catch (e) {
      print('Error: $e');
      return Error(e.toString());
    }
  }


  Future<Resource<List<Order>>> getOrders() async {
     try {
      Uri url = Uri.http(ApiConfig.API_ECOMMERCE, '/orders/all');
      Map<String, String> headers = {
        "Content-Type": "application/json; charset=utf-8",
        "Accept": "application/json; charset=utf-8",
        "Authorization": await token
      };
      
      final response = await http.get(url, headers: headers);
      
      if (response.statusCode == 200) {
        // Decodificar con UTF-8
        final responseData = utf8.decode(response.bodyBytes);
        List<dynamic> data = json.decode(responseData);
        List<Order> orders = Order.fromJsonList(data);
        return Success(orders);
      }
      else { // ERROR
        final data = json.decode(response.body);
        return Error(listToString(data['message']));
      }      
    } catch (e) {
      print('Error: $e');
      return Error(e.toString());
    }
  }

  Future<Resource<List<Order>>> getOrdersByClient(int idClient) async {
     try {
      Uri url = Uri.http(ApiConfig.API_ECOMMERCE, '/orders/user/$idClient'); 
      Map<String, String> headers = { 
        "Content-Type": "application/json",
        "Authorization": await token
      };
      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Order> orders = Order.fromJsonList(data);
        return Success(orders);
      }
      else { // ERROR
        return Error(listToString(data['message']));
      }      
    } catch (e) {
      print('Error: $e');
      return Error(e.toString());
    }
  }

   Future<Resource<Order>> updateStatus(int id, String status) async {
     try {
      print('Actualizando orden $id a $status');
      Uri url = Uri.http(ApiConfig.API_ECOMMERCE, '/orders/$id');      
      Map<String, String> headers = { 
        "Content-Type": "application/json",
        "Authorization": await token
      };
      
      String body = json.encode({"status": status});
      print('Body enviado: $body');
      
      final response = await http.put(url, headers: headers, body: body);
      final data = json.decode(response.body);
      print('Data: $data');
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        Order orderResponse = Order.fromJson(data);
        return Success(orderResponse);
      }
      else {
        return Error(listToString(data['message']));
      }      
    } catch (e) {
      print('Error: $e');
      return Error(e.toString());
    }
  }



}