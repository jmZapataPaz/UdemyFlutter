import 'package:equatable/equatable.dart';

abstract class DriverOrderListEvent extends Equatable {
  const DriverOrderListEvent();
  @override
  List<Object?> get props => [];
}

class GetOrders extends DriverOrderListEvent {
  const GetOrders();
}

class FilterByStatus extends DriverOrderListEvent {
  final String status;
  const FilterByStatus({required this.status});
  
  @override
  List<Object?> get props => [status];
}