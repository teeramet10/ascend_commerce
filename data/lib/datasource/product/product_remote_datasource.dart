import 'package:data/entities/product_entity.dart';
import 'package:domain/usecase/get_product_detail_usecase.dart';
import 'package:domain/usecase/get_product_list_usecase.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductEntity>> getProductList(
      GetProductListRequestModel request);
  Future<ProductEntity> getProductDetail(GetProductDetailRequestModel request);
}
