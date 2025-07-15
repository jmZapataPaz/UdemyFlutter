import 'package:ecommerce_flutter/presentation/pages/auth/login/LoginBlocCubit.dart';
import 'package:ecommerce_flutter/presentation/widgets/DefaultTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginContent extends StatelessWidget {

  LoginBlocCubit? bloc;
  LoginContent(this.bloc);


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
    Image.asset(
          'assets/img/background1.jpg',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height, //acceder al tamaño de la pantalla maximo
          fit: BoxFit.cover, //para que ocupe todo el espacio
          color: Colors.black54,
          colorBlendMode: BlendMode.darken, //para que se oscurezca un poco
        ),
        Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.3),
            borderRadius: BorderRadius.all(
                Radius.circular(25)
              ),
          ),
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.75,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20), // Espacio superior
                Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 125,
                ),
                Text("Login",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: StreamBuilder(
                    stream: bloc?.emailStream,
                    builder: (context, asyncSnapshot) {
                      return DefaultTextField(
                        label: "Correo Electrónico", 
                        icon: Icons.email, 
                        errorText: asyncSnapshot.hasError? asyncSnapshot.error.toString(): null,
                        onChanded: (text){
                          bloc?.changeEmail(text);
                        }
                        );
                    }
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: StreamBuilder(
                    stream: bloc?.passwordStream,
                    builder: (context, asyncSnapshot) {
                      return DefaultTextField(
                        label: "Contraseña", 
                        icon: Icons.lock, 
                        errorText: asyncSnapshot.hasError? asyncSnapshot.error.toString(): null,
                        onChanded: (text){
                          bloc?.changePassword(text);
                        },
                        obscureText: true,
                        );
                    }
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  margin: EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
                  child: StreamBuilder(
                    stream: bloc?.ValidateForm,
                    builder: (context, asyncSnapshot) {
                      return ElevatedButton(
                        onPressed: (){
                          if(asyncSnapshot.hasData){
                            bloc?.login();
                          }
                          else{
                            Fluttertoast. showToast(msg: 'El formulario no es válido',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                            );
                          }
                        }, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green
                        ),
                        child: Text("Iniciar Sesión", style: TextStyle(
                          color: Colors.white,
                        ),),
                      );
                    }
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 55,
                      height: 1,
                      color: Colors.white ,
                      margin: EdgeInsets.only(right: 5),
                    ),
                    Text("¿No tienes cuenta?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17
                      ),
                    ),
                    Container(
                      width: 55,
                      height: 1,
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 5),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  margin: EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 20),                        
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, 'Register');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black
                      ), 
                      child: Text("Regístrate",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}