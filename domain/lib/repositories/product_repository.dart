import 'package:domain/model/product_model.dart';
import 'package:domain/usecase/get_product_detail_usecase.dart';
import 'package:domain/usecase/get_product_list_usecase.dart';

abstract class ProductRepository{
  Future<List<ProductModel>> getProductList(GetProductListRequestModel request);
  Future<ProductModel> getProductDetail(GetProductDetailRequestModel request);
}