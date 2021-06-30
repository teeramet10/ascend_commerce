class ProductModel {
  ProductModel(
      { this.id = -1,
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
}
