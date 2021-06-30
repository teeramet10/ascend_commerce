import 'package:equatable/equatable.dart';
import 'package:domain/model/product_model.dart';
abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object?> get props => [];
}

class InitialState extends ProductDetailEvent {
  const InitialState({required this.data});

  final ProductModel? data;

  @override
  List<Object?> get props => [data];
}

class GetProductDetailEvent extends ProductDetailEvent {
  const GetProductDetailEvent();


  @override
  List<Object> get props => [];
}
