import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:iconly/iconly.dart';
import 'package:shop_smart/controller/wishlist_controller.dart';
import 'package:shop_smart/widgets/show_dialog_widget.dart';

class HeartButtonWidget extends StatefulWidget {
  const HeartButtonWidget(
      {super.key,
      this.iconSize = 20,
      this.color = Colors.transparent,
      required this.productId});
  final double iconSize;
  final Color? color;
  final String productId;

  @override
  State<HeartButtonWidget> createState() => _HeartButtonWidgetState();
}

class _HeartButtonWidgetState extends State<HeartButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WishlistController>(
        init: WishlistController(),
        builder: (controller) {
          return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color,
              ),
              child: IconButton(
                onPressed: () async {
                  //  controller.addOrRemoveToWishList(productId: widget.productId);
                  controller.isLoading = true;
                  controller.update();
                  try {
                    if (controller.getWishListItem
                        .containsKey(widget.productId)) {
                      controller.removeWishListItemFromFirebase(
                          wishlistId:
                              controller.getWishListItem[widget.productId]!.id,
                          productId: widget.productId);
                    } else {
                      controller.addToWishListFirebase(
                          productId: widget.productId, buildContext: context);
                    }
                    await controller.fetchWishList();
                    controller.isLoading = false;
                    controller.update();
                  } catch (e) {
                    controller.isLoading = false;
                    controller.update();
                    ShowDialogWidget.showErrorORWarningDialog(
                        context: context, subtitle: e.toString(), fct: () {});
                  }
                  controller.isLoading = false;

                  controller.update();
                },
                icon: controller.isLoading
                    ? const CircularProgressIndicator()
                    : Icon(
                        IconlyLight.heart,
                        size: widget.iconSize,
                        color: controller.isAddedToWishList(widget.productId)
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
