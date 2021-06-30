import 'package:domain/usecase/get_product_list_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_list_event.dart';
import 'product_list_state.dart';
import 'package:data/service_exceptions.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final GetProductListUseCase getProductListUseCase;

  ProductListBloc({required this.getProductListUseCase})
      : super(const ProductListState());

  @override
  Stream<ProductListState> mapEventToState(ProductListEvent event) async* {
    if (event is GetProductListEvent) {
      yield* getProductList(state, event);
    } else {
      yield state;
    }
  }

  Stream<ProductListState> getProductList(
      ProductListState state, ProductListEvent event) async* {
    try {
      yield LoadingState();
      var response =
          await getProductListUseCase.call(GetProductListRequestModel());
      if (response.list.length != 0) {
        yield ProductListState(list: response.list);
      } else {
        yield NoDataState();
      }
    } on ServiceException catch (error) {
      if (error.message == ServiceException.NETWORK_DISCONNECTED.message) {
        yield NetworkErrorState();
      } else
        yield ErrorState();
    }
  }
}
