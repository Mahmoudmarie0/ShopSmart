import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shop_smart/controller/cart_controller.dart';
import '../screens/HomeScreen/home_screen.dart';
import '../screens/CartScreen/cart_screen.dart';
import '../screens/ProfileScreen/profile_screen.dart';
import '../screens/SearchScreen/search_screen.dart';

class RootController extends GetxController {
  CartController cartController = Get.put(CartController());

  String getCartItemLength() {
    return cartController.cartItem.length.toString();
  }

  late PageController
      controller; // late==> init page controller  when screen open
  int currentScreen = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    controller = PageController(initialPage: currentScreen);
    getCartItemLength();
    update();
  }
}
