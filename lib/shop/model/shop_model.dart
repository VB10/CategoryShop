class ShopModel {
  final String categoryName;
  final List<Product> products;
  double position = 0;

  ShopModel({this.categoryName, this.products});
}

class Product {
  final String name;
  final int price;

  Product(this.name, this.price);
}
