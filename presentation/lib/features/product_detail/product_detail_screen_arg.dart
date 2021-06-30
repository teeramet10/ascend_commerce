import 'package:presentation/common/navigation/screen_arguments.dart';
import 'package:domain/model/product_model.dart';

class ProductDetailScreenArg extends ScreenArguments {
  ProductDetailScreenArg({this.data ,required this.index});
  int index;
  ProductModel? data;
}
