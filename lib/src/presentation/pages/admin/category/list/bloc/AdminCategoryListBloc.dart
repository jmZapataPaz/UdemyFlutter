import 'package:ecommerce_flutter/src/domain/useCases/categories/CategoryUseCase.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/list/bloc/AdminCategoryListEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/list/bloc/AdminCategoryListState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminCategoryListBloc extends Bloc<AdminCategoryListEvent, AdminCategoryListState>{

  CategoryUseCase categoryUseCase;

  AdminCategoryListBloc(this.categoryUseCase): super(AdminCategoryListState()) {
    on<GetCategory>(_onGetCategory);
    on<DeleteCategory>(_onDeleteCategory);
  }


  Future<void> _onGetCategory(GetCategory event, Emitter<AdminCategoryListState> emit) async {
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

  Future<void> _onDeleteCategory(DeleteCategory event, Emitter<AdminCategoryListState> emit) async {
    emit(
      state.copyWith(
        response: Loading()
      )
    );
    Resource response = await categoryUseCase.deleteCategoryUsecase.run(event.id);
    if (response is Success) {
      emit(
        state.copyWith(
          response: Success(true),
        )
      );
    } else if (response is Error) {
      emit(
        state.copyWith(
          response: Error(response.message),
        )
      );
    }
    
 
  }
}