import 'dart:io';
import 'package:ecommerce_flutter/src/domain/useCases/products/ProductUseCase.dart';
import 'package:ecommerce_flutter/src/domain/utils/BlocFormItem.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/create/bloc/AdminProductCreateEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/admin/product/create/bloc/AdminProductCreateState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AdminProductCreateBloc extends Bloc<AdminProductCreateEvent, AdminProductCreateState> {

  ProductUseCase productUseCase;

  AdminProductCreateBloc(this.productUseCase) : super(const AdminProductCreateState()) {
    on<AdminProductCreateInitEvent>(_onInit);
    on<NameChanged>(_onNameChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<PriceChanged>(_onPriceChanged);
    on<FormSubmit>(_onFormSubmit);
    on<ResetForm>(_onResetForm);
    on<PIckImage>(_onPickImage);
    on<TakePhoto>(_onTakePhoto);
  }

  final formKey = GlobalKey<FormState>();
  Future<void> _onInit(AdminProductCreateInitEvent event, Emitter<AdminProductCreateState> emit) async{
    emit(state.copyWith(
      id_category: event.category?.id ,
      formKey: formKey
      )
    );
  }

  Future<void> _onNameChanged(NameChanged event, Emitter<AdminProductCreateState> emit)async {
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

  Future<void> _onDescriptionChanged(DescriptionChanged event, Emitter<AdminProductCreateState> emit) async {
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

  Future<void> _onPriceChanged (PriceChanged event, Emitter<AdminProductCreateState> emit) async {
    emit(
      state.copyWith(
        price: BlocFormItem(
          value: event.price.value,
          error: event.price.value.isNotEmpty ? null : 'Ingresa el precio'
        ),
        formKey: formKey
      )
    );
  }

  Future<void> _onFormSubmit(FormSubmit event, Emitter<AdminProductCreateState> emit) async{
    emit(
      state.copyWith(
        response: Loading(),
        formKey: formKey
      )
    );
    if(state.file1 != null && state.file2 != null){
      List<File> files = [state.file1!, state.file2!];
      Resource response = await productUseCase.createProductUseCase.run(state.toProduct(), files);
      emit(
        state.copyWith(
          response: response,
          formKey: formKey
        )
      );
    }
    else{
      emit(
        state.copyWith(
          response: Error('Debes seleccionar dos imágenes'),
          formKey: formKey
        )
      );
    }
  }

  Future<void> _onResetForm(ResetForm event, Emitter<AdminProductCreateState> emit)async {
    emit(
      state.resetForm()
    );
    state.resetForm();
  }

  Future<void> _onPickImage(PIckImage event, Emitter<AdminProductCreateState> emit) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if(event.numberFile == 1){
        emit(
        state.copyWith(
          file1: File(image.path),
          formKey: formKey
          )
        );
      }else if (event.numberFile ==2){
        emit(
          state.copyWith(
            file2: File(image.path),
            formKey: formKey
          )
        );
      }
    } 
  }
  Future<void> _onTakePhoto(TakePhoto event, Emitter<AdminProductCreateState> emit) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      if(event.numberFile == 1){
        emit(
        state.copyWith(
          file1: File(image.path),
          formKey: formKey
          )
        );
      }else if (event.numberFile ==2){
        emit(
          state.copyWith(
            file2: File(image.path),
            formKey: formKey
          )
        );
      }
    } 
  }
}