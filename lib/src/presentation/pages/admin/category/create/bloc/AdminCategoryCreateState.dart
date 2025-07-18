import 'dart:io';
import 'package:ecommerce_flutter/src/domain/models/Category.dart';
import 'package:ecommerce_flutter/src/domain/utils/BlocFormItem.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AdminCategoryCreateState extends Equatable{
 
  final BlocFormItem name;
  final BlocFormItem description;
  final GlobalKey<FormState>? formKey;
  final Resource? response;
  final File? file;

  const AdminCategoryCreateState({
    this.name = const BlocFormItem(error: 'El nombre es requerido'),
    this.description = const BlocFormItem(error: 'La descripción es requerida'),
    this.formKey,
    this.response,
    this.file,
  });

  toCategory() => Category(
    name: name.value, 
    description: description.value, 
  );

  AdminCategoryCreateState resetForm(){
    return AdminCategoryCreateState(
      name:BlocFormItem( error: 'El nombre es requerido'),
      description: BlocFormItem( error: 'La descripción es requerida'),
    );
  }

  AdminCategoryCreateState copyWith({
    BlocFormItem? name,
    BlocFormItem? description,
    GlobalKey<FormState>? formKey,
    Resource? response,
    File? file,
  }) {
    return AdminCategoryCreateState(
      name: name ?? this.name,
      description: description ?? this.description,
      formKey: formKey,
      response: response,
      file: file ?? this.file,
    );
  }
  @override
  List<Object?> get props => [name, description, file, response];


}