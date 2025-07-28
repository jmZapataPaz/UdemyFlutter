import 'package:ecommerce_flutter/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_flutter/src/domain/useCases/auth/authUseCases.dart';
import 'package:ecommerce_flutter/src/domain/useCases/orders/OrdersUseCases.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/list/bloc/DriverOrderListEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/list/bloc/DriverOrderListState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverOrderListBloc extends Bloc<DriverOrderListEvent, DriverOrderListState> {

  OrdersUseCases ordersUseCases;
  AuthUseCases authUseCases;

  DriverOrderListBloc(this.ordersUseCases, this.authUseCases): super(const DriverOrderListState(selectedFilter: 'TODOS')) {
    on<GetOrders>(_onGetOrders);
    on<FilterByStatus>(_onFilterByStatus);
  }

  Future<void> _onGetOrders(GetOrders event, Emitter<DriverOrderListState> emit) async {
    emit(
      state.copyWith(response: Loading())
    );
    
    try {
      AuthResponse authResponse = await authUseCases.getUserSession.run();
      Resource response = await ordersUseCases.getOrders.run();
      
      emit(
        state.copyWith(response: response)
      );
    } catch (e) {
      emit(
        state.copyWith(response: Error('Error al cargar órdenes: $e'))
      );
    }
  }

  Future<void> _onFilterByStatus(FilterByStatus event, Emitter<DriverOrderListState> emit) async {
    emit(state.copyWith(selectedFilter: event.status));
  }
}