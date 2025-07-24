
import 'package:ecommerce_flutter/src/domain/models/Order.dart';
import 'package:ecommerce_flutter/src/domain/repository/OrdersRepository.dart';

class CreateOrdersUseCase {
  OrdersRepository ordersRepository;
  CreateOrdersUseCase(this.ordersRepository);
  
  run(Order order) {
    return ordersRepository.createOrder(order);
  }

}