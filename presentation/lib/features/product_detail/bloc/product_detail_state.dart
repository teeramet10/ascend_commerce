import 'package:equatable/equatable.dart';
import 'package:domain/model/product_model.dart';

class ProductDetailState extends Equatable {

  const ProductDetailState({this.data});

  final ProductModel? data;

  ProductDetailState copyWith({ProductModel? data}) {
    return ProductDetailState(
      data: data ?? this.data,
    );
  }

  List<Object?> get props => [data];
}

class LoadingState extends ProductDetailState {
  final ProductModel? data;

  const LoadingState({this.data}):super(data: data);
}

class ErrorState extends ProductDetailState {
  final ProductModel? data;

  const ErrorState({this.data}):super(data: data);
}

class NetworkErrorState extends ProductDetailState {
  final ProductModel? data;

  const NetworkErrorState({this.data}):super(data: data);
}

class NoDataIDState extends ProductDetailState {

  const NoDataIDState();
}
