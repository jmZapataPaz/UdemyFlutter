import 'package:equatable/equatable.dart';

class ClientProductDetailState extends Equatable {
  final int quantity;
  final bool productAdded;

  const ClientProductDetailState({
    this.quantity = 0,
    this.productAdded = false, 
  });

  ClientProductDetailState copyWith({
    int? quantity,
    bool? productAdded, o
  }) {
    return ClientProductDetailState(
      quantity: quantity ?? this.quantity,
      productAdded: productAdded ?? this.productAdded, 
    );
  }

  @override
  List<Object?> get props => [quantity, productAdded]; 
}