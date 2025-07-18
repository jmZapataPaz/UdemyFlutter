import 'package:ecommerce_flutter/src/domain/models/Category.dart';
import 'package:ecommerce_flutter/src/domain/utils/BlocFormItem.dart';
import 'package:equatable/equatable.dart';

abstract class AdminProductCreateEvent extends Equatable {
  const AdminProductCreateEvent();

  @override
  List<Object?> get props => [];
}

class AdminProductCreateInitEvent extends AdminProductCreateEvent {
  final Category? category;

  const AdminProductCreateInitEvent({required this.category});
  
  @override
  List<Object?> get props => [category];
}

class NameChanged extends AdminProductCreateEvent {
  final BlocFormItem name;
  const NameChanged(this.name);
  @override
  List<Object?> get props => [name];
}



class DescriptionChanged extends AdminProductCreateEvent {
  final BlocFormItem description;
  const DescriptionChanged(this.description);
  @override
  List<Object?> get props => [description];
}

class PriceChanged extends AdminProductCreateEvent {
  final BlocFormItem price;
  const PriceChanged(this.price);
  @override
  List<Object?> get props => [price];
}

class FormSubmit extends AdminProductCreateEvent {
  const FormSubmit();
  @override
  List<Object?> get props => [];
}

class ResetForm extends AdminProductCreateEvent {
  const ResetForm();
  @override
  List<Object?> get props => [];
}

class PIckImage extends AdminProductCreateEvent {
  final int numberFile;
  const PIckImage({required this.numberFile});
}

class TakePhoto extends AdminProductCreateEvent {
  final int numberFile;
  const TakePhoto({required this.numberFile});
}