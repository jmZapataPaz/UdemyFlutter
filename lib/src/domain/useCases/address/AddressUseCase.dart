import 'package:ecommerce_flutter/src/domain/useCases/address/CreateAddressUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/address/DeleteAddressSessionUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/address/DeleteAddressUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/address/GetAddressSesionUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/address/GetUserAddressUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/address/SaveAddressInSessionUseCase.dart';

class AddressUseCase{

  CreateaddressUseCase createaddressUseCase;
  GetUserAddressUseCase getUserAddressUseCase;
  SaveAddressInSessionUseCase saveAddressInSessionUseCase;
  GetAddressSesionUseCase getAddressSesionUseCase;
  DeleteAddressUseCase deleteAddressUseCase;
  DeleteAddressSessionUseCase deleteAddressSessionUseCase;


  AddressUseCase({
    required this.createaddressUseCase,
    required this.getUserAddressUseCase,
    required this.saveAddressInSessionUseCase,
    required this.getAddressSesionUseCase,
    required this.deleteAddressUseCase,
    required this.deleteAddressSessionUseCase,
  });

}