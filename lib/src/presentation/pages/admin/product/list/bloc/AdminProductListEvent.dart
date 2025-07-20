import 'package:equatable/equatable.dart';

abstract class AdminProductListEvent extends Equatable{

  const AdminProductListEvent();

  @override
  List<Object?> get props => [];
}

class GetProductsByCategory extends AdminProductListEvent {
  final int id_category;
  const GetProductsByCategory({
    required this.id_category
  });

  @override
  List<Object?> get props => [id_category];

}

class DeleteProduct extends AdminProductListEvent {
  final int id;
  const DeleteProduct({
    required this.id
  });

  @override
  List<Object?> get props => [id];
}