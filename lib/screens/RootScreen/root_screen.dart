import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:iconly/iconly.dart';
import 'package:shop_smart/controller/root_controller.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootController>(
        init: RootController(),
        builder: (controller) => Scaffold(
              body: PageView(
                controller: controller.controller,
                physics: const NeverScrollableScrollPhysics(),
                children: controller.screens,
              ),
              bottomNavigationBar: NavigationBar(
                selectedIndex: controller.currentScreen,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 2,
                height: kBottomNavigationBarHeight,
                onDestinationSelected: (index) {
                  setState(() {
                    controller.currentScreen = index;
                  });
                  controller.controller.jumpToPage(index);
                  // print(rootController.currentScreen);
                },
                destinations: [
                  const NavigationDestination(
                      selectedIcon: Icon(IconlyBold.home),
                      icon: Icon(IconlyLight.home),
                      label: "Home"),
                  const NavigationDestination(
                    icon: Icon(IconlyLight.search),
                    label: "Search",
                    selectedIcon: Icon(IconlyBold.search),
                  ),
                  NavigationDestination(
                    icon: Badge(
                        backgroundColor: Colors.blue,
                        label: Text(controller.getCartItemLength()),
                        child: const Icon(IconlyLight.bag_2)),
                    label: "Cart",
                    selectedIcon: const Icon(IconlyBold.bag_2),
                  ),
                  const NavigationDestination(
                    icon: Icon(IconlyLight.profile),
                    label: "Profile",
                    selectedIcon: Icon(IconlyBold.profile),
                  ),
                ],
              ),
            ));
  }
}
