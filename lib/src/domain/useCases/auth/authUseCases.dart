import 'package:ecommerce_flutter/src/domain/useCases/auth/getUserSessionUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/loginUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/logoutUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/registerUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/saveUserSessionUseCase.dart';
import 'package:injectable/injectable.dart';


class AuthUseCases{

  LoginUseCase login;
  RegisterUseCase register;
  SaveUserSessionUseCase saveUserSession;
  GetUserSessionUseCase getUserSession;
  LogoutUseCase logout;

  AuthUseCases({
    required this.login,
    required this.register,
    required this.saveUserSession,
    required this.getUserSession,
    required this.logout,
  });

}