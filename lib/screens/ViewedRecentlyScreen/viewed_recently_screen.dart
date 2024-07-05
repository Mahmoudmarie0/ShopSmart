import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:shop_smart/consts/assets.dart';
import 'package:shop_smart/widgets/empty_bag.dart';
import 'package:shop_smart/widgets/title_text.dart';

import '../SearchScreen/Widgets/products_widget.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  const ViewedRecentlyScreen({super.key});
  final bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? Scaffold(
        body: EmptyBagWidget(
          imagePath: AssetsPaths.bagWish,
          title: 'Your viewed recently is empty',
          subtitle:
          'Looks like you didn\'t add anything yet to your cart \ngo ahead and start shopping now',
          buttonText: 'Shop now',
        ))
        : Scaffold(
      appBar: AppBar(
        title: const TitleTextWidget(
          label: "viewed recently (5)",
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsPaths.shoppingCart),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete_forever_rounded,
                color: Colors.red,
              ))
        ],
      ),
      body: DynamicHeightGridView(
        itemCount: 220,
        crossAxisCount: 2,
        builder: (context, index) {
          return const ProductWidget();
        },
      ),
    );
  }
}
