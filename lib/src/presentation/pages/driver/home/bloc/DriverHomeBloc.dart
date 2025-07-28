import 'package:ecommerce_flutter/src/domain/useCases/auth/authUseCases.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/home/bloc/DriverHomeEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/home/bloc/DriverHomeState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverHomeBloc extends Bloc<DriverHomeEvent, DriverHomeState> {
  
  AuthUseCases authUseCases;

  DriverHomeBloc(this.authUseCases) : super(DriverHomeState()) {
    on<ChangeDrawerPage>(_onChangeDrawerPage);
    on<Logout>(_onLogout);
  }

  Future<void> _onChangeDrawerPage(ChangeDrawerPage event, Emitter<DriverHomeState> emit) async {
    emit(state.copyWith(pageIndex: event.pageIndex));
  }

  Future<void> _onLogout(Logout event, Emitter<DriverHomeState> emit) async {
    await authUseCases.logout.run();
  }
}