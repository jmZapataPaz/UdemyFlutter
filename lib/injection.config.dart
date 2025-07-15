// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ecommerce_flutter/src/data/dataSource/remote/Services/AuthService.dart'
    as _i493;
import 'package:ecommerce_flutter/src/di/appModule.dart' as _i896;
import 'package:ecommerce_flutter/src/domain/repository/authRepository.dart'
    as _i1040;
import 'package:ecommerce_flutter/src/domain/useCases/auth/authUseCases.dart'
    as _i685;
import 'package:ecommerce_flutter/src/domain/useCases/auth/loginUseCase.dart'
    as _i1009;
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
    gh.factory<_i685.AuthUseCases>(() => appModule.authUseCases);
    return this;
  }
}

class _$AppModule extends _i896.AppModule {}
