import 'package:ecommerce_flutter/src/domain/models/Address.dart';
import 'package:ecommerce_flutter/src/domain/repository/addressRepository.dart';

class CreateaddressUseCase {
  AddressRepository addressRepository;
  CreateaddressUseCase(this.addressRepository);
  
  run(Address address) {
    return addressRepository.createAddress(address);
  }

}