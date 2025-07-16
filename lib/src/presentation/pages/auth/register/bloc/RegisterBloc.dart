import 'package:ecommerce_flutter/src/domain/useCases/auth/authUseCases.dart';
import 'package:ecommerce_flutter/src/domain/utils/BlocFormItem.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/register/bloc/RegisterState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{
  
  AuthUseCases authUseCases;
  
  RegisterBloc(this.authUseCases): super(RegisterState()){
    on<RegisterInitEvent>(_onInitEvent);
    on<RegisterNameChanged>(_onNameChanged);
    on<RegisterLastNameChanged>(_onLastNameChanged);
    on<RegisterPhoneChanged>(_onPhoneChanged);
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<RegisterFormSubmitted>(_onRegisterFormSubmitted);
    on<RegisterFormReset>(_onRegisterFormReset);

  }

  final formKey = GlobalKey<FormState>();
  Future<void> _onInitEvent(RegisterInitEvent event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(formKey: formKey));
  }

  Future<void> _onNameChanged(RegisterNameChanged event, Emitter<RegisterState> emit)async{
    emit (
      state.copyWith(
        name: BlocFormItem(
          value: event.name.value,
          error: event.name.value.isNotEmpty ? null : 'Name is required',
        ),
        formKey: formKey
      )
    );
  }



  Future<void> _onLastNameChanged(RegisterLastNameChanged event, Emitter<RegisterState> emit)async{
    emit (
      state.copyWith(
        lastName: BlocFormItem(
          value: event.lastName.value,
          error: event.lastName.value.isNotEmpty ? null : 'Last name is required',
        ),
        formKey: formKey
      )
    );
  }

  Future<void> _onPhoneChanged(RegisterPhoneChanged event, Emitter<RegisterState> emit)async{
    emit (
      state.copyWith(
        phone: BlocFormItem(
          value: event.phone.value,
          error: event.phone.value.isNotEmpty ? null : 'Phone is required',
        ),
        formKey: formKey
      )
    );
  }

  Future<void> _onEmailChanged(RegisterEmailChanged event, Emitter<RegisterState> emit)async{
    emit (
      state.copyWith(
        email: BlocFormItem(
          value: event.email.value,
          error: event.email.value.isNotEmpty ? null : 'Email is required',
        ),
        formKey: formKey
      )
    );
  }

  Future<void> _onPasswordChanged (RegisterPasswordChanged event, Emitter<RegisterState> emit)async{
    emit (
      state.copyWith(
        password: BlocFormItem(
          value: event.password.value,
          error: event.password.value.isNotEmpty && event.password.value.length >=6 ? null : 'Password is required',
        ),
        formKey: formKey
      )
    );
  }

  Future<void> _onConfirmPasswordChanged (RegisterConfirmPasswordChanged event, Emitter<RegisterState> emit)async{
    emit (
      state.copyWith(
        confirmPassword: BlocFormItem(
          value: event.confirmPassword.value,
          error: event.confirmPassword.value.isNotEmpty && event.confirmPassword.value == state.password.value ? null : 'Passwords do not match',
        ),
        formKey: formKey
      )
    );
  }



  Future<void> _onRegisterFormSubmitted (RegisterFormSubmitted event, Emitter<RegisterState> emit)async{
    emit(state.copyWith(
        response: Loading(),
        formKey: formKey,
      )
    );
    Resource response = await authUseCases.register.run(state.toUser());
    emit(state.copyWith(
        response: response,
        formKey: formKey,
      )
    );
  }

  Future<void> _onRegisterFormReset(RegisterFormReset event, Emitter<RegisterState> emit) async {
    state.formKey?.currentState?.reset();
  }
}