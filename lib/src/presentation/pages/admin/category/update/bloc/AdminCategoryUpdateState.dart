import 'dart:io';
import 'package:ecommerce_flutter/src/domain/models/Category.dart';
import 'package:ecommerce_flutter/src/domain/utils/BlocFormItem.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AdminCategoryUpdateState extends Equatable{
  final int id;
  final BlocFormItem name;
  final BlocFormItem description;
  final GlobalKey<FormState>? formKey;
  final Resource? response;
  final File? file;

  const AdminCategoryUpdateState({
    this.id = 0,
    this.name = const BlocFormItem(error: 'El nombre es requerido'),
    this.description = const BlocFormItem(error: 'La descripción es requerida'),
    this.formKey,
    this.response,
    this.file,
  });

  toCategory() => Category(
    id: id,
    name: name.value, 
    description: description.value, 
  );



  AdminCategoryUpdateState copyWith({
    int? id,
    BlocFormItem? name,
    BlocFormItem? description,
    GlobalKey<FormState>? formKey,
    Resource? response,
    File? file,
  }) {
    return AdminCategoryUpdateState(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      formKey: formKey,
      response: response,
      file: file ?? this.file,
    );
  }
  @override
  List<Object?> get props => [id,name, description, file, response];




  AdminCategoryUpdateState resetForm(){
    return AdminCategoryUpdateState(
      file : null,
    );
  }

}