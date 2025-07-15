import 'package:ecommerce_flutter/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/presentation/pages/auth/login/LoginBlocCubit.dart';
import 'package:ecommerce_flutter/presentation/pages/auth/login/LoginContent.dart';
import 'package:ecommerce_flutter/presentation/pages/auth/login/LoginResponse.dart';
import 'package:ecommerce_flutter/presentation/widgets/DefaultTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  LoginBlocCubit? _loginBlocCubit;

  @override
  void initState() {
    
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp){
      _loginBlocCubit?.dispose();

    });
  }


  @override
  Widget build(BuildContext context) { 
    _loginBlocCubit = BlocProvider.of<LoginBlocCubit>(context, listen: false);

    return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,

          child: Stack(
            alignment: Alignment.center,
            children: [
            
              LoginContent(_loginBlocCubit), 
              LoginResponse(_loginBlocCubit),
            ],
          ),
        )
    );
  }


}