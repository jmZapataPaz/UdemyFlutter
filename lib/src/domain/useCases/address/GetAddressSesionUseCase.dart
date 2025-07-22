import 'package:ecommerce_flutter/src/domain/repository/addressRepository.dart';

class GetAddressSesionUseCase{
  AddressRepository addressRepository;
  GetAddressSesionUseCase(this.addressRepository);

  run() => addressRepository.getAddressSesion();
}