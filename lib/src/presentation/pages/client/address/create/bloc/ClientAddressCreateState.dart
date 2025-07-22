import 'package:ecommerce_flutter/src/domain/models/Address.dart';
import 'package:ecommerce_flutter/src/domain/utils/BlocFormItem.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ClientAddressCreateState extends Equatable{

  final GlobalKey<FormState>? formKey;
  final BlocFormItem address;
  final BlocFormItem neighborhood;
  final Resource? response;
  final int idUser;
  
  const ClientAddressCreateState({
    this.address = const BlocFormItem(error: 'Campo requerido'),
    this.neighborhood = const BlocFormItem(error: 'Campo requerido'),
    this.formKey,
    this.response,
    this.idUser = 0,
  });

  toAddress() => Address(
    idUser: idUser, 
    address: address.value, 
    neighborhood: neighborhood.value
  );


  ClientAddressCreateState copyWith({
    BlocFormItem? address,
    BlocFormItem? neighborhood,
    GlobalKey<FormState>? formKey,
    Resource? response,
    int? idUser,
  }) {
    return ClientAddressCreateState(
      address: address ?? this.address,
      neighborhood: neighborhood ?? this.neighborhood,
      formKey: formKey ?? this.formKey ?? GlobalKey<FormState>(),
      response: response ?? this.response,
      idUser: idUser ?? this.idUser,
    );
  }

  @override
  List<Object?> get props => [address, neighborhood, response, idUser];

}