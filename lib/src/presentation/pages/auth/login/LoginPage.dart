import 'package:ecommerce_flutter/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/login/LoginContent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/login/bloc/LoginState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  LoginBloc? _bloc;

  @override
  void initState() {
    
    super.initState();
   /* WidgetsBinding.instance?.addPostFrameCallback((timeStamp){
      _bloc?.dispose();

    });*/
  }


  @override
  Widget build(BuildContext context) { 
    _bloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state){
              final responseState = state.response;
              if(responseState is Error){
                Fluttertoast.showToast(
                msg: responseState.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
              );
            }
            else if (responseState is Success){
              final authResponse = responseState.data as AuthResponse;
              _bloc?.add(LoginSaveUserSession(authResponse: authResponse));

              WidgetsBinding.instance.addPostFrameCallback((_) {
                final roles = authResponse.user.roles;
                if (roles != null && roles.isNotEmpty) {
                  final firstRole = roles.first.name.toLowerCase();
                  String route;
                  switch (firstRole) {
                    case 'admin':
                      route = 'admin/home';
                      break;
                    case 'cliente':
                      route = 'client/home';
                      break;
                    case 'conductor':
                      route = 'driver/home';
                      break;
                    default:
                      route = 'roles';
                  }
                  Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
                } else {
                  Fluttertoast.showToast(
                    msg: 'No tienes roles asignados',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                  );
                }
              });
            }  
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state){
                final responseState = state.response;
                if (responseState is Loading) {
                  return Stack(
                    children: [
                      LoginContent(_bloc, state),
                      Center(child: CircularProgressIndicator())
                    ],
                  );
                }
                return LoginContent(_bloc, state);
              }
            ),
          ),
        )
    );
  }


}