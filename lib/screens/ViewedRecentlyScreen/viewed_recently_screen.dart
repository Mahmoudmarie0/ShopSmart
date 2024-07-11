import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_smart/consts/assets.dart';
import 'package:shop_smart/controller/viewed_recently_controller.dart';
import 'package:shop_smart/widgets/empty_bag.dart';
import 'package:shop_smart/widgets/title_text.dart';

import '../SearchScreen/Widgets/products_widget.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  const ViewedRecentlyScreen({super.key});
  final bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    ViewedRecentlyController controller = Get.put(ViewedRecentlyController());
    return controller.getViewedRecently.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
            imagePath: AssetsPaths.bagWish,
            title: 'Your viewed recently is empty',
            subtitle:
                'Looks like you didn\'t add anything yet to your cart \ngo ahead and start shopping now',
            buttonText: 'Shop now',
          ))
        : GetBuilder<ViewedRecentlyController>(
            init: ViewedRecentlyController(),
            builder: (controller) {
              return Scaffold(
                appBar: AppBar(
                  title: TitleTextWidget(
                    label:
                        "viewed recently (${controller.getViewedRecently.length})",
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
                  itemCount: controller.getViewedRecently.length,
                  crossAxisCount: 2,
                  builder: (context, index) {
                    return ProductWidget(
                      id: controller.getViewedRecently.values
                          .toList()[index]
                          .productId,
                    );
                  },
                ),
              );
            });
  }
}
