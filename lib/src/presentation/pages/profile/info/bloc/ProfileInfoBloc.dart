import 'package:ecommerce_flutter/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/authUseCases.dart';
import 'package:ecommerce_flutter/src/presentation/pages/profile/info/bloc/ProfileInfoEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/profile/info/bloc/ProfileInfoState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileInfoBloc extends Bloc<ProfileInfoEvent, ProfileInfoState>{
  AuthUseCases  authUseCases;

  ProfileInfoBloc(this.authUseCases) : super(const ProfileInfoState()){
    on<ProfileInfoGetUser>(_onProfileInfoGetUser);
  }

  Future<void> _onProfileInfoGetUser(ProfileInfoGetUser event, Emitter<ProfileInfoState> emit) async {
    AuthResponse authResponse = await authUseCases.getUserSession.run();
    emit(
      state.copyWith(
        user: authResponse.user,
      )
    );
  }
}