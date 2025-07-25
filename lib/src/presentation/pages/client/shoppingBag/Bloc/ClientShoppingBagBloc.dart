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
    on<ClearShoppingBag>(_onClearShoppingBag);
  }

  Future<void> _onGetShoppingBag(GetShoppingBag event, Emitter<ClientShoppingBagState> emit) async {
    List<Product> products = await shoppingBagUseCases.getProductShoppingBagUseCase.run();
    double total = await shoppingBagUseCases.getTotalShoppingBagUseCase.run();
    emit(state.copyWith(products: products, total: total));
  }

  Future<void> _onAddItem(AddItem event, Emitter<ClientShoppingBagState> emit) async {
    List<Product> products = List.from(state.products);
    int index = products.indexWhere((p) => p.id == event.product.id);
    
    if (index != -1) {
      products[index].quantity = (products[index].quantity ?? 0) + 1;
      Product updatedProduct = products[index];
      await shoppingBagUseCases.addShoppingBagUseCase.run(updatedProduct);
    }
    
    double total = await shoppingBagUseCases.getTotalShoppingBagUseCase.run();
    emit(state.copyWith(products: products, total: total));
  }

  Future<void> _onSubTractItem(SubTractItem event, Emitter<ClientShoppingBagState> emit) async {
    List<Product> products = List.from(state.products);
    int index = products.indexWhere((p) => p.id == event.product.id);
    
    if (index != -1) {
      if (products[index].quantity! > 1) {
        products[index].quantity = products[index].quantity! - 1;
        Product updatedProduct = products[index];
        await shoppingBagUseCases.addShoppingBagUseCase.run(updatedProduct);
      } else {
        products.removeAt(index);
        await shoppingBagUseCases.deleteItemShoppingBagUseCase.run(event.product);
      }
    }
    
    double total = await shoppingBagUseCases.getTotalShoppingBagUseCase.run();
    emit(state.copyWith(products: products, total: total));
  }

  Future<void> _onRemoveItem(RemoveItem event, Emitter<ClientShoppingBagState> emit) async {
    await shoppingBagUseCases.deleteItemShoppingBagUseCase.run(event.product);
    List<Product> products = List.from(state.products);
    products.removeWhere((p) => p.id == event.product.id);
    double total = await shoppingBagUseCases.getTotalShoppingBagUseCase.run();
    emit(state.copyWith(products: products, total: total));
  }

  Future<void> _onClearShoppingBag(ClearShoppingBag event, Emitter<ClientShoppingBagState> emit) async {
    await shoppingBagUseCases.deleteShoppingBagUseCase.run();
    emit(state.copyWith(products: [], total: 0.0));
  }
}