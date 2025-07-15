import 'package:ecommerce_flutter/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_flutter/src/domain/models/User.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/authUseCases.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/register/RegisterBlocState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBlocCubit extends Cubit<RegisterBlocState> {

  AuthUseCases authUseCases;
  
  RegisterBlocCubit(this.authUseCases) : super(RegisterInitialState());

  final _nameController = BehaviorSubject<String>();
  final _lastnameController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _confirmPasswordController = BehaviorSubject<String>();
  final _responseController = BehaviorSubject<Resource>();

  Stream<bool> get validateForm => Rx.combineLatest6(
    nameStream,
    lastnameStream,
    phoneStream,
    emailStream,
    passwordStream,
    confirmPasswordStream, (a, b, c, d, e, f) => true
  );

  toUser() => User(
    name: _nameController.value, 
    lastname: _lastnameController.value, 
    email: _emailController.value, 
    phone: _phoneController.value, 
    password: _passwordController.value,
  );

  //metodo register
  void register() async{
    _responseController.add(Loading());
    Resource<AuthResponse> response = await authUseCases.register.run(toUser());
    _responseController.add(response);
    User userData = toUser();

    print('User data: ${userData.toJson()}'); 

    //en caso de bug de mensajes repetidos descomentar estas lineas
    await Future.delayed(Duration(seconds: 2));
    _responseController.add(Initial());

  }
  

  Stream<String> get nameStream => _nameController.stream;
  Stream<String> get lastnameStream => _lastnameController.stream;
  Stream<String> get phoneStream => _phoneController.stream;
  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get passwordStream => _passwordController.stream;
  Stream<String> get confirmPasswordStream => _confirmPasswordController.stream;
  Stream<Resource> get responseStream => _responseController.stream;

  //aqui sirve para poner las validaciones

  void changeName(String name) {
    if (name.isEmpty) {
      _nameController.sink.addError('El nombre no puede estar vacío');
    } else {
      _nameController.sink.add(name);
    }
  }

  void changeLastname(String lastname) {
    if (lastname.isEmpty) {
      _lastnameController.sink.addError('El apellido no puede estar vacío');
    } else {
      _lastnameController.sink.add(lastname);
    }
  }

  void changePhone(String phone){
    if (phone.isNotEmpty && phone.length < 8){
      _phoneController.sink.addError('El número de teléfono debe tener al menos 8 dígitos');
    } else {
      _phoneController.sink.add(phone);
    }
  }


  void changeEmail(String email) {
        final bool emailFormatValid = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    ).hasMatch(email);
    if (!emailFormatValid && email.isNotEmpty) {
      _emailController.sink.addError('El email no es válido');
    } 
    else {
      _emailController.sink.add(email);
    }
  }

  void changePassword(String password) {
    if (password.length < 6 && password.isNotEmpty) {
      _passwordController.sink.addError('La contraseña debe tener al menos 6 caracteres');
    }
    else {
      _passwordController.sink.add(password);
    }  
  }

  void changeConfirmPassword(String confirmPassword) {
    if (confirmPassword != _passwordController.valueOrNull && confirmPassword.isNotEmpty) {
      _confirmPasswordController.sink.addError('Las contraseñas no coinciden');
    } 
    else {
      _confirmPasswordController.sink.add(confirmPassword);
    }
  }

  void dispose(){
    changeName('');
    changeLastname('');
    changePhone('');
    changeEmail('');
    changePassword('');
    changeConfirmPassword('');

  }



}