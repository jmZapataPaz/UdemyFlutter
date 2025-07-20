import 'package:equatable/equatable.dart';

abstract class ClientProductListEvent extends Equatable{

  const ClientProductListEvent();

  @override
  List<Object?> get props => [];
}

class GetProductsByCategory extends ClientProductListEvent {
  final int id_category;
  const GetProductsByCategory({
    required this.id_category
  });

  @override
  List<Object?> get props => [id_category];

}

