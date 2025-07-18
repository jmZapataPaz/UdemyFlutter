import 'package:ecommerce_flutter/src/domain/useCases/products/ProductUseCase.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/list/bloc/AdminProductListEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/list/bloc/AdminProductListState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminProductListBloc extends Bloc<AdminProductListEvent, AdminProductListState>{
  
  ProductUseCase productUseCase;

  AdminProductListBloc(this.productUseCase) : super(const AdminProductListState()) {
    
    on<GetProductsByCategory>(_onGetProductsByCategory);

  }

  Future<void> _onGetProductsByCategory(GetProductsByCategory event, Emitter<AdminProductListState> emit) async {

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
