import 'dart:io';
import 'package:ecommerce_flutter/src/domain/useCases/categories/CategoryUseCase.dart';
import 'package:ecommerce_flutter/src/domain/utils/BlocFormItem.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/create/bloc/AdminCategoryCreateEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/category/create/bloc/AdminCategoryCreateState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AdminCategoryCreateBloc extends Bloc<AdminCategoryCreateEvent, AdminCategoryCreateState> {

  CategoryUseCase categoryUseCase;

  AdminCategoryCreateBloc(this.categoryUseCase) : super(const AdminCategoryCreateState()) {
    on<AdminCategoryCreateInitEvent>(_onInit);
    on<NameChanged>(_onNameChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<FormSubmit>(_onFormSubmit);
    on<ResetForm>(_onResetForm);
    on<PIckImage>(_onPickImage);
    on<TakePhoto>(_onTakePhoto);
  }

  final formKey = GlobalKey<FormState>();
  Future<void> _onInit(AdminCategoryCreateInitEvent event, Emitter<AdminCategoryCreateState> emit) async{
    emit(state.copyWith(formKey: formKey));
  }

  Future<void> _onNameChanged(NameChanged event, Emitter<AdminCategoryCreateState> emit)async {
    emit(
      state.copyWith(
        name: BlocFormItem(
          value: event.name.value,
          error: event.name.value.isNotEmpty ? null : 'Ingresa el nombre'
        ),
        formKey: formKey
      )
    );
  }

  Future<void> _onDescriptionChanged(DescriptionChanged event, Emitter<AdminCategoryCreateState> emit) async {
    emit(
      state.copyWith(
        description: BlocFormItem(
          value: event.description.value,
          error: event.description.value.isNotEmpty ? null : 'Ingresa la descripción'
        ),
        formKey: formKey
      )
    );
  }

  Future<void>_onFormSubmit(FormSubmit event, Emitter<AdminCategoryCreateState> emit) async{
    emit(
      state.copyWith(
        response: Loading(),
        formKey: formKey
      )
    );
    Resource response = await categoryUseCase.createCategoryUseCase.run(state.toCategory(), state.file!);
    emit(
      state.copyWith(
        response: response,
        formKey: formKey
      )
    );
  }

  Future<void> _onResetForm(ResetForm event, Emitter<AdminCategoryCreateState> emit)async {
    emit(
      state.resetForm()
    );
    state.resetForm();
  }

  Future<void> _onPickImage(PIckImage event, Emitter<AdminCategoryCreateState> emit) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(
        state.copyWith(
          file: File(image.path),
          formKey: formKey
        )
      );
    } 
  }
  Future<void> _onTakePhoto(TakePhoto event, Emitter<AdminCategoryCreateState> emit) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      emit(
        state.copyWith(
          file: File(image.path),
          formKey: formKey
        )
      );
    } 
  }
}