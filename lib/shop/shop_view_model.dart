import 'package:flutter/material.dart';

import './shop.dart';
import 'model/shop_helper.dart';
import 'model/shop_model.dart';
import 'state/tabbar_change.dart';

abstract class ShopViewModel extends State<Shop> {
  ScrollController scrollController = ScrollController();
  int currentCategoryIndex = 0;
  ScrollController headerScrollController = ScrollController();

  List<ShopModel> shopList = [];

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
      tabBarNotifier.changeIndex(index);

      headerScrollController.animateTo(
          index * (MediaQuery.of(context).size.width * 0.2),
          duration: Duration(seconds: 1),
          curve: Curves.decelerate);
    });
  }

  void headerListChangePosition(int index) {
    scrollController.animateTo(shopList[index].position,
        duration: Duration(seconds: 1), curve: Curves.ease);
  }

  double oneItemHeight = 0;

  void fillListPositionValues(double val) {
    if (oneItemHeight == 0) {
      oneItemHeight = val;
      shopList.asMap().forEach((key, value) {
        if (key == 0) {
          shopList[key].position = 0;
        } else {
          shopList[key].position = getShopListPosition(val, key);
        }
      });
    }
  }

  double getShopListPosition(double val, int index) =>
      val * (shopList[index].products.length / ShopHelper.GRID_COLUMN_VALUE) +
      shopList[index - 1].position;
}
