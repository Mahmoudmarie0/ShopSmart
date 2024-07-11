import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:iconly/iconly.dart';
import 'package:shop_smart/controller/wishlist_controller.dart';

class HeartButtonWidget extends StatelessWidget {
  const HeartButtonWidget(
      {super.key,
      this.iconSize = 20,
      this.color = Colors.transparent,
      required this.productId});
  final double iconSize;
  final Color? color;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WishlistController>(
        init: WishlistController(),
        builder: (controller) {
          return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              child: IconButton(
                onPressed: () async {
                  controller.addOrRemoveToWishList(productId: productId);
                  controller.update();
                },
                icon: Icon(
                  IconlyLight.heart,
                  size: iconSize,
                  color: controller.isAddedToWishList(productId)
                      ? Colors.red
                      : Colors.black,
                ),
                style: IconButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: Colors.transparent,
                ),
              ));
        });
  }
}
