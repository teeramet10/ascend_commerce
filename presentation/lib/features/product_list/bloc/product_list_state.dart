import 'package:equatable/equatable.dart';
import 'package:domain/model/product_model.dart';

class ProductListState extends Equatable {
  const ProductListState({this.list = const []});

  final List<ProductModel> list;

  ProductListState copyWith({List<ProductModel>? list}) {
    return ProductListState(
      list: list ?? this.list,
    );
  }

  List<Object?> get props => [list];
}

class LoadingState extends ProductListState {}

class ErrorState extends ProductListState {}

class NetworkErrorState extends ProductListState {}

class NoDataState extends ProductListState {}
