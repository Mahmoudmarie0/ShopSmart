import 'package:flutter/material.dart';
import 'package:shop_smart/consts/assets.dart';
import 'package:shop_smart/screens/button_checkout.dart';
import 'package:shop_smart/widgets/empty_bag.dart';
import 'package:shop_smart/widgets/title_text.dart';
import '../widgets/cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  final bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
            imagePath: AssetsPaths.shoppingBasket,
            title: 'Your cart is empty',
            subtitle:
                'Looks like you didn\'t add anything yet to your cart \ngo ahead and start shopping now',
            buttonText: 'Shop now',
          ))
        : Scaffold(
      bottomSheet:const CartButtonCheckout(),
            appBar: AppBar(
              title: const TitleTextWidget(
                label: "Cart (5)",
              ),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsPaths.shoppingCart),
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete_forever_rounded,color: Colors.red,))
              ],
            ),
            body: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return const CartWidget();
                }),
          );
  }
}
