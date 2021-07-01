import 'package:domain/usecase/get_product_detail_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_detail_event.dart';
import 'product_detail_state.dart';
import 'package:data/service_exceptions.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final GetProductDetailUseCase getProductDetailUseCase;

  ProductDetailBloc({required this.getProductDetailUseCase})
      : super(const ProductDetailState());

  @override
  Stream<ProductDetailState> mapEventToState(ProductDetailEvent event) async* {
    if (event is InitialState) {
      yield* initial(state, event);
    } else if (event is GetProductDetailEvent) {
      yield* getProductDetail(state, event);
    } else {
      yield state;
    }
  }

  Stream<ProductDetailState> initial(
      ProductDetailState state, InitialState event) async* {
    yield state.copyWith(data:event.data);
  }

  Stream<ProductDetailState> getProductDetail(
      ProductDetailState state, GetProductDetailEvent event) async* {
    try {
      int? id = state.data?.id;
      if(state.data?.id == null){
        yield NoDataState(state.data);
        return;
      }
      yield ProductDetailState(data:state.data);
      var response = await getProductDetailUseCase
          .call(GetProductDetailRequestModel(id: id!));
      if (response.data != null) {
        yield ProductDetailState(data: response.data);
      } else {
        yield ProductDetailState(data:state.data);
      }
    } on ServiceException catch (error) {
      if (error.message == ServiceException.NETWORK_DISCONNECTED.message) {
        yield NetworkErrorState(state.data);
      } else
        yield  ProductDetailState(data:state.data);
    }
  }
}
