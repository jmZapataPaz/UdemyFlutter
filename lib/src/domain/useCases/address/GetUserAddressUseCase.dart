import 'package:ecommerce_flutter/src/domain/repository/addressRepository.dart';

class GetUserAddressUseCase {

  AddressRepository addressRepository;
  GetUserAddressUseCase(this.addressRepository);

  run(int idUser) {
    return addressRepository.getUserAddress(idUser);
  }

}