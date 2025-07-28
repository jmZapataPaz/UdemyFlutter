import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';

class DriverOrderDetailState extends Equatable {

  final Resource? response;

  const DriverOrderDetailState({ this.response });

  DriverOrderDetailState copyWith({
    Resource? response
  }) {
    return DriverOrderDetailState(
      response: response ?? this.response
    );
  }

  @override
  List<Object?> get props => [response];

}