import 'package:ecommerce_flutter/src/domain/models/Product.dart';
import 'package:ecommerce_flutter/src/domain/useCases/shoppingBag/ShoppingBagUseCase.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/shoppingBag/Bloc/ClientShoppingBagEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/shoppingBag/Bloc/ClientShoppingBagState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientShoppingBagBloc extends Bloc<ClientShoppingBagEvent, ClientShoppingBagState> {

  ShoppingBagUseCases shoppingBagUseCases;

  ClientShoppingBagBloc(this.shoppingBagUseCases) : super(ClientShoppingBagState()) {
    on<GetShoppingBag>(_onGetShoppingBag);
    on<AddItem>(_onAddItem);
    on<SubTractItem>(_onSubTractItem);
    on<RemoveItem>(_onRemoveItem);
    on<GetTotal>(_onGetTotal);
  }
  Future<void> _onGetShoppingBag(GetShoppingBag event, Emitter<ClientShoppingBagState> emit) async {
    
    List<Product> products = await shoppingBagUseCases.getProductShoppingBagUseCase.run();
    emit(
      state.copyWith(
        products: products
        )
      );
     add(GetTotal()); 

  }

  Future<void> _onAddItem(AddItem event, Emitter<ClientShoppingBagState> emit) async {
    event.product.quantity = event.product.quantity! +1;
    await shoppingBagUseCases.addShoppingBagUseCase.run(event.product);
    add(GetShoppingBag());
  }

  Future<void> _onSubTractItem(SubTractItem event, Emitter<ClientShoppingBagState> emit) async {
    if(event.product.quantity! > 1) {
      event.product.quantity = event.product.quantity! - 1;
      await shoppingBagUseCases.addShoppingBagUseCase.run(event.product);
      add(GetShoppingBag());
    }
  }

  Future<void> _onRemoveItem(RemoveItem event, Emitter<ClientShoppingBagState> emit) async {
    await shoppingBagUseCases.deleteItemShoppingBagUseCase.run(event.product);
    add(GetShoppingBag());
  }

  Future<void> _onGetTotal(GetTotal event, Emitter<ClientShoppingBagState> emit) async {

    double total = await shoppingBagUseCases.getTotalShoppingBagUseCase.run();
    emit(
      state.copyWith(
        total: total
      )
    );
  }


}