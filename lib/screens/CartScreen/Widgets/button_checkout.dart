import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';
import 'package:shop_smart/widgets/title_text.dart';

import '../../../controller/cart_controller.dart';

class CartButtonCheckout extends StatelessWidget {
  const CartButtonCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        init: CartController(),
        builder: (controller) {
          return Container(
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: const Border(
                    top: BorderSide(width: 1, color: Colors.grey))),
            child: SizedBox(
              height: kBottomNavigationBarHeight + 10,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                              child: TitleTextWidget(
                                  label:
                                      "Total (${controller.mainController.getCartItem.length} products/${controller.getQtyuantity()} Items)")),
                          SubtitleTextWidget(
                            label: "${controller.getTotalPrice()}\$",
                            textDecorations: TextDecoration.none,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[300],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Checkout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
