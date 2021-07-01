import 'package:equatable/equatable.dart';

abstract class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object?> get props => [];
}

class GetProductListEvent extends ProductListEvent {
  const GetProductListEvent();

  @override
  List<Object> get props => [];
}