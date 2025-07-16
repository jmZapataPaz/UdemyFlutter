import 'package:ecommerce_flutter/src/data/dataSource/local/sharedPref.dart';
import 'package:ecommerce_flutter/src/data/dataSource/remote/Services/AuthService.dart';
import 'package:ecommerce_flutter/src/data/dataSource/remote/Services/UserService.dart';
import 'package:ecommerce_flutter/src/domain/repository/userRepository.dart';
import 'package:ecommerce_flutter/src/domain/useCases/user/UpdateUserUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/user/UserUseCase.dart';
import 'package:ecommerce_flutter/src/repository/authRepositoryIMP.dart';
import 'package:ecommerce_flutter/src/domain/repository/authRepository.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/authUseCases.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/getUserSessionUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/loginUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/logoutUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/registerUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/saveUserSessionUseCase.dart';
import 'package:ecommerce_flutter/src/repository/userRepositoryIMP.dart';
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
  AuthUseCases get authUseCases => AuthUseCases(
    login: LoginUseCase(authRepository),
    register: RegisterUseCase(authRepository),
    saveUserSession: SaveUserSessionUseCase(authRepository),
    getUserSession: GetUserSessionUseCase(authRepository),
    logout: LogoutUseCase(authRepository),
  );



  @injectable
  UserService get userService => UserService(sharedPref);

  @injectable
  UserRepository get userRepository => UserRepositoryIMP(userService);


  @injectable
  UserUseCase get userUseCase => UserUseCase(
    updateUserUsecase: UpdateUserUsecase(userRepository),

  );

}