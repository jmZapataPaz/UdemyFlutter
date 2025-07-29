import 'package:ecommerce_flutter/src/domain/models/User.dart';
import 'package:ecommerce_flutter/src/domain/models/Role.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/superAdmin/bloc/SuperAdminBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuperAdminPage extends StatefulWidget {
  const SuperAdminPage({super.key});
  @override
  State<SuperAdminPage> createState() => _SuperAdminPageState();
}

class _SuperAdminPageState extends State<SuperAdminPage> {
  SuperAdminBloc? _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<SuperAdminBloc>(context);
    _bloc?.fetchUsers();
    _bloc?.fetchRoles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Asignar Roles')),
      body: BlocBuilder<SuperAdminBloc, SuperAdminState>(
        builder: (context, state) {
          if (state.users is Loading || state.roles is Loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state.users is Success && state.roles is Success) {
            List<User> users = (state.users as Success).data;
            List<Role> roles = (state.roles as Success).data;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                User user = users[index];
                return Card(
                  child: ListTile(
                    leading: user.image != null && user.image!.isNotEmpty
                      ? CircleAvatar(backgroundImage: NetworkImage(user.image!))
                      : CircleAvatar(child: Icon(Icons.person)),
                    title: Text('${user.name} ${user.lastname}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.email ?? ''),
                        Wrap(
                          children: user.roles?.map((role) => Chip(
                            label: Text(role.name),
                            avatar: Image.network(role.image, width: 24, height: 24),
                            onDeleted: () {
                              _bloc?.removeRole(user.id!, role.id);
                            },
                          )).toList() ?? [],
                        ),
                        DropdownButton<String>(
                          hint: Text('Asignar rol'),
                          items: roles.map((role) {
                            return DropdownMenuItem<String>(
                              value: role.id,
                              child: Text(role.name),
                            );
                          }).toList(),
                          onChanged: (roleId) {
                            if (roleId != null) {
                              _bloc?.assignRole(user.id!, roleId);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Center(child: Text('Error al cargar usuarios o roles'));
        },
      ),
    );
  }
}