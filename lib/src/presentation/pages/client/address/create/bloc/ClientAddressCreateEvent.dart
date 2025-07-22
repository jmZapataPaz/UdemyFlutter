import 'package:ecommerce_flutter/src/domain/utils/BlocFormItem.dart';
import 'package:equatable/equatable.dart';

abstract class ClientAddressCreateEvent  extends Equatable{

  const ClientAddressCreateEvent();

  @override
  List<Object?> get props => [];

}

class ClientAddressCreateInitEvent extends ClientAddressCreateEvent {
  const ClientAddressCreateInitEvent();

  @override
  List<Object?> get props => [];
}


class AddressChanged extends ClientAddressCreateEvent {
  final BlocFormItem address;

  const AddressChanged({required this.address});

  @override
  List<Object?> get props => [address];
}


class NeighborhoodChanged extends ClientAddressCreateEvent {
  final BlocFormItem neighborhood;

  const NeighborhoodChanged({required this.neighborhood});

  @override
  List<Object?> get props => [neighborhood];
}

class FormSubmitted extends ClientAddressCreateEvent {
  const FormSubmitted();

  @override
  List<Object?> get props => [];
}