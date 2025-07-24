import 'package:ecommerce_flutter/src/domain/models/Product.dart';
import 'package:ecommerce_flutter/src/domain/useCases/shoppingBag/ShoppingBagUseCase.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/detail/bloc/ClientProductDetailEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/detail/bloc/ClientProductDetailState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientProductDetailBloc extends Bloc<ClientProductDetailEvent, ClientProductDetailState>{
  
  ShoppingBagUseCases shoppingBagUseCases;
  ClientProductDetailBloc(this.shoppingBagUseCases): super(ClientProductDetailState()){
    on<GetProducts>(_onGetProducts);
    on<AddItem>(_onAddItem);
    on<SubTractItem>(_onSubTractItem);
    on<AddProductToShoppingBag>(_onAddProductToShoppingBag);
    on<ResetState>(_onResetState);
    
  }

  Future<void> _onResetState(ResetState event, Emitter<ClientProductDetailState> emit) async{
    emit(
      state.copyWith(
        quantity: 0
      )
    );
  }

  Future<void> _onGetProducts(GetProducts event, Emitter<ClientProductDetailState> emit) async{
    List<Product> products = await shoppingBagUseCases.getProductShoppingBagUseCase.run();
    int index = products.indexWhere((p) => p.id == event.product.id);
    if (index != -1) {
      emit(state.copyWith(
        quantity: products[index].quantity ?? 0
      ));
    } else {
      emit(state.copyWith(
        quantity: 0
      ));
    }
  }

  Future<void> _onAddItem(AddItem event, Emitter<ClientProductDetailState> emit) async{
    emit(state.copyWith(
      quantity: state.quantity + 1
    ));
  }

  Future<void> _onSubTractItem(SubTractItem event, Emitter<ClientProductDetailState> emit) async{
    if(state.quantity >=1){
      emit(state.copyWith(
        quantity: state.quantity - 1
      ));
    }
    
  }

  Future<void> _onAddProductToShoppingBag(AddProductToShoppingBag event, Emitter<ClientProductDetailState> emit) async{
    if (state.quantity <= 0) {
      return;
    }
    
    event.product.quantity = state.quantity;
    await shoppingBagUseCases.addShoppingBagUseCase.run(event.product);
    emit(state.copyWith(productAdded: true));
    
    await Future.delayed(Duration(milliseconds: 100));
    emit(state.copyWith(productAdded: false));
  }    
    


}