import 'package:ecommerce_flutter/src/domain/models/User.dart';
import 'package:ecommerce_flutter/src/domain/models/Role.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';

abstract class SuperAdminRepository {
  Future<Resource<List<User>>> getAllUsers();
  Future<Resource<List<Role>>> getAllRoles();
  Future<Resource<bool>> assignRole(int userId, String roleId);
  Future<Resource<bool>> removeRole(int userId, String roleId);
}