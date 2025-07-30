import 'package:ecommerce_flutter/src/domain/repository/authRepository.dart';

class LogoutUseCase {
  final AuthRepository repository;
  LogoutUseCase(this.repository);

  Future<void> run() async {
    await repository.logout();
  }
}