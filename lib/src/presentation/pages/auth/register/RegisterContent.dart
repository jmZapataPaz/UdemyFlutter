import 'package:ecommerce_flutter/src/presentation/pages/auth/register/RegisterBlocCubit.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/DefaultButton.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/DefaultIconBack.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/DefaultTextField.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterContent extends StatelessWidget {

  RegisterBlocCubit? bloc;
  RegisterContent(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/img/background2.jpg',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
          color: Color.fromRGBO(0, 0, 0, 0.7),
          colorBlendMode: BlendMode.darken,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.3),
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 60),
                    Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 100,
                    ),
                    Text(
                      "Registro",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                      child: StreamBuilder(
                        stream: bloc?.nameStream,
                        builder: (context, asyncSnapshot) {
                          return DefaultTextField(
                            label: 'Nombre',
                            icon: Icons.person,
                            onChanded: (text) {
                              bloc?.changeName(text);
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: StreamBuilder(
                        stream: bloc?.lastnameStream,
                        builder: (context, asyncSnapshot) {
                          return DefaultTextField(
                            label: 'Apellido',
                            icon: Icons.person,
                            //errorText: asyncSnapshot.hasError? asyncSnapshot.error.toString(): null,
                            onChanded: (text) {
                              bloc?.changeLastname(text);
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: StreamBuilder(
                        stream: bloc?.phoneStream,
                        builder: (context, asyncSnapshot) {
                          return DefaultTextField(
                            label: 'Teléfono',
                            icon: Icons.phone,
                            errorText: asyncSnapshot.hasError ? asyncSnapshot.error.toString() : null,
                            onChanded: (text) {
                              bloc?.changePhone(text);
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: StreamBuilder(
                        stream: bloc?.emailStream,
                        builder: (context, asyncSnapshot) {
                          return DefaultTextField(
                            label: 'Correo Electrónico',
                            icon: Icons.email,
                            errorText: asyncSnapshot.hasError ? asyncSnapshot.error.toString() : null,
                            onChanded: (text) {
                              bloc?.changeEmail(text);
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: StreamBuilder(
                        stream: bloc?.passwordStream,
                        builder: (context, asyncSnapshot) {
                          return DefaultTextField(
                            label: 'Contraseña',
                            icon: Icons.lock,
                            errorText: asyncSnapshot.hasError ? asyncSnapshot.error.toString() : null,
                            obscureText: true,
                            onChanded: (text) {
                              bloc?.changePassword(text);
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: StreamBuilder(
                        stream: bloc?.confirmPasswordStream,
                        builder: (context, asyncSnapshot) {
                          return DefaultTextField(
                            label: 'Confirmar Contraseña',
                            icon: Icons.lock_outline,
                            errorText: asyncSnapshot.hasError ? asyncSnapshot.error.toString() : null,
                            obscureText: true,
                            onChanded: (text) {
                              bloc?.changeConfirmPassword(text);
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                      child: StreamBuilder(
                        stream: bloc?.validateForm,
                        builder: (context, asyncSnapshot) {
                          return DefaultButton(
                            text: "registrarse",
                            onPressed: () {
                              if (asyncSnapshot.hasData) {
                                bloc?.register();
                              } else {
                                Fluttertoast.showToast(
                                  msg: 'El formulario no es válido',
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: DefaultIconBack(
            left: 0,
            top: 0,
          ),
        ),
      ],
    );
  }
}