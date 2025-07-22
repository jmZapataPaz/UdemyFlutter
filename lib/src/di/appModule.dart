import 'package:ecommerce_flutter/src/data/dataSource/local/sharedPref.dart';
import 'package:ecommerce_flutter/src/data/dataSource/remote/Services/AddressService.dart';
import 'package:ecommerce_flutter/src/data/dataSource/remote/Services/AuthService.dart';
import 'package:ecommerce_flutter/src/data/dataSource/remote/Services/CategoryService.dart';
import 'package:ecommerce_flutter/src/data/dataSource/remote/Services/ProductService.dart';
import 'package:ecommerce_flutter/src/data/dataSource/remote/Services/UserService.dart';
import 'package:ecommerce_flutter/src/data/repository/addressRepositoryIMP.dart';
import 'package:ecommerce_flutter/src/data/repository/productRepositoryIMP.dart';
import 'package:ecommerce_flutter/src/data/repository/shoppingBagRepositoryIMP.dart';
import 'package:ecommerce_flutter/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_flutter/src/domain/repository/addressRepository.dart';
import 'package:ecommerce_flutter/src/domain/repository/categoryRepository.dart';
import 'package:ecommerce_flutter/src/domain/repository/productRepository.dart';
import 'package:ecommerce_flutter/src/domain/repository/shoppingBagRepository.dart';
import 'package:ecommerce_flutter/src/domain/repository/userRepository.dart';
import 'package:ecommerce_flutter/src/domain/useCases/address/AddressUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/address/CreateAddressUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/address/DeleteAddressSessionUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/address/DeleteAddressUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/address/GetAddressSesionUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/address/GetUserAddressUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/address/SaveAddressInSessionUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/categories/CategoryUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/categories/CreateCategoryUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/categories/DeleteCategoryUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/categories/GetCategoryUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/categories/UpdateCategoryUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/products/CreateProductUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/products/DeleteProductUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/products/GetProductByCategoryUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/products/ProductUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/products/UpdateProductUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/shoppingBag/AddShoppingBagUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/shoppingBag/DeleteItemShoppingBagUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/shoppingBag/DeleteShoppingBagUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/shoppingBag/GetProductShoppingBagUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/shoppingBag/GetTotalShoppingBagUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/shoppingBag/ShoppingBagUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/user/UpdateUserUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/user/UserUseCase.dart';
import 'package:ecommerce_flutter/src/data/repository/authRepositoryIMP.dart';
import 'package:ecommerce_flutter/src/domain/repository/authRepository.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/authUseCases.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/getUserSessionUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/loginUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/logoutUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/registerUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/saveUserSessionUseCase.dart';
import 'package:ecommerce_flutter/src/data/repository/categoriRepositoryIMP.dart';
import 'package:ecommerce_flutter/src/data/repository/userRepositoryIMP.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule{

  @injectable
  AuthService get authService => AuthService();
  
  @injectable
  AuthRepository get authRepository => AuthRepositoryImpl(authService, sharedPref);

  @injectable
  LoginUseCase get loginUseCase => LoginUseCase(authRepository);

  @injectable
  SharedPref get sharedPref => SharedPref();

  @injectable
  Future<String> get token async{
    String token = "";
      final userSession = await sharedPref.read('user');
      if(userSession != null){
        AuthResponse authResponse = AuthResponse.fromJson(userSession);
        token = authResponse.token ;
    }
    return token; 
  }
  
  //LOGIN

  @injectable
  AuthUseCases get authUseCases => AuthUseCases(
    login: LoginUseCase(authRepository),
    register: RegisterUseCase(authRepository),
    saveUserSession: SaveUserSessionUseCase(authRepository),
    getUserSession: GetUserSessionUseCase(authRepository),
    logout: LogoutUseCase(authRepository),
  );

  //USUARIO

  @injectable
  UserService get userService => UserService(token);

  @injectable
  UserRepository get userRepository => UserRepositoryIMP(userService);


  @injectable
  UserUseCase get userUseCase => UserUseCase(
    updateUserUsecase: UpdateUserUsecase(userRepository),

  );
    //CATEGORIAS

  @injectable
  CategoryService get categoryService => CategoryService(token);

  @injectable
  CategoryRepository get categoryRepository => CategoryRepositoryIMP(categoryService);

  @injectable
  CategoryUseCase get categoryUseCase => CategoryUseCase(
    createCategoryUseCase: CreateCategoryUseCase(categoryRepository),
    getCategoryUseCase: GetCategoryUseCase(categoryRepository),
    updateCategoryUseCase: UpdateCategoryUseCase(categoryRepository),
    deleteCategoryUsecase: DeleteCategoryUseCase(categoryRepository),
  );


  //PRODUCTOS
  @injectable
  ProductService get productService => ProductService(token);

  @injectable
  ProductRepository get productRepository => ProductRepositoryIMP(productService);

  @injectable
  ProductUseCase get productUseCase => ProductUseCase(
    createProductUseCase: CreateProductUseCase(productRepository),
    getProductByCategoryUseCase: GetProductByCategoryUseCase(productRepository),
    updateProductUseCase: UpdateProductUseCase(productRepository),
    deleteProductUseCase: DeleteProductUseCase(productRepository),
  );


  //shopping bag
  @injectable
  ShoppingBagRepository get shoppingBagRepository => ShoppingBagRepositoryIMP(sharedPref);

  @injectable
  ShoppingBagUseCases get shoppingBagUseCases => ShoppingBagUseCases(
    addShoppingBagUseCase: AddShoppingBagUseCase(shoppingBagRepository),
    deleteItemShoppingBagUseCase: DeleteItemShoppingBagUseCase(shoppingBagRepository),
    getProductShoppingBagUseCase: GetProductShoppingBagUseCase(shoppingBagRepository),
    deleteShoppingBagUseCase: DeleteShoppingBagUseCase(shoppingBagRepository),
    getTotalShoppingBagUseCase: GetTotalShoppingBagUseCase(shoppingBagRepository),
  );



  //address
  @injectable
  AddressService get addressService => AddressService(token);

  @injectable
  AddressRepository get addressRepository => AddressRepositoryIMP(addressService, sharedPref);
  
  
  @injectable
  AddressUseCase get addressUseCase => AddressUseCase(
    createaddressUseCase: CreateaddressUseCase(addressRepository),
    getUserAddressUseCase: GetUserAddressUseCase(addressRepository),
    saveAddressInSessionUseCase: SaveAddressInSessionUseCase(addressRepository),
    getAddressSesionUseCase: GetAddressSesionUseCase(addressRepository),
    deleteAddressUseCase: DeleteAddressUseCase(addressRepository),
    deleteAddressSessionUseCase: DeleteAddressSessionUseCase(addressRepository),
    
  );
}