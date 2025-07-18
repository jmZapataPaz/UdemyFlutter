import 'dart:io';
import 'package:ecommerce_flutter/src/domain/models/Product.dart';
import 'package:ecommerce_flutter/src/domain/utils/BlocFormItem.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AdminProductCreateState extends Equatable{
 
  final BlocFormItem name;
  final BlocFormItem description;
  final BlocFormItem price;
  final GlobalKey<FormState>? formKey;
  final Resource? response;
  final File? file1;
  final File? file2;
  final int id_category;

  const AdminProductCreateState({
    this.name = const BlocFormItem(error: 'El nombre es requerido'),
    this.description = const BlocFormItem(error: 'La descripción es requerida'),
    this.price = const BlocFormItem(error: 'El precio es requerido'),
    this.formKey,
    this.response,
    this.id_category = 0,
    this.file1,
    this.file2,
  });

  toProduct() => Product(
    name: name.value, 
    description: description.value, 
    id_category: id_category, 
    price:double.parse(price.value), 
    
  );

  AdminProductCreateState resetForm(){
    return AdminProductCreateState(
      name:BlocFormItem( error: 'El nombre es requerido'),
      description: BlocFormItem( error: 'La descripción es requerida'),
    );
  }

  AdminProductCreateState copyWith({
    int? id_category,
    BlocFormItem? name,
    BlocFormItem? description,
    BlocFormItem? price,
    GlobalKey<FormState>? formKey,
    Resource? response,
    File? file1,
    File? file2,
  }) {
    return AdminProductCreateState(
      id_category: id_category ?? this.id_category,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      formKey: formKey,
      response: response,
      file1: file1 ?? this.file1,
      file2: file2 ?? this.file2,
    );
  }
  @override
  List<Object?> get props => [id_category, name, description, price, file1, file2, response];


}