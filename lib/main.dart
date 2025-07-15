import 'package:ecommerce_flutter/injection.dart';
import 'package:ecommerce_flutter/src/blockProviders.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/login/LoginBlocCubit.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/login/LoginPage.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/register/RegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async {
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
        'Register': (BuildContext context) => RegisterPage(),
      },
    )
    );
  }
}
