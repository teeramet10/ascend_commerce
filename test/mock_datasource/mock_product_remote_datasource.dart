import 'package:data/datasource/product/product_remote_datasource.dart';
import 'package:data/entities/product_entity.dart';
import 'package:data/service_exceptions.dart';
import 'package:domain/usecase/get_product_detail_usecase.dart';
import 'package:domain/usecase/get_product_list_usecase.dart';

 final mockProducts = <ProductEntity>[
  ProductEntity(
      id: 1,
      title: "Signature Chocolate Chip Lactation Cookies",
      content: "Lorem Ipsum is simply dummy text of the printing",
      price: 18.569,
      isNewProduct: true),
  ProductEntity(
      id: 2,
      title: "Signature Chocolate Chip Lactation Cookies",
      content: "It is a long established fact that a reader will be distracted",
      price: 18.563,
      isNewProduct: true),
  ProductEntity(
      id: 3,
      title: "Signature Chocolate Chip Lactation Cookies",
      content: "Contrary to popular belief, Lorem Ipsum is",
      price: 17.563,
      isNewProduct: true),
  ProductEntity(
      id: 4,
      title: "Signature Chocolate Chip Lactation Cookies",
      content: "Lorem Ipsum is simply dummy text of the printing",
      price: 18.563,
      isNewProduct: true),
  ProductEntity(
      id: 5,
      title: "Signature Chocolate Chip Lactation Cookies",
      content: "Lorem Ipsum is simply dummy text of the printing",
      price: 18.569,
      isNewProduct: true),
  ProductEntity(
      id: 6,
      title: "Signature Chocolate Chip Lactation Cookies",
      content: "Lorem Ipsum is simply dummy text of the printing",
      price: 18.569,
      isNewProduct: false),
  ProductEntity(
      id: 7,
      title: "Signature Chocolate Chip Lactation Cookies",
      content: "Lorem Ipsum is simply dummy text of the printing",
      price: 18.569,
      isNewProduct: false),
];

class MockProductRemoteDataSource implements ProductRemoteDataSource {
  MockProductRemoteDataSource({this.hasData = true ,this.hasError = false });

  bool hasData;
  bool hasError;

  @override
  Future<ProductEntity> getProductDetail(
      GetProductDetailRequestModel request) async {
    await Future.delayed(Duration(seconds: 2));
    if(hasError){
      return Future.error(ServiceException.EXCEPTION);
    }
    if(hasData){
      return Future.value(mockProducts.first);
    }else {
      return Future.value();
    }
  }

  @override
  Future<List<ProductEntity>> getProductList(
      GetProductListRequestModel request) async {
    await Future.delayed(Duration(seconds: 2));
    if(hasError){
      return Future.error(ServiceException.EXCEPTION);
    }
    if(hasData) {
      return Future.value(mockProducts);
    }else{
      return Future.value([]);
    }
  }
}
