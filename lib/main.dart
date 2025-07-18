import 'package:ecommerce_flutter/injection.dart';
import 'package:ecommerce_flutter/src/blockProviders.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/create/AdminCategoryCreatePage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/update/AdminCategoryUpdatePage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/home/AdminHomePage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/create/AdminProductCreatePage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/list/AdminProductListPage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/update/AdminProductUpdatePage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/login/LoginPage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/register/RegisterPage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/home/ClientHomePage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/profile/info/ProfileInfoPage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/profile/update/ProfileUpdatePage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/roles/RolesPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp(
        builder: FToastBuilder(),
      debugShowCheckedModeBanner: false, // Disable the debug banner
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'register': (BuildContext context) => RegisterPage(),
        'roles': (BuildContext context) => RolesPage(),
        'client/home':(BuildContext context) => ClientHomePage(),
        'admin/home':(BuildContext context) => AdminHomePage(), 
        'admin/category/create': (BuildContext context) => AdminCategoryCreatePage(),
        'admin/category/update': (BuildContext context) => AdminCategoryUpdatePage(),
        'admin/product/list': (BuildContext context) => AdminProductListPage(),
        'admin/product/create': (BuildContext context) => AdminProductCreatePage(),
        'admin/product/update': (BuildContext context) => AdminProductUpdatePage(),
        'profile/info': (BuildContext context) => ProfileInfoPage(),
        'profile/update': (BuildContext context) => ProfileUpdatePage(),
        
      },
    )
    );
  }
}
