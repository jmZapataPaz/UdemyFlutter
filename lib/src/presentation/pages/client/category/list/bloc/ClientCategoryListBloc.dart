import 'package:ecommerce_flutter/src/domain/useCases/categories/CategoryUseCase.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/category/list/bloc/ClientCategoryListState.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/category/list/bloc/clientCategoryListEvent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientCategoryListBloc extends Bloc<ClientCategoryListEvent, ClientCategoryListState>{

  CategoryUseCase categoryUseCase;

  ClientCategoryListBloc(this.categoryUseCase): super(ClientCategoryListState()) {
    on<GetCategory>(_onGetCategory);
  }


  Future<void> _onGetCategory(GetCategory event, Emitter<ClientCategoryListState> emit) async {
    emit(
      state.copyWith(
        response: Loading()
      )
    );
    Resource response = await categoryUseCase.getCategoryUseCase.run();
    emit(
      state.copyWith(
        response: response
      )
    );
  }

}