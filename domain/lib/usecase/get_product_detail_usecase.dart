import 'package:domain/model/product_model.dart';
import 'package:domain/repositories/product_repository.dart';
import 'usecase.dart';

class GetProductDetailUseCase
    extends UseCase<GetProductDetailRequestModel, GetProductDetailResponseModel> {
  final ProductRepository repository;

  GetProductDetailUseCase(this.repository);

  @override
  Future<GetProductDetailResponseModel> call(
      GetProductDetailRequestModel request) async {
    var response = await repository.getProductDetail(request);
    return GetProductDetailResponseModel(response);
  }
}

class GetProductDetailRequestModel extends UserCaseRequest {
  int id;
  GetProductDetailRequestModel({required this.id});
}

class GetProductDetailResponseModel extends UserCaseResponse {
  ProductModel data;

  GetProductDetailResponseModel(this.data);
}
