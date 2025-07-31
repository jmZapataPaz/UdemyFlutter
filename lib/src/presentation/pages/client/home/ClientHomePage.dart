import 'package:ecommerce_flutter/src/presentation/pages/client/category/list/ClientCategoryListPage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/home/bloc/ClientHomeBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/home/bloc/ClientHomeEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/home/bloc/ClientHomeState.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/order/list/ClientOrderListPage.dart';
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
    ClientOrderListPage(),
    ProfileInfoPage(),
    RolesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<ClientHomeBloc>(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final shouldExit = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Salir de la aplicación'),
            content: Text('¿Estás seguro que deseas salir?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  Navigator.of(context).maybePop();
                },
                child: Text('Sí'),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Menú de cliente',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            IconButton(
          onPressed: () {
            Navigator.pushNamed(context, 'client/shoppingBag');
          },
          icon: Icon(
            Icons.shopping_bag,
            color: Colors.white,
          ),
            )
          ],
        ),
        drawer: BlocBuilder<ClientHomeBloc, ClientHomeState>(
          builder: (context, state){
            return Drawer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black,
                      Colors.grey[900]!,
                    ],
                  ),
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.black,
                            Colors.grey[800]!,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Menú de Cliente',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width > 600 
                              ? MediaQuery.of(context).size.width * 0.03  
                              : MediaQuery.of(context).size.width * 0.05, 
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.015), 
                    _buildDrawerItem(
                      context: context,
                      icon: Icons.category,
                      title: 'Categorías',
                      isSelected: state.pageIndex == 0,
                      onTap: () {
                        _bloc?.add(ChangeDrawerPage(pageIndex: 0));
                        Navigator.pop(context);
                      },
                    ),
                    _buildDrawerItem(
                      context: context,
                      icon: Icons.shopping_bag,
                      title: 'Mis pedidos',
                      isSelected: state.pageIndex == 1,
                      onTap: () {
                        _bloc?.add(ChangeDrawerPage(pageIndex: 1));
                        Navigator.pop(context);
                      },
                    ),
                    _buildDrawerItem(
                      context: context,
                      icon: Icons.person,
                      title: 'Perfil',
                      isSelected: state.pageIndex == 2,
                      onTap: () {
                        _bloc?.add(ChangeDrawerPage(pageIndex: 2));
                        Navigator.pop(context);
                      },
                    ),
                    _buildDrawerItem(
                      context: context,
                      icon: Icons.admin_panel_settings,
                      title: 'Roles',
                      isSelected: state.pageIndex == 3,
                      onTap: () {
                        _bloc?.add(ChangeDrawerPage(pageIndex: 3));
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03), 
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.08,
                      ),
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.grey[400]!,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.015), 
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [Colors.red[700]!, Colors.red[900]!],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withAlpha(76),
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.width > 600 
                            ? MediaQuery.of(context).size.width * 0.04
                            : MediaQuery.of(context).size.width * 0.06,
                        ),
                        title: Text(
                          'Cerrar Sesión',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: MediaQuery.of(context).size.width > 600 
                              ? MediaQuery.of(context).size.width * 0.025
                              : MediaQuery.of(context).size.width * 0.04,  
                          ),
                        ),
                        onTap: () async {
                          final screenWidth = MediaQuery.of(context).size.width;
                          final isTablet = screenWidth > 600;
                          final shouldLogout = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              insetPadding: isTablet
                                ? EdgeInsets.symmetric(horizontal: screenWidth * 0.25, vertical: 24)
                                : EdgeInsets.symmetric(horizontal: 40, vertical: 24),
                              title: Text('Cerrar sesión'),
                              content: Text('¿Estás seguro que deseas cerrar sesión?'),
                              actions: [
                                TextButton(
                                  child: Text('No'),
                                  onPressed: () => Navigator.of(context).pop(false),
                                ),
                                TextButton(
                                  child: Text('Sí'),
                                  onPressed: () => Navigator.of(context).pop(true),
                                ),
                              ],
                            ),
                          );
                          if (shouldLogout == true) {
                            _bloc?.add(Logout());
                            Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02), 
                  ]
                ),
              ),
            );
          }
        ),
        body: BlocBuilder<ClientHomeBloc, ClientHomeState>(
          builder: (context, state) {
            return pageList[state.pageIndex];
          }
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    bool isTablet = screenWidth > 600;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: screenHeight * 0.005,
        horizontal: screenWidth * (isTablet ? 0.03 : 0.05), 
      ),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey[850] : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          if (isSelected)
            BoxShadow(
              color: Colors.black.withAlpha(76),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: screenWidth * (isTablet ? 0.04 : 0.03), 
          vertical: screenHeight * (isTablet ? 0.015 : 0.01), 
        ),
        leading: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey[400],
          size: screenWidth * (isTablet ? 0.04 : 0.06),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[400],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: screenWidth * (isTablet ? 0.025 : 0.04), 
            letterSpacing: isTablet ? 0.5 : 0, 
          ),
          overflow: TextOverflow.ellipsis, 
          maxLines: 1, 
        ),
        onTap: onTap,
      ),
    );
  }
}