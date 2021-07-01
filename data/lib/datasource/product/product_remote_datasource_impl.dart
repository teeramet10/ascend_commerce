import 'package:data/entities/product_entity.dart';
import 'package:data/service_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:domain/usecase/get_product_detail_usecase.dart';
import 'package:domain/usecase/get_product_list_usecase.dart';
import 'package:http_parser/src/media_type.dart';
import '../../http_manager.dart';
import '../base_datasource.dart';
import 'product_datasource.dart';

class ProductRemoteDataSourceImpl extends BaseDataSource
    implements ProductRemoteDataSource {
  final HttpManager httpManager;

  ProductRemoteDataSourceImpl({required this.httpManager});

  @override
  Future<ProductEntity> getProductDetail(
      GetProductDetailRequestModel request) async {
    try {
      var path = HttpManager.get_product_detail + request.id.toString();
      var response = await httpManager.sendGetRequest(path,{});
      if (response.statusCode == 200) {
        var model = ProductEntity.fromJson(response.data);
        return model;
      }
      return Future.error(handlerError(response));
    } on DioError catch (e) {
      return Future.error(
          ServiceException(message: e.message, code: e.response?.statusCode));
    }
  }

  @override
  Future<List<ProductEntity>> getProductList(
      GetProductListRequestModel request) async {
    try {
      var path = HttpManager.get_product_list;
      var response = await httpManager.sendGetRequest(path,{});
      if (response.statusCode == 200) {
        List<dynamic> jsonList = response.data;
        List<ProductEntity> list = jsonList
            .map((value) => ProductEntity.fromJson(value))
            .toList();
        return list;
      }
      return Future.error(handlerError(response));
    } on DioError catch (e) {
      return Future.error(
          ServiceException(message: e.message, code: e.response?.statusCode));
    }
  }
}
