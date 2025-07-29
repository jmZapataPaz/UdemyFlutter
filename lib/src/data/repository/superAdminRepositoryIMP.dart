import 'package:ecommerce_flutter/src/data/dataSource/remote/Services/SuperAdminService.dart';
import 'package:ecommerce_flutter/src/domain/models/User.dart';
import 'package:ecommerce_flutter/src/domain/models/Role.dart';
import 'package:ecommerce_flutter/src/domain/repository/superAdminRepository.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';

class SuperAdminRepositoryIMP implements SuperAdminRepository {
  final SuperAdminService service;
  SuperAdminRepositoryIMP(this.service);

  @override
  Future<Resource<List<User>>> getAllUsers() => service.getAllUsers();

  @override
  Future<Resource<List<Role>>> getAllRoles() => service.getAllRoles();

  @override
  Future<Resource<bool>> assignRole(int userId, String roleId) => service.assignRole(userId, roleId);

  @override
  Future<Resource<bool>> removeRole(int userId, String roleId) => service.removeRole(userId, roleId);
}