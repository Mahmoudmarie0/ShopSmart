import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import '../screens/home_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';

class RootController extends GetxController {
  late PageController controller; // late==> init page controller  when screen open
  int currentScreen = 0;
  List<Widget>screens = [
    const HomeScreen(),
    const SearchScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    controller = PageController(initialPage:currentScreen);

  }

}