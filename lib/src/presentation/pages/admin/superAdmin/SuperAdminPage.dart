import 'package:ecommerce_flutter/src/data/dataSource/local/sharedPref.dart';
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
  String? currentUserEmail;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<SuperAdminBloc>(context);
    _bloc?.fetchUsers();
    _bloc?.fetchRoles();
    _loadCurrentUserEmail();
  }

  Future<void> _loadCurrentUserEmail() async {
    final sharedPref = SharedPref();
    final userSession = await sharedPref.read('user');
    if (userSession != null && mounted) {
      setState(() {
        currentUserEmail = userSession['user']['email'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;

    return Scaffold(
      body: BlocListener<SuperAdminBloc, SuperAdminState>(
        listener: (context, state) {
          if (state.users is Error &&
              (state.users as Error).message.contains('token_not_valid')) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Sesión expirada. Inicia sesión nuevamente.'))
            );
            Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
          }
          if (state.roles is Error &&
              (state.roles as Error).message.contains('token_not_valid')) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Sesión expirada. Inicia sesión nuevamente.'))
            );
            Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
          }
        },
        child: BlocBuilder<SuperAdminBloc, SuperAdminState>(
          builder: (context, state) {
            if (state.users is Loading || state.roles is Loading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.users is Success && state.roles is Success) {
              List<User> users = (state.users as Success).data;
              List<Role> roles = (state.roles as Success).data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Asignar Roles',
                    style: TextStyle(
                      fontSize: isTablet ? screenWidth * 0.03 : screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * (isTablet ? 0.08 : 0.03),
                        vertical: screenHeight * (isTablet ? 0.02 : 0.01),
                      ),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        User user = users[index];
                        return Card(
                          margin: EdgeInsets.symmetric(
                            vertical: screenHeight * (isTablet ? 0.01 : 0.008),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(screenWidth * (isTablet ? 0.02 : 0.04)),
                            child: isTablet
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: screenWidth * 0.04,
                                      backgroundImage: user.image != null && user.image!.isNotEmpty
                                        ? NetworkImage(user.image!)
                                        : null,
                                      child: (user.image == null || user.image!.isEmpty)
                                        ? Icon(Icons.person, size: screenWidth * 0.04)
                                        : null,
                                    ),
                                    SizedBox(width: screenWidth * 0.03),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${user.name} ${user.lastname}',
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.025,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(user.email ?? '',
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.02,
                                            ),
                                          ),
                                          SizedBox(height: screenHeight * 0.01),
                                          Wrap(
                                            spacing: 8,
                                            children: user.roles?.map((role) => Chip(
                                              label: Text(role.name),
                                              avatar: role.image != null && role.image.isNotEmpty
                                                ? Image.network(role.image, width: 24, height: 24)
                                                : null,
                                              onDeleted: (
                                                role.name.toLowerCase() == 'cliente' ||
                                                (role.name.toLowerCase() == 'admin' && user.email == currentUserEmail)
                                              )
                                                ? null
                                                : () {
                                                    _bloc?.removeRole(user.id!, role.id);
                                                  },
                                            )).toList() ?? [],
                                          ),
                                          SizedBox(height: screenHeight * 0.01),
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
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: screenWidth * 0.08,
                                          backgroundImage: user.image != null && user.image!.isNotEmpty
                                            ? NetworkImage(user.image!)
                                            : null,
                                          child: (user.image == null || user.image!.isEmpty)
                                            ? Icon(Icons.person, size: screenWidth * 0.08)
                                            : null,
                                        ),
                                        SizedBox(width: screenWidth * 0.04),
                                        Expanded(
                                          child: Text('${user.name} ${user.lastname}',
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.045,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Text(user.email ?? '',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.035,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Wrap(
                                      spacing: 8,
                                      children: user.roles?.map((role) => Chip(
                                        label: Text(role.name),
                                        avatar: role.image != null && role.image.isNotEmpty
                                          ? Image.network(role.image, width: 24, height: 24)
                                          : null,
                                        onDeleted: (
                                          role.name.toLowerCase() == 'cliente' ||
                                          (role.name.toLowerCase() == 'admin' && user.email == currentUserEmail)
                                        )
                                          ? null
                                          : () {
                                              _bloc?.removeRole(user.id!, role.id);
                                            },
                                      )).toList() ?? [],
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
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
                    ),
                  ),
                ],
              );
            }
            return Center(child: Text('Error al cargar usuarios o roles'));
          },
        ),
      ),
    );
  }
}