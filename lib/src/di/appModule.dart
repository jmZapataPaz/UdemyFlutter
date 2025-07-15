import 'package:ecommerce_flutter/src/data/dataSource/remote/Services/AuthService.dart';
import 'package:ecommerce_flutter/src/data/dataSource/remote/repository/authRepositoryIMP.dart';
import 'package:ecommerce_flutter/src/domain/repository/authRepository.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/authUseCases.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/loginUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/registerUseCase.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule{

  @injectable
  AuthService get authService => AuthService();
  
  @injectable
  AuthRepository get authRepository => AuthRepositoryImpl(authService);

  @injectable
  LoginUseCase get loginUseCase => LoginUseCase(authRepository);


  @injectable
  AuthUseCases get authUseCases => AuthUseCases(
    login: LoginUseCase(authRepository),
    register: RegisterUseCase(authRepository)
  );

}