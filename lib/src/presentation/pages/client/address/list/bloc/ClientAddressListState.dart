import 'package:ecommerce_flutter/src/domain/models/Address.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';

class ClientAddressListState extends Equatable {
  final int? radioValue;
  final Resource? response;
  final Address? selectedAddress;

  const ClientAddressListState({
    this.response,
    this.radioValue,
    this.selectedAddress
  });

  ClientAddressListState copyWith({
    Resource? response,
    int? radioValue,
    Address? selectedAddress,
  }) {
    return ClientAddressListState(
      response: response ?? this.response,
      radioValue: radioValue ?? this.radioValue,
      selectedAddress: selectedAddress ?? this.selectedAddress,
    );
  }

  @override
  List<Object?> get props => [response, radioValue, selectedAddress];
}