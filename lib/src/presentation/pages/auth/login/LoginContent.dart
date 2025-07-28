import 'package:ecommerce_flutter/src/domain/utils/BlocFormItem.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/login/bloc/LoginState.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/DefaultTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginContent extends StatelessWidget {

  LoginBloc? bloc;
  LoginState state;
  LoginContent(this.bloc, this.state);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    bool isTablet = screenWidth > 600;
    
    return Form(
      key: state.formKey,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _imageBackground(context),
          SingleChildScrollView(
            child: Container(
              height: screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _cardLoginForm(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardLoginForm(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    bool isTablet = screenWidth > 600;
    
    return Container(
      width: screenWidth * (isTablet ? 0.7 : 0.85),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.3),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * (isTablet ? 0.04 : 0.03)),
            _iconPerson(context),
            _textlogin(context),
            SizedBox(height: screenHeight * (isTablet ? 0.03 : 0.025)),
            _textFieldEmail(context),
            _textFieldPassword(context),
            SizedBox(height: screenHeight * (isTablet ? 0.03 : 0.025)),
            _buttonLogin(context),
            _textDontHaveAccount(context),
            _buttonGoToRegister(context),
            SizedBox(height: screenHeight * (isTablet ? 0.03 : 0.025)),
          ],
        ),
      ),
    );
  }

  Widget _iconPerson(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Icon(
      Icons.person,
      color: Colors.white,
      size: screenWidth * (isTablet ? 0.15 : 0.25),
    );
  }

  Widget _textlogin(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      margin: EdgeInsets.only(bottom: screenWidth * (isTablet ? 0.02 : 0.03)),
      child: Text(
        "Login",
        style: TextStyle(
          fontSize: screenWidth * (isTablet ? 0.05 : 0.075),
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _textFieldEmail(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * (isTablet ? 0.08 : 0.06),
        vertical: screenWidth * (isTablet ? 0.015 : 0.02),
      ),
      child: Transform.scale(
        scale: isTablet ? 1.2 : 1.0,
        child: DefaultTextField(
          label: "Correo Electrónico", 
          icon: Icons.email, 
          onChanded: (text){
            bloc?.add(EmailChanged(email: BlocFormItem(value: text)));
          },
          validator: (value){
            return state.email.error;
          },                      
        ),
      ),
    );
  }

  Widget _textFieldPassword(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * (isTablet ? 0.08 : 0.06),
        vertical: screenWidth * (isTablet ? 0.015 : 0.02),
      ),
      child: Transform.scale(
        scale: isTablet ? 1.2 : 1.0,
        child: DefaultTextField(
          label: "Contraseña", 
          icon: Icons.lock, 
          onChanded: (text){
            bloc?.add(PasswordChanged(password: BlocFormItem(value: text)));
          },
          obscureText: true,
          validator: (value){
            return state.password.error;
          },
        ),
      ),
    );
  }

  Widget _buttonLogin(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    bool isTablet = screenWidth > 600;
    
    return Container(
      width: double.infinity,
      height: screenHeight * (isTablet ? 0.06 : 0.07),
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * (isTablet ? 0.08 : 0.06),
        vertical: screenWidth * (isTablet ? 0.02 : 0.025),
      ),
      child: ElevatedButton(
        onPressed: (){
          if(state.formKey!.currentState!.validate()){
            bloc?.add(LoginSubmit());
          }else{
            Fluttertoast.showToast(
              msg: 'El formulario no es válido',
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
        child: Text(
          "Iniciar Sesión", 
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * (isTablet ? 0.035 : 0.045),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _textDontHaveAccount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: screenWidth * (isTablet ? 0.02 : 0.025)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: screenWidth * (isTablet ? 0.08 : 0.12),
            height: 1,
            color: Colors.white,
            margin: EdgeInsets.only(right: screenWidth * 0.02),
          ),
          Text(
            "¿No tienes cuenta?",
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * (isTablet ? 0.03 : 0.04),
            ),
          ),
          Container(
            width: screenWidth * (isTablet ? 0.08 : 0.12),
            height: 1,
            color: Colors.white,
            margin: EdgeInsets.only(left: screenWidth * 0.02),
          ),
        ],
      ),
    );
  }

  Widget _buttonGoToRegister(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    bool isTablet = screenWidth > 600;
    
    return Container(
      width: double.infinity,
      height: screenHeight * (isTablet ? 0.06 : 0.07),
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * (isTablet ? 0.08 : 0.06),
        vertical: screenWidth * (isTablet ? 0.015 : 0.02),
      ),
      child: ElevatedButton(
        onPressed: (){
          Navigator.pushNamed(context, 'register');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black
        ), 
        child: Text(
          "Regístrate",
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * (isTablet ? 0.035 : 0.045),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _imageBackground(BuildContext context) {
    return Image.asset(
      'assets/img/background1.jpg',
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
      color: Colors.black54,
      colorBlendMode: BlendMode.darken,
    );
  }
}