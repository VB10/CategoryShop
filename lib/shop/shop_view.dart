import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './shop_view_model.dart';
import 'state/tabbar_change.dart';
import 'widget/shop_card.dart';

class ShopView extends ShopViewModel {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: buildChangeBody(),
    );
  }

  ChangeNotifierProvider<TabBarChange> buildChangeBody() {
    return ChangeNotifierProvider.value(
      value: change,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: buildListViewHeader()),
          Divider(),
          Expanded(flex: 9, child: buildListViewShop()),
        ],
      ),
    );
  }

  ListView buildListViewShop() {
    return ListView(
        controller: scrollController,
        children: List.generate(shopList.length + 1, (index) {
          if (index == shopList.length) {
            return emptyWidget();
          }
          return ShopCardBody(
            model: shopList[index],
            index: index,
            onHeight: (val) {
              fillListPositionValues(val);
            },
          );
        }));
  }

  Container emptyWidget() => Container(height: oneItemHeight * 2);

  Widget buildListViewHeader() {
    return Consumer<TabBarChange>(
      builder: (context, value, child) => ListView.builder(
        itemCount: shopList.length,
        controller: headerScrollController,
        padding: EdgeInsets.all(10),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return buildPaddingHeaderCard(index);
        },
      ),
    );
  }

  Padding buildPaddingHeaderCard(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: RaisedButton(
        color: change.index == index ? Colors.red : Colors.blue,
        onPressed: () => headerListChangePosition(index),
        child: Text(shopList[index].categoryName),
        shape: StadiumBorder(),
      ),
    );
  }
}
