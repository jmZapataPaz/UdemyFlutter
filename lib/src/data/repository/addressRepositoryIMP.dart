import 'package:ecommerce_flutter/src/data/dataSource/local/sharedPref.dart';
import 'package:ecommerce_flutter/src/data/dataSource/remote/Services/AddressService.dart';
import 'package:ecommerce_flutter/src/domain/models/Address.dart';
import 'package:ecommerce_flutter/src/domain/repository/addressRepository.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';

class AddressRepositoryIMP implements AddressRepository {

  AddressService addressService;
  SharedPref sharedPref;
  AddressRepositoryIMP(this.addressService, this.sharedPref);

  
  @override
  Future<Resource<Address>> createAddress(Address address) {
    return addressService.createAddress(address); 
  }

  @override
  Future<Resource<bool>> deleteAddress(int id) {
    return addressService.deleteAddress(id);
  }

  @override
  Future<Address> updateAddress(Address address) {
    // TODO: implement updateAddress
    throw UnimplementedError();
  }
  
  @override
  Future<Resource<List<Address>>> getUserAddress(int idUser) {
    return addressService.getUserAddress(idUser);
  }
  
  @override
  Future<void> saveAddressInSession(Address address) async {
    await sharedPref.save('address', address.toJson());
  }
  
  @override
  Future<Address?> getAddressSesion()async  {
    final data = await sharedPref.read('address');
    if(data != null) {
      Address address = Address.fromJson(data);
      return address;
    }
    return null;
  }
  
  @override
  Future<void> deleteAddressSession() async{
    await sharedPref.remove('address');
    
  }
}