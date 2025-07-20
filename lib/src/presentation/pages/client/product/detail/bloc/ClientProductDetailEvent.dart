import 'package:ecommerce_flutter/src/domain/models/Product.dart';
import 'package:equatable/equatable.dart';

class ClientProductDetailEvent extends Equatable{

  const ClientProductDetailEvent();
  @override
  List<Object?> get props => [];
}



class ResetState extends ClientProductDetailEvent {
  const ResetState();
  

}

class GetProducts extends ClientProductDetailEvent {
  final Product product;
  GetProducts(this.product);
  @override
  // TODO: implement props
  List<Object?> get props => [product];
}

class AddItem extends ClientProductDetailEvent {

  const AddItem();

  @override
  List<Object?> get props => [];
}

class SubTractItem extends ClientProductDetailEvent {

  const SubTractItem();

  @override
  List<Object?> get props => [];
}

class AddProductToShoppingBag extends ClientProductDetailEvent {
  final Product product;
  
  AddProductToShoppingBag({
    required this.product,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [product];
}