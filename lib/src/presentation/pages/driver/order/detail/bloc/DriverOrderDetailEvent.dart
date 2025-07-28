import 'package:equatable/equatable.dart';

abstract class DriverOrderDetailEvent extends Equatable {

  const DriverOrderDetailEvent();

  @override
  List<Object?> get props => [];
}

class UpdateStatusOrder extends DriverOrderDetailEvent {
  final int id;
  final String status;
  const UpdateStatusOrder({required this.id, required this.status});
  @override
  List<Object?> get props => [id, status];
}