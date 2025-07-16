import 'package:ecommerce_flutter/src/domain/utils/BlocFormItem.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/register/bloc/RegisterBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/register/bloc/RegisterState.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/DefaultButton.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/DefaultIconBack.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/DefaultTextField.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterContent extends StatelessWidget {

  RegisterBloc? bloc;
  RegisterState state;

  RegisterContent(this.bloc, this.state);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Stack(
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
                        child: DefaultTextField(
                          label: 'Nombre',
                          icon: Icons.person,
                          onChanded: (text) {
                            bloc?.add(RegisterNameChanged(name: 
                              BlocFormItem(value: text),
                            ));
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25),
                        child: DefaultTextField(
                          label: 'Apellido',
                          icon: Icons.person,
                          onChanded: (text) {
                            bloc?.add(RegisterLastNameChanged(lastName: BlocFormItem(value: text)));
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25),
                        child: DefaultTextField(
                          label: 'Teléfono',
                          icon: Icons.phone,
                          onChanded: (text) {
                            bloc?.add(RegisterPhoneChanged(phone: BlocFormItem(value: text)));
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25),
                        child: DefaultTextField(
                          label: 'Correo Electrónico',
                          icon: Icons.email,
                          onChanded: (text) {
                            bloc?.add(RegisterEmailChanged(email: BlocFormItem(value: text)));
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25),
                        child: DefaultTextField(
                          label: 'Contraseña',
                          icon: Icons.lock,
                          obscureText: true,
                          onChanded: (text) {
                            bloc?.add(RegisterPasswordChanged(password: BlocFormItem(value: text)));
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25),
                        child: DefaultTextField(
                          label: 'Confirmar Contraseña',
                          icon: Icons.lock_outline,
                          obscureText: true,
                          onChanded: (text) {
                            bloc?.add(RegisterConfirmPasswordChanged(confirmPassword: BlocFormItem(value: text)));
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                        child: DefaultButton(
                          text: "Registrarse",
                          onPressed: () {
                            if (state.formKey!.currentState!.validate()) {
                              bloc?.add(RegisterFormSubmitted());
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
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: MediaQuery.of(context).size.width * 0.05,
            child: DefaultIconBack(
              left: 0,
              top: 0,
            ),
          ),
        ],
      ),
    );
  }
}