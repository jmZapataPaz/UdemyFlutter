import 'package:ecommerce_flutter/src/domain/useCases/products/ProductUseCase.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/list/bloc/ClientProductListEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/product/list/bloc/ClientProductListState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientProductListBloc extends Bloc<ClientProductListEvent, ClientProductListState>{
  
  ProductUseCase productUseCase;

  ClientProductListBloc(this.productUseCase) : super(const ClientProductListState()) {
    
    on<GetProductsByCategory>(_onGetProductsByCategory);

  }

  Future<void> _onGetProductsByCategory(GetProductsByCategory event, Emitter<ClientProductListState> emit) async {

    emit(
      state.copyWith(
        response: Loading()
      )
    );
    Resource response = await productUseCase.getProductByCategoryUseCase.run(event.id_category);
    emit(
      state.copyWith(
        response: response
      )
    );
  }


}
