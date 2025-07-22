import 'dart:convert';

import 'package:ecommerce_flutter/src/data/api/ApiConfig.dart';
import 'package:ecommerce_flutter/src/domain/models/Address.dart';
import 'package:ecommerce_flutter/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_flutter/src/domain/useCases/address/AddressUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/authUseCases.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/list/bloc/ClientAddressListEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/list/bloc/ClientAddressListState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ClientAddressListBloc extends Bloc<ClientAddressListEvent, ClientAddressListState>{

  AddressUseCase addressUseCase;
  AuthUseCases authUseCases;

  ClientAddressListBloc(this.addressUseCase, this.authUseCases): super(ClientAddressListState()) {
    on<GetUserAddress>(_onGetUserAddress);
    on<ChangeRadioValue>(_onChangeRadioValue);
    on<SetAddressSession>(_onSetAddressSession);
    on<DeleteAddress>(_onDeleteAddress);
    on<OnPaymentStripeSubmit>(_onPaymentStripeSubmit);
  }


  Future<void> _onGetUserAddress(GetUserAddress event, Emitter<ClientAddressListState> emit) async {
    AuthResponse? authResponse = await authUseCases.getUserSession.run();
    if(authResponse != null){
      emit(
      state.copyWith(
        response: Loading()
        )
      );
    }
    
    Resource response = await addressUseCase.getUserAddressUseCase.run(authResponse!.user.id!);
    emit(
      state.copyWith(
        response: response
      )
    );
  }

  Future<void> _onChangeRadioValue(ChangeRadioValue event, Emitter<ClientAddressListState> emit) async {
    emit(
      state.copyWith(
        radioValue: event.radioValue
      )
    );
    await addressUseCase.saveAddressInSessionUseCase.run(event.address);
  }


  Future<void> _onSetAddressSession(SetAddressSession event, Emitter<ClientAddressListState> emit) async {
    Address? addressSession = await addressUseCase.getAddressSesionUseCase.run();
    if(addressSession != null) {
      int index = event.addressList.indexWhere((address) => address.id == addressSession.id);
      if(index != -1) {
        emit(
          state.copyWith(
            radioValue: index,
          )
        );
      }
    }
  }


  Future<void> _onDeleteAddress(DeleteAddress event, Emitter<ClientAddressListState> emit) async {
   emit(
      state.copyWith(
        response: Loading()
      )
    );
    Resource<bool> response = await addressUseCase.deleteAddressUseCase.run(event.id);
    emit(
      state.copyWith(
        response: response
      )
    );
    Address? addressSession = await addressUseCase.getAddressSesionUseCase.run();
    if(addressSession != null && addressSession.id == event.id) {
      await addressUseCase.deleteAddressSessionUseCase.run();
      emit(
        state.copyWith(
          radioValue: null
        )
      );
    }
  }

  Future<void> _onPaymentStripeSubmit(OnPaymentStripeSubmit event, Emitter<ClientAddressListState> emit) async {
    final response = await http.post(
      Uri.parse('https://${ApiConfig.NGROK_URL}/payment_stripe/create'),
    );
    if(response.statusCode == 200) {
      final url = jsonDecode(response.body)['checkout_url'];
      if (await canLaunchUrl(Uri.parse(url))){
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }
      else {
        throw 'Could not launch $url';
      }
    }
    else{
      throw 'Failed to create payment session: ${response.statusCode}';
    }
  }
}