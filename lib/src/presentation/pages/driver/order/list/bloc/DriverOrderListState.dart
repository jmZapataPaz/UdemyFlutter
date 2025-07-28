import 'package:ecommerce_flutter/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';

class DriverOrderListState extends Equatable {

  final Resource? response;
  final String selectedFilter;

  const DriverOrderListState({
    this.response,
    this.selectedFilter = 'TODOS'
  });

  DriverOrderListState copyWith({
    Resource? response,
    String? selectedFilter
  }) {
    return DriverOrderListState(
      response: response ?? this.response,
      selectedFilter: selectedFilter ?? this.selectedFilter
    );
  }

  @override
  List<Object?> get props => [response, selectedFilter];
}