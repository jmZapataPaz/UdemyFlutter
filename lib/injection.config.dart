// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ecommerce_flutter/src/data/dataSource/local/sharedPref.dart'
    as _i882;
import 'package:ecommerce_flutter/src/data/dataSource/remote/Services/AddressService.dart'
    as _i482;
import 'package:ecommerce_flutter/src/data/dataSource/remote/Services/AuthService.dart'
    as _i493;
import 'package:ecommerce_flutter/src/data/dataSource/remote/Services/CategoryService.dart'
    as _i251;
import 'package:ecommerce_flutter/src/data/dataSource/remote/Services/ProductService.dart'
    as _i251;
import 'package:ecommerce_flutter/src/data/dataSource/remote/Services/UserService.dart'
    as _i380;
import 'package:ecommerce_flutter/src/di/appModule.dart' as _i896;
import 'package:ecommerce_flutter/src/domain/repository/addressRepository.dart'
    as _i840;
import 'package:ecommerce_flutter/src/domain/repository/authRepository.dart'
    as _i1040;
import 'package:ecommerce_flutter/src/domain/repository/categoryRepository.dart'
    as _i899;
import 'package:ecommerce_flutter/src/domain/repository/productRepository.dart'
    as _i88;
import 'package:ecommerce_flutter/src/domain/repository/shoppingBagRepository.dart'
    as _i78;
import 'package:ecommerce_flutter/src/domain/repository/userRepository.dart'
    as _i242;
import 'package:ecommerce_flutter/src/domain/useCases/address/AddressUseCase.dart'
    as _i988;
import 'package:ecommerce_flutter/src/domain/useCases/auth/authUseCases.dart'
    as _i685;
import 'package:ecommerce_flutter/src/domain/useCases/auth/loginUseCase.dart'
    as _i1009;
import 'package:ecommerce_flutter/src/domain/useCases/categories/CategoryUseCase.dart'
    as _i299;
import 'package:ecommerce_flutter/src/domain/useCases/products/ProductUseCase.dart'
    as _i191;
import 'package:ecommerce_flutter/src/domain/useCases/shoppingBag/ShoppingBagUseCase.dart'
    as _i11;
import 'package:ecommerce_flutter/src/domain/useCases/user/UserUseCase.dart'
    as _i823;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.factory<_i493.AuthService>(() => appModule.authService);
    gh.factory<_i1040.AuthRepository>(() => appModule.authRepository);
    gh.factory<_i1009.LoginUseCase>(() => appModule.loginUseCase);
    gh.factory<_i882.SharedPref>(() => appModule.sharedPref);
    gh.factoryAsync<String>(() => appModule.token);
    gh.factory<_i685.AuthUseCases>(() => appModule.authUseCases);
    gh.factory<_i380.UserService>(() => appModule.userService);
    gh.factory<_i242.UserRepository>(() => appModule.userRepository);
    gh.factory<_i823.UserUseCase>(() => appModule.userUseCase);
    gh.factory<_i251.CategoryService>(() => appModule.categoryService);
    gh.factory<_i899.CategoryRepository>(() => appModule.categoryRepository);
    gh.factory<_i299.CategoryUseCase>(() => appModule.categoryUseCase);
    gh.factory<_i251.ProductService>(() => appModule.productService);
    gh.factory<_i88.ProductRepository>(() => appModule.productRepository);
    gh.factory<_i191.ProductUseCase>(() => appModule.productUseCase);
    gh.factory<_i78.ShoppingBagRepository>(
      () => appModule.shoppingBagRepository,
    );
    gh.factory<_i11.ShoppingBagUseCases>(() => appModule.shoppingBagUseCases);
    gh.factory<_i482.AddressService>(() => appModule.addressService);
    gh.factory<_i840.AddressRepository>(() => appModule.addressRepository);
    gh.factory<_i988.AddressUseCase>(() => appModule.addressUseCase);
    return this;
  }
}

class _$AppModule extends _i896.AppModule {}
