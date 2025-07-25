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
                  _cardRegisterForm(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardRegisterForm(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    bool isTablet = screenWidth > 600;
    
    return Container(
      width: screenWidth * (isTablet ? 0.7 : 0.85),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.3),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight * (isTablet ? 0.04 : 0.05)),
                _iconPerson(context),
                _textRegister(context),
                _textFieldName(context),
                _textFieldLastName(context),
                _textFieldPhone(context),
                _textFieldEmail(context),
                _textFieldPassword(context),
                _textFieldConfirmPassword(context),
                _buttonRegister(context),
                SizedBox(height: screenHeight * (isTablet ? 0.03 : 0.04)),
              ],
            ),
          ),
          Positioned(
            top: screenWidth * (isTablet ? 0.02 : 0.03),
            left: screenWidth * (isTablet ? 0.02 : 0.03),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: screenWidth * (isTablet ? 0.06 : 0.07),
              ),
            ),
          ),
        ],
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

  Widget _textRegister(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    return Container(
      margin: EdgeInsets.only(bottom: screenWidth * (isTablet ? 0.03 : 0.04)),
      child: Text(
        "Registro",
        style: TextStyle(
          fontSize: screenWidth * (isTablet ? 0.05 : 0.075),
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _textFieldName(BuildContext context) {
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
          label: 'Nombre',
          icon: Icons.person,
          onChanded: (text) {
            bloc?.add(RegisterNameChanged(name: BlocFormItem(value: text)));
          },
          validator: (value) {
            return state.name.error;
          },
        ),
      ),
    );
  }

  Widget _textFieldLastName(BuildContext context) {
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
          label: 'Apellido',
          icon: Icons.person,
          onChanded: (text) {
            bloc?.add(RegisterLastNameChanged(lastName: BlocFormItem(value: text)));
          },
          validator: (value) {
            return state.lastName.error;
          },
        ),
      ),
    );
  }

  Widget _textFieldPhone(BuildContext context) {
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
          label: 'Teléfono',
          icon: Icons.phone,
          onChanded: (text) {
            bloc?.add(RegisterPhoneChanged(phone: BlocFormItem(value: text)));
          },
          validator: (value) {
            return state.phone.error;
          },
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
          label: 'Correo Electrónico',
          icon: Icons.email,
          onChanded: (text) {
            bloc?.add(RegisterEmailChanged(email: BlocFormItem(value: text)));
          },
          validator: (value) {
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
          label: 'Contraseña',
          icon: Icons.lock,
          obscureText: true,
          onChanded: (text) {
            bloc?.add(RegisterPasswordChanged(password: BlocFormItem(value: text)));
          },
          validator: (value) {
            return state.password.error;
          },
        ),
      ),
    );
  }

  Widget _textFieldConfirmPassword(BuildContext context) {
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
          label: 'Confirmar Contraseña',
          icon: Icons.lock_outline,
          obscureText: true,
          onChanded: (text) {
            bloc?.add(RegisterConfirmPasswordChanged(confirmPassword: BlocFormItem(value: text)));
          },
          validator: (value) {
            return state.confirmPassword.error;
          },
        ),
      ),
    );
  }

  Widget _buttonRegister(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    bool isTablet = screenWidth > 600;
    
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * (isTablet ? 0.08 : 0.06),
        vertical: screenWidth * (isTablet ? 0.03 : 0.04),
      ),
      width: double.infinity,
      height: screenHeight * (isTablet ? 0.06 : 0.07),
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
    );
  }

  Widget _imageBackground(BuildContext context) {
    return Image.asset(
      'assets/img/background2.jpg',
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
      color: Color.fromRGBO(0, 0, 0, 0.7),
      colorBlendMode: BlendMode.darken,
    );
  }
}