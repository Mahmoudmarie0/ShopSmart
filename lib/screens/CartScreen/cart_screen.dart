import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_smart/consts/assets.dart';
import 'package:shop_smart/screens/CartScreen/Widgets/button_checkout.dart';
import 'package:shop_smart/widgets/empty_bag.dart';
import 'package:shop_smart/widgets/title_text.dart';
import '../../controller/cart_controller.dart';
import '../../widgets/show_dialog_widget.dart';
import 'Widgets/cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find();
    return cartController.mainController.getCartItem.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
            imagePath: AssetsPaths.shoppingBasket,
            title: 'Your cart is empty',
            subtitle:
                'Looks like you didn\'t add anything yet to your cart \ngo ahead and start shopping now',
            buttonText: 'Shop now',
          ))
        : GetBuilder<CartController>(
            init: CartController(),
            builder: (controller) {
              return Scaffold(
                bottomSheet: const CartButtonCheckout(),
                appBar: AppBar(
                  title: TitleTextWidget(
                    label:
                        "Cart (${controller.mainController.getCartItem.length})",
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
                              subtitle: "Remove all item from cart?",
                              isError: false,
                              fct: () {
                                cartController.clearCart();
                              });
                        },
                        icon: const Icon(
                          Icons.delete_forever_rounded,
                          color: Colors.red,
                        ))
                  ],
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount:
                              controller.mainController.getCartItem.length,
                          itemBuilder: (context, index) {
                            return CartWidget(
                              cartModel: controller
                                  .mainController.getCartItem.values
                                  .toList()
                                  .reversed
                                  .toList()[index],
                            );
                          }),
                    ),
                    const SizedBox(
                      height: kBottomNavigationBarHeight + 10,
                    )
                  ],
                ),
              );
            });
  }
}
