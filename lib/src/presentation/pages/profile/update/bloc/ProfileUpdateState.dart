import 'dart:io';
import 'package:ecommerce_flutter/src/domain/models/User.dart';
import 'package:ecommerce_flutter/src/domain/utils/BlocFormItem.dart';
import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProfileUpdateState extends Equatable{
  
  final int id;
  final BlocFormItem name;
  final BlocFormItem lastname;
  final BlocFormItem phone;
  final File? image; 
  final GlobalKey<FormState>? formKey;
  final Resource? response;

  const ProfileUpdateState({
    this.id = 0,
    this.name =  const BlocFormItem(error: "El nombre es requerido"),
    this.lastname =  const BlocFormItem(error: "El apellido es requerido"),
    this.phone =  const BlocFormItem(error: "El teléfono es requerido"),
    this.formKey,
    this.image,
    this.response,
  });

  toUser() => User(
    id: id,
    name: name.value,
    lastname: lastname.value,
    phone: phone.value,
  );

  ProfileUpdateState copyWith({
    int? id,
    BlocFormItem? name,
    BlocFormItem? lastname,
    BlocFormItem? phone,
    File? image,
    GlobalKey<FormState>? formKey,
    Resource? response,
  }) {
    return ProfileUpdateState(
      id: id ?? this.id,
      name: name ?? this.name,
      lastname: lastname ?? this.lastname,
      phone: phone ?? this.phone,
      formKey: formKey,
      image: image ?? this.image,
      response: response,
    );
  }
  
  @override
  List<Object?> get props => [id, name, lastname, phone, image, response];

}