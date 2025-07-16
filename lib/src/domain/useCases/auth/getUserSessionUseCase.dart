import 'package:ecommerce_flutter/src/domain/repository/authRepository.dart';

class GetUserSessionUseCase{

  AuthRepository authRepository;
  GetUserSessionUseCase(this.authRepository);

  run() => authRepository.getUserSession();

  
}