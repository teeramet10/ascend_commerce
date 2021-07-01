import 'package:domain/model/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_entity.g.dart';

@JsonSerializable()
class ProductEntity {
  ProductEntity(
      {this.id = -1,
      this.title = "",
      this.image = "",
      this.content = "",
      this.isNewProduct = false,
      this.price = 0});

  int id;
  String title;
  String image;
  String content;
  bool isNewProduct;
  double price;

  factory ProductEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProductEntityToJson(this);

  ProductModel toModel() {
    var model = ProductModel(id: this.id);
    model.title = this.title;
    model.image = this.image;
    model.content = this.content;
    model.isNewProduct = this.isNewProduct;
    model.price = this.price;
    return model;
  }
}
