import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:iconly/iconly.dart';
import 'package:shop_smart/controller/root_controller.dart';


class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}
RootController rootController = Get.put(RootController());

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller:rootController.controller,
        physics: const NeverScrollableScrollPhysics(),
        children: rootController.screens,
      ),

      bottomNavigationBar:NavigationBar(
        selectedIndex: rootController.currentScreen,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 2,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: (index){
          setState(() {
            rootController.currentScreen = index;
          });
           rootController.controller.jumpToPage(index);
          // print(rootController.currentScreen);
        }, destinations:const [

          NavigationDestination(
              selectedIcon: Icon(IconlyBold.home),
              icon: Icon(IconlyLight.home), label: "Home"),
          NavigationDestination(icon: Icon(IconlyLight.search), label: "Search",
              selectedIcon: Icon(IconlyBold.search),
      ),
          NavigationDestination(
            icon: Badge(
              backgroundColor: Colors.blue,
                label: Text("6"),
                child: Icon(IconlyLight.bag_2)),
            label: "Cart",
            selectedIcon: Icon(IconlyBold.bag_2),
          ),
          NavigationDestination(icon: Icon(IconlyLight.profile), label: "Profile",
            selectedIcon: Icon(IconlyBold.profile),
          ),
      ],

      ) ,




    );
  }
}
