import 'package:ecommerce_flutter/src/domain/useCases/auth/loginUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/registerUseCase.dart';
import 'package:injectable/injectable.dart';


class AuthUseCases{

  LoginUseCase login;
  RegisterUseCase register;

  AuthUseCases({
    required this.login,
    required this.register
  });

}