import 'dart:convert';
import 'package:ecommerce_flutter/injection.dart';
import 'package:ecommerce_flutter/src/domain/useCases/shoppingBag/ShoppingBagUseCase.dart';
import 'package:ecommerce_flutter/src/domain/models/Order.dart';
import 'package:ecommerce_flutter/src/data/api/ApiConfig.dart';
import 'package:ecommerce_flutter/src/domain/models/Address.dart';
import 'package:ecommerce_flutter/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_flutter/src/domain/useCases/address/AddressUseCase.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/authUseCases.dart';
import 'package:ecommerce_flutter/src/domain/useCases/orders/OrdersUseCases.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/list/bloc/ClientAddressListEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/list/bloc/ClientAddressListState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ClientAddressListBloc extends Bloc<ClientAddressListEvent, ClientAddressListState>{

  AddressUseCase addressUseCase;
  AuthUseCases authUseCases;
  OrdersUseCases ordersUseCases;

  ClientAddressListBloc(this.addressUseCase, this.authUseCases, this.ordersUseCases): super(ClientAddressListState()) {
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

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final url = body['checkout_url'];
      final sessionId = body['session_id']; 

      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        await _waitAndVerifyPayment(emit, sessionId); 
      } else {
        throw 'Could not launch $url';
      }
    } else {
      throw 'Failed to create payment session: ${response.statusCode}';
    }
  }

  Future<void> _waitAndVerifyPayment(Emitter<ClientAddressListState> emit, String sessionId) async {
    await Future.delayed(Duration(seconds: 10));
    int attempts = 0;
    const maxAttempts = 12;

    while (attempts < maxAttempts) {
      try {
        final verifyResponse = await http.get(
          Uri.parse('https://${ApiConfig.NGROK_URL}/payment_stripe/success?session_id=$sessionId&json=1'),
        );
        if (verifyResponse.statusCode == 200) {
          final data = jsonDecode(verifyResponse.body);
          print('Verificando pago: $data');
          if (data['payment_status'] == 'success') {
            await _createOrderAfterPayment(emit);
            return;
          }
        }
        attempts++;
        if (attempts < maxAttempts) {
          await Future.delayed(Duration(seconds: 10));
        }
      } catch (e) {
        attempts++;
        await Future.delayed(Duration(seconds: 10));
      }
    }
    emit(state.copyWith(response: Error('Tiempo agotado esperando el pago')));
  }
  Future<void> _createOrderAfterPayment(Emitter<ClientAddressListState> emit) async {
    emit(state.copyWith(response: Loading()));
    try {
      final userSession = await authUseCases.getUserSession.run();
      final selectedAddress = await addressUseCase.getAddressSesionUseCase.run();
      final shoppingBagUseCases = locator<ShoppingBagUseCases>();
      final products = await shoppingBagUseCases.getProductShoppingBagUseCase.run();
      
      final productsList = products.map<Map<String, dynamic>>((p) => {
        "id": p.id,
        "quantity": p.quantity ?? 1,
      }).toList();

      final order = Order(
        id: 0,
        idClient: userSession.user.id,
        idAddress: selectedAddress!.id!,
        status: "PAGADO", 
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        user: null,
        address: null,
        orderHasProducts: null,
        productsToCreate: productsList, 
      );
      final response = await ordersUseCases.createOrder.run(order);
      emit(state.copyWith(response: response));
      
    } catch (e) {
      emit(state.copyWith(response: Error('Error creando la orden: $e')));
    }
  }
}