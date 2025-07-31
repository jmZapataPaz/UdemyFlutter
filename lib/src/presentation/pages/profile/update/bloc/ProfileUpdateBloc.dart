import 'dart:io';

import 'package:ecommerce_flutter/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_flutter/src/domain/models/User.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/authUseCases.dart';
import 'package:ecommerce_flutter/src/domain/useCases/user/UserUseCase.dart';
import 'package:ecommerce_flutter/src/domain/utils/BlocFormItem.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/profile/update/bloc/ProfileUpdateEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/profile/update/bloc/ProfileUpdateState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUpdateBloc extends Bloc<ProfileUpdateEvent, ProfileUpdateState>{
  UserUseCase userUseCase;
  AuthUseCases authUseCase;
  final formKey = GlobalKey<FormState>();

  ProfileUpdateBloc(this.userUseCase, this.authUseCase): super(ProfileUpdateState()){
    on<ProfileUpdateInitEvent>(_onInitEvent);
    on<ProfileUpdateNameChanged>(_onNameChanged);
    on<ProfileUpdateLastNameChanged>(_onLastNameChanged);
    on<ProfileUpdatePhoneChanged>(_onPhoneChanged);
    on<ProfileUpdatePickImage>(_onPickImage);
    on<ProfileUpdateTakePhoto>(_onTakePhoto);
    on<ProfileUpdateFormSubmitted>(_onFormSubmitted); 
    on<ProfileUpdateUpdateUserSession>(_onUpdateUserSession);
    on<ProfileUpdateResetEvent>(_onProfileUpdateResetEvent);
  }

  Future<void> _onInitEvent(ProfileUpdateInitEvent event, Emitter<ProfileUpdateState> emit) async {
    emit(
      state.copyWith(
        id: event.user?.id,
        name: BlocFormItem(value: event.user?.name ?? ''),
        lastname: BlocFormItem(value: event.user?.lastname ?? ''),
        phone: BlocFormItem(value: event.user?.phone ?? ''),
        image: null,
        formKey: formKey
      )
    );
  }

  Future<void> _onNameChanged(ProfileUpdateNameChanged event, Emitter<ProfileUpdateState> emit) async {

    emit(
      state.copyWith(
        name: BlocFormItem(
          value: event.name.value,
          error: event.name.value.isEmpty ? null : 'Ingresa el nombre '
        ),
        formKey: formKey
      )
    );
  }

  Future<void> _onLastNameChanged(ProfileUpdateLastNameChanged event, Emitter<ProfileUpdateState> emit) async {
    emit(
      state.copyWith(
        lastname: BlocFormItem(
          value: event.lastname.value,
          error: event.lastname.value.isEmpty ? null : 'Ingresa el apellido '
        ),
        formKey: formKey
      )
    );
  }

  Future<void> _onPhoneChanged(ProfileUpdatePhoneChanged event, Emitter<ProfileUpdateState> emit) async {
    emit(
      state.copyWith(
        phone: BlocFormItem(
          value: event.phone.value,
          error: event.phone.value.isEmpty ? null : 'Ingresa el teléfono '
        ),
        formKey: formKey
      )
    );
  }

  Future<void> _onPickImage(ProfileUpdatePickImage event, Emitter<ProfileUpdateState> emit) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(
        state.copyWith(
          image: File(image.path),
          formKey: formKey
        )
      );
    } 
  }

  Future<void> _onTakePhoto(ProfileUpdateTakePhoto event, Emitter<ProfileUpdateState> emit) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      emit(
        state.copyWith(
          image: File(image.path),
          formKey: formKey
        )
      );
    } 
  }

  Future<void> _onFormSubmitted(ProfileUpdateFormSubmitted event, Emitter<ProfileUpdateState> emit) async {
    print('Id ${state.id}');
    print('Name ${state.name.value}');
    print('LastName ${state.lastname.value}');
    print('Phone ${state.phone.value}');
    emit(
      state.copyWith(
        response: Loading(),
        formKey: formKey
      )
    );
    Resource response = await userUseCase.updateUserUsecase.run(state.id, 
    state.toUser(), 
    state.image);
    emit(
      state.copyWith(
        response: response,
        formKey: formKey
      )
    );
  }

  Future<void> _onUpdateUserSession(ProfileUpdateUpdateUserSession event, Emitter<ProfileUpdateState> emit) async {
    AuthResponse authResponse = await authUseCase.getUserSession.run();
    authResponse.user.name = event.user.name;
    authResponse.user.lastname = event.user.lastname;
    authResponse.user.phone = event.user.phone;
    authResponse.user.image = event.user.image;
    await authUseCase.saveUserSession.run(authResponse);
    print('Usuario actualizado en la sesión: ${event.user.toJson()}');
  }

  Future<void> _onProfileUpdateResetEvent(ProfileUpdateResetEvent event, Emitter<ProfileUpdateState> emit) async {
    emit(ProfileUpdateState()); 
  }
}