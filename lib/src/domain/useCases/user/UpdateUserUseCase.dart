import 'dart:io';

import 'package:ecommerce_flutter/src/domain/models/User.dart';
import 'package:ecommerce_flutter/src/domain/repository/userRepository.dart';

class UpdateUserUsecase{
  UserRepository userRepository;

  UpdateUserUsecase(this.userRepository);

  run(int id, User user, File? image) => userRepository.update(id, user, image);
}