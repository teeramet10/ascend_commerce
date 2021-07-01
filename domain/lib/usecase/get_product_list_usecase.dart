import 'package:domain/model/product_model.dart';
import 'package:domain/repositories/product_repository.dart';

import 'usecase.dart';

class GetProductListUseCase
    extends UseCase<GetProductListRequestModel, GetProductListResponseModel> {
  final ProductRepository repository;

  GetProductListUseCase(this.repository);

  @override
  Future<GetProductListResponseModel> call(
      GetProductListRequestModel request) async {
    var response = await repository.getProductList(request);
    return GetProductListResponseModel(response);
  }
}

class GetProductListRequestModel extends UserCaseRequest {
  GetProductListRequestModel();
}

class GetProductListResponseModel extends UserCaseResponse {
  List<ProductModel> list;

  GetProductListResponseModel(this.list);
}
