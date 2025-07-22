import 'package:ecommerce_flutter/src/domain/repository/addressRepository.dart';

class DeleteAddressUseCase{

  AddressRepository addressRepository;
  DeleteAddressUseCase(this.addressRepository);
  run(int id) => addressRepository.deleteAddress(id);

}