import 'package:ecommerce_flutter/data/DataSource/Remote/Services/AuthService.dart';
import 'package:ecommerce_flutter/domain/models/AuthResponse.dart';
import 'package:ecommerce_flutter/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/presentation/pages/auth/login/LoginBlocState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class LoginBlocCubit extends Cubit<LoginBlocState> {

  LoginBlocCubit() : super(LoginInitial());

  AuthService authService = AuthService();
  
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _responseController = BehaviorSubject<Resource>();

  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get passwordStream => _passwordController.stream;
  Stream<Resource> get responseStream => _responseController.stream;

  void changeEmail(String email) {
    if (email.isNotEmpty && email.length < 6){
      _emailController.sink.addError("No es un Email");
    }
    else {
      _emailController.sink.add(email);
    }
  }
  void changePassword(String password) {
    if (password.isNotEmpty && password.length < 6){
      _passwordController.sink.addError("La longitud minima es de 6 caracteres");
    }
    else {
      _passwordController.sink.add(password);
    }

  }

  Stream<bool> get ValidateForm => Rx.combineLatest2(
    emailStream,
    passwordStream, (a,b) => true
  );

  void dispose() { 
    changeEmail('');
    changePassword('');
  }

  void login() async{ //solo para corroborar que se llama y se captura los datos
    _responseController.add(Loading());
    
    print("Email: ${_emailController.value}");
    print("Password: ${_passwordController.value}");
    //await Future.delayed(Duration(seconds: 4)); para verificar el circular progress indicator
    Resource response = await authService.login(_emailController.value, _passwordController.value);
    _responseController.add(response);

    print ("Response: ${response}");
  }



}