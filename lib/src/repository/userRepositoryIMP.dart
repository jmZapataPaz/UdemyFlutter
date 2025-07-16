import 'dart:io';

import 'package:ecommerce_flutter/src/data/dataSource/remote/Services/UserService.dart';
import 'package:ecommerce_flutter/src/domain/models/User.dart';
import 'package:ecommerce_flutter/src/domain/repository/userRepository.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';

class UserRepositoryIMP implements UserRepository {

  UserService userService;
  UserRepositoryIMP(this.userService);

  @override
  Future<Resource<User>> update(int id, User user, File? image) {
    return userService.update(id, user, image);
  }

}