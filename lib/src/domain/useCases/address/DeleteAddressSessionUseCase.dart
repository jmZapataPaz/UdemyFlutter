import 'package:ecommerce_flutter/src/domain/repository/addressRepository.dart';

class DeleteAddressSessionUseCase{
  AddressRepository addressRepository;

  DeleteAddressSessionUseCase(this.addressRepository);

  run() => addressRepository.deleteAddressSession();
}