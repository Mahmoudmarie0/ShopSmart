import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_smart/consts/assets.dart';
import 'package:shop_smart/controller/wishlist_controller.dart';
import 'package:shop_smart/widgets/empty_bag.dart';
import 'package:shop_smart/widgets/title_text.dart';
import '../../widgets/show_dialog_widget.dart';
import '../SearchScreen/Widgets/products_widget.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    WishlistController wishlistController = Get.put(WishlistController());
    return wishlistController.getWishListItem.isEmpty
        ? GetBuilder<WishlistController>(
            init: WishlistController(),
            builder: (context) {
              return Scaffold(
                  body: EmptyBagWidget(
                imagePath: AssetsPaths.shoppingBasket,
                title: 'Your cart is empty',
                subtitle:
                    'Looks like you didn\'t add anything yet to your cart \ngo ahead and start shopping now',
                buttonText: 'Shop now',
              ));
            })
        : GetBuilder<WishlistController>(
            init: WishlistController(),
            builder: (controller) {
              return Scaffold(
                appBar: AppBar(
                  title: TitleTextWidget(
                    label: "wishlist (${controller.getWishListItem.length})",
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(AssetsPaths.shoppingCart),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          ShowDialogWidget.showErrorORWarningDialog(
                              context: context,
                              subtitle: "Remove all item from wishlist?",
                              isError: false,
                              fct: () async {
                                await controller.clearWishListFromFirebase();
                                controller.clearWishList();
                              });
                        },
                        icon: const Icon(
                          Icons.delete_forever_rounded,
                          color: Colors.red,
                        ))
                  ],
                ),
                body: DynamicHeightGridView(
                  itemCount: controller.getWishListItem.length,
                  crossAxisCount: 2,
                  builder: (context, index) {
                    return ProductWidget(
                      id: controller.getWishListItem.values
                          .toList()[index]
                          .productId,
                    );
                  },
                ),
              );
            });
  }
}
