import 'package:data/network_info.dart';
import 'package:data/service_exceptions.dart';
import 'package:domain/model/product_model.dart';
import 'package:domain/repositories/product_repository.dart';
import 'package:domain/usecase/get_product_detail_usecase.dart';
import 'package:domain/usecase/get_product_list_usecase.dart';
import 'package:data/datasource/product/product_remote_datasource.dart';

class ProductRepositoryImpl extends ProductRepository {
  ProductRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  final NetworkInfo networkInfo;
  final ProductRemoteDataSource remoteDataSource;

  @override
  Future<ProductModel> getProductDetail(
      GetProductDetailRequestModel request) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource
          .getProductDetail(request)
          .then((value) => value.toModel());
    } else {
      return Future.error(ServiceException.NETWORK_DISCONNECTED);
    }
  }

  @override
  Future<List<ProductModel>> getProductList(
      GetProductListRequestModel request) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource
          .getProductList(request)
          .then((value) => value.map((e) => e.toModel()).toList());
    } else {
      return Future.error(ServiceException.NETWORK_DISCONNECTED);
    }
  }
}
