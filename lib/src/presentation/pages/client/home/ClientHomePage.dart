import 'package:ecommerce_flutter/main.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/category/list/ClientCategoryListPage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/home/bloc/ClientHomeBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/home/bloc/ClientHomeEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/home/bloc/ClientHomeState.dart';
import 'package:ecommerce_flutter/src/presentation/pages/profile/info/ProfileInfoPage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/roles/RolesPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {

  ClientHomeBloc? _bloc;
  List<Widget> pageList = <Widget>[
    ClientCategoryListPage(),
    ProfileInfoPage(),
    RolesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<ClientHomeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú'),
      ),
      drawer: BlocBuilder<ClientHomeBloc, ClientHomeState>(
        builder: (context, state){
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Text(
                    'Menú de Cliente',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ),
                ListTile(
                  title: Text('Categorias'),
                  selected: state.pageIndex == 0,
                  onTap: () {
                    _bloc?.add(ChangeDrawerPage(
                      pageIndex: 0
                    ));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Perfil de Usuario'),
                  selected: state.pageIndex == 1,
                  onTap: () {
                    _bloc?.add(ChangeDrawerPage(
                      pageIndex: 1
                    ));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Roles'),
                  selected: state.pageIndex == 2,
                  onTap: () {
                    _bloc?.add(ChangeDrawerPage(
                      pageIndex: 2
                    ));
                    Navigator.pop(context);
                  },
                ),
                
                ListTile(
                  title: Text('Cerrar Sesión'),
                  onTap: () {
                    _bloc?.add(Logout());
                    Navigator.pushAndRemoveUntil(
                      context, 
                      MaterialPageRoute(builder:(context) => MainApp()), 
                      (route) => false
                    );
                  },
                )
              ]
            )
          );
        }
      ),
      body: BlocBuilder<ClientHomeBloc, ClientHomeState>(
        builder: (context, state) {
          return pageList[state.pageIndex];
        }
      ),
    );
  }
}