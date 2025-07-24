import 'package:ecommerce_flutter/src/domain/models/Address.dart';
import 'package:equatable/equatable.dart';

abstract class ClientAddressListEvent extends Equatable{
  const ClientAddressListEvent();

  @override
  List<Object?> get props => [];
}

class GetUserAddress extends ClientAddressListEvent {
  const GetUserAddress();
}


class ChangeRadioValue extends ClientAddressListEvent {
  final int radioValue;
  final Address address;

  const ChangeRadioValue({
    required this.radioValue,
    required this.address,
  });

  @override
  List<Object?> get props => [radioValue, address];
}

class SetAddressSession extends ClientAddressListEvent {
  final List<Address> addressList;


  const SetAddressSession({
    required this.addressList,
  });

  @override
  List<Object?> get props => [addressList];

}

class DeleteAddress extends ClientAddressListEvent {
  final int id;

  const DeleteAddress({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}


class OnPaymentStripeSubmit extends ClientAddressListEvent {
  const OnPaymentStripeSubmit();

 
}

class CreateOrderEvent extends ClientAddressListEvent {
  final int idUser;
  final int idAddress;
  final List<Map<String, dynamic>> products;

  const CreateOrderEvent({
    required this.idUser,
    required this.idAddress,
    required this.products,
  });

  @override
  List<Object?> get props => [idUser, idAddress, products];
}