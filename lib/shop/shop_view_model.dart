import 'package:flutter/material.dart';
import 'package:shoplist/shop/model/shop_model.dart';
import 'package:shoplist/shop/widget/shop_card.dart';
import './shop.dart';
import 'state/tabbar_change.dart';

abstract class ShopViewModel extends State<Shop> {
  List<ShopModel> shopList = [];

  ScrollController scrollController = ScrollController();
  int currentCategoryIndex = 0;
  ScrollController headerScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    shopList = List.generate(
      10,
      (index) => ShopModel(
        categoryName: "Hello",
        products: List.generate(
          6,
          (index) => Product("Product $index", index * 100),
        ),
      ),
    );

    scrollController.addListener(() {
      final index = shopList
          .indexWhere((element) => element.position >= scrollController.offset);
      change.changeIndex(index);

      headerScrollController.animateTo(
          index * (MediaQuery.of(context).size.width * 0.2),
          duration: Duration(seconds: 1),
          curve: Curves.decelerate);
    });
  }
}
