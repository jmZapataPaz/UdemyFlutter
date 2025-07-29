import 'package:ecommerce_flutter/src/domain/useCases/superAdmin/SuperAdminUseCase.dart';
import 'package:ecommerce_flutter/src/domain/models/User.dart';
import 'package:ecommerce_flutter/src/domain/models/Role.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuperAdminState {
  final Resource<List<User>> users;
  final Resource<List<Role>> roles;
  SuperAdminState({required this.users, required this.roles});
}

class SuperAdminBloc extends Cubit<SuperAdminState> {
  final SuperAdminUseCase useCase;
  SuperAdminBloc(this.useCase)
      : super(SuperAdminState(users: Loading<List<User>>(), roles: Loading<List<Role>>()));

  Future<void> fetchUsers() async {
    emit(SuperAdminState(users: Loading<List<User>>(), roles: state.roles));
    final users = await useCase.getAllUsers();
    emit(SuperAdminState(users: users, roles: state.roles));
  }

  Future<void> fetchRoles() async {
    emit(SuperAdminState(users: state.users, roles: Loading<List<Role>>()));
    final roles = await useCase.getAllRoles();
    emit(SuperAdminState(users: state.users, roles: roles));
  }

  Future<void> assignRole(int userId, String roleId) async {
    await useCase.assignRole(userId, roleId);
    await fetchUsers();
  }

  Future<void> removeRole(int userId, String roleId) async {
    await useCase.removeRole(userId, roleId);
    await fetchUsers();
  }
}