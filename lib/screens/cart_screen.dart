import 'package:flutter/material.dart';
import 'package:shop_smart/consts/assets.dart';
import 'package:shop_smart/widgets/empty_bag.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: EmptyBagWidget(
      imagePath: AssetsPaths.shoppingBasket,
      title: 'Your cart is empty',
      subtitle:
          'Looks like you didn\'t add anything yet to your cart \ngo ahead and start shopping now',
      buttonText: 'Shop now',
    ));
  }
}
