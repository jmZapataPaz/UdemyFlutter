import 'package:ecommerce_flutter/src/domain/repository/superAdminRepository.dart';

class SuperAdminUseCase {
  final SuperAdminRepository superAdminRepository;
  SuperAdminUseCase(this.superAdminRepository);

  Future getAllUsers() => superAdminRepository.getAllUsers();
  Future getAllRoles() => superAdminRepository.getAllRoles();
  Future assignRole(int userId, String roleId) => superAdminRepository.assignRole(userId, roleId);
  Future removeRole(int userId, String roleId) => superAdminRepository.removeRole(userId, roleId);
}