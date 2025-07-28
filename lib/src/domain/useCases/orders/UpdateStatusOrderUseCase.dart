import 'package:ecommerce_flutter/src/domain/repository/OrdersRepository.dart';

class UpdateStatusOrderUseCase {

  OrdersRepository ordersRepository;

  UpdateStatusOrderUseCase(this.ordersRepository);

  run(int id, String status) => ordersRepository.updateStatus(id, status);

}