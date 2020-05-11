import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './shop_view_model.dart';
import 'model/shop_model.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scrollController.animateTo(shopList[4].position,
              duration: Duration(seconds: 1), curve: Curves.bounceIn);
        },
      ),
      appBar: AppBar(),
      body: ChangeNotifierProvider.value(
        value: change,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(flex: 1, child: buildListViewHeader()),
            Divider(),
            Expanded(
              flex: 9,
              child: buildListViewShop(),
            ),
            // Spacer(flex: 5)
          ],
        ),
      ),
    );
  }

  double oneItemHeight = 0;

  ListView buildListViewShop() {
    return ListView(
        controller: scrollController,
        children: List.generate(shopList.length + 1, (index) {
          if (index == shopList.length) {
            return Container(
              height: oneItemHeight * 2,
            );
          }
          return ShopCardBody(
            model: shopList[index],
            index: index,
            onHeight: (val) {
              if (oneItemHeight == 0) {
                oneItemHeight = val;
                shopList.asMap().forEach((key, value) {
                  if (key == 0) {
                    shopList[key].position = 0;
                  } else {
                    shopList[key].position =
                        val * (shopList[index].products.length / 4) +
                            shopList[key - 1].position;
                  }
                });
              }
            },
          );
        }));
  }

  GridView buildGridViewProducts(int index, List<Product> products) {
    shopList[index].position =
        ((products.length / 4) * MediaQuery.of(context).size.height * 0.1) +
            shopList[index - 1 < 0 ? 0 : index - 1].position +
            MediaQuery.of(context).size.height * 0.005;
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: products.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (context, index) {
        return Card(
          child: Text(products[index].name),
        );
      },
    );
  }

  Widget buildListViewHeader() {
    return Consumer<TabBarChange>(
      builder: (context, value, child) => ListView.builder(
        itemCount: shopList.length,
        controller: headerScrollController,
        padding: EdgeInsets.all(10),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: RaisedButton(
              color: change.index == index ? Colors.red : Colors.blue,
              onPressed: () {
                scrollController.animateTo(shopList[index].position,
                    duration: Duration(seconds: 1), curve: Curves.ease);
              },
              child: Text(shopList[index].categoryName),
              shape: StadiumBorder(),
            ),
          );
        },
      ),
    );
  }
}
