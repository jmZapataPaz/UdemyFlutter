import 'package:ecommerce_flutter/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_flutter/src/domain/useCases/address/AddressUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/authUseCases.dart';
import 'package:ecommerce_flutter/src/domain/utils/BlocFormItem.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/create/bloc/ClientAddressCreateEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/create/bloc/ClientAddressCreateState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientAddressCreateBloc extends Bloc<ClientAddressCreateEvent, ClientAddressCreateState> {

  AddressUseCase addressUseCase;
  AuthUseCases authUseCases;

  ClientAddressCreateBloc(this.addressUseCase, this.authUseCases) : super(ClientAddressCreateState()){
    on<ClientAddressCreateInitEvent>(_onClientAddressCreateInitEvent);
    on<AddressChanged>(_onAddressChanged);
    on<NeighborhoodChanged>(_onNeighborhoodChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onClientAddressCreateInitEvent(ClientAddressCreateInitEvent event, Emitter<ClientAddressCreateState> emit) async {
    AuthResponse? authResponse = await authUseCases.getUserSession.run(); 
    emit(
      state.copyWith(
        formKey: formKey,
        
      )
    );
    if (authResponse != null) {
      emit(
        state.copyWith(
          idUser: authResponse.user.id,
          formKey: formKey,
        )
      );
    } else {
      emit(
        state.copyWith(
          response: Error('No user session found'),
          formKey: formKey,
        )
      );
    }
  }

  Future<void> _onAddressChanged(AddressChanged event, Emitter<ClientAddressCreateState> emit) async {
    emit(
      state.copyWith(
        address: BlocFormItem(
          value: event.address.value, 
          error: event.address.value.isNotEmpty ? null : event.address.error
        ),
        formKey: formKey,
        
      )
    );
  }

  Future<void> _onNeighborhoodChanged(NeighborhoodChanged event, Emitter<ClientAddressCreateState> emit) async {
    emit(
      state.copyWith(
        neighborhood: BlocFormItem(
          value: event.neighborhood.value, 
          error: event.neighborhood.value.isNotEmpty ? null : event.neighborhood.error
        ),
        formKey: formKey,
        
      )
    );
  }

  Future<void> _onFormSubmitted(FormSubmitted event, Emitter<ClientAddressCreateState> emit) async {

    emit(
      state.copyWith(
        response: Loading(),
        formKey: formKey,
      )
    );

    Resource response = await addressUseCase.createaddressUseCase.run(state.toAddress());
    emit(
      state.copyWith(
        response: response,
        formKey: formKey,
      )
    );


  }

}