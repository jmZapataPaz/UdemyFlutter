import 'package:ecommerce_flutter/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/presentation/pages/auth/login/LoginBlocCubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginResponse extends StatelessWidget {

  LoginBlocCubit? bloc;
  LoginResponse(this.bloc);


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc?.responseStream, 
      builder: (context, AsyncSnapshot){
        final state = AsyncSnapshot.data;
        if (state is Loading){
          print('LOADING...');
          return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 8.0,

            ),
          );
        }
        else if(state is Error){
          Fluttertoast.showToast(
            msg: state.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
          );
        }
        else if (state is Success){
          Fluttertoast.showToast(
            msg: 'Login exitoso',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
          );
        }
        return Container();
      }
    );
  }
}