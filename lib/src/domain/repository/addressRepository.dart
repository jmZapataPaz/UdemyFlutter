import 'package:ecommerce_flutter/src/domain/models/Address.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';

abstract class AddressRepository {
  Future<Resource<Address>> createAddress(Address address);
  Future<Resource<List<Address>>> getUserAddress(int idUser);
  Future<Address> updateAddress(Address address);
  Future<void> saveAddressInSession(Address address);
  Future<Address?> getAddressSesion();
  Future<Resource<bool>>deleteAddress(int id);
  Future<void> deleteAddressSession();


}