import 'package:ecommerce_flutter/src/data/dataSource/remote/Services/OrdersService.dart';
import 'package:ecommerce_flutter/src/domain/models/Order.dart';
import 'package:ecommerce_flutter/src/domain/repository/OrdersRepository.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';

class OrderRepositoryIMP implements OrdersRepository {

  OrdersService ordersService;

  OrderRepositoryIMP(this.ordersService);

  @override
  Future<Resource<Order>> createOrder(Order order) {
    return ordersService.createOrder(order);
  }

  @override
  Future<Resource<List<Order>>> getOrders() {
    return ordersService.getOrders();
  }

  @override
  Future<Resource<List<Order>>> getOrdersByClient(int idClient) {
    return ordersService.getOrdersByClient(idClient);
  }

  @override
  Future<Resource<Order>> updateStatus(int id, String status) {
    return ordersService.updateStatus(id, status);
  }
}
