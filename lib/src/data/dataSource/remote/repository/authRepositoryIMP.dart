

import 'package:ecommerce_flutter/src/data/dataSource/remote/Services/AuthService.dart';
import 'package:ecommerce_flutter/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_flutter/src/domain/models/User.dart';
import 'package:ecommerce_flutter/src/domain/repository/authRepository.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';

class AuthRepositoryImpl implements AuthRepository {

  AuthService authService;
  AuthRepositoryImpl(this.authService);

  @override
  Future<Resource<AuthResponse>> login(String email, String password) {

    return authService.login(email, password);
  }

  @override
  Future<Resource<AuthResponse>> register(User user) {
    return authService.register(user);
    
  }

}