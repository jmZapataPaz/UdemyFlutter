import 'package:ecommerce_flutter/src/domain/useCases/orders/OrdersUseCases.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/detail/bloc/DriverOrderDetailEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/driver/order/detail/bloc/DriverOrderDetailState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverOrderDetailBloc extends Bloc<DriverOrderDetailEvent, DriverOrderDetailState> {

  OrdersUseCases ordersUseCases;

  DriverOrderDetailBloc(this.ordersUseCases): super(DriverOrderDetailState()) {
    on<UpdateStatusOrder>(_onUpdateStatusOrder);
  } 

  Future<void> _onUpdateStatusOrder(UpdateStatusOrder event, Emitter<DriverOrderDetailState> emit) async {
    emit(
      state.copyWith(
        response: Loading()
      )
    );
    Resource response = await ordersUseCases.updateStatus.run(event.id, event.status);
    emit(
      state.copyWith(
        response: response
      )
    );
  }

}