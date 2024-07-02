import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
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
        onDestinationSelected: (index){
          setState(() {
            rootController.currentScreen = index;
          });
           rootController.controller.jumpToPage(index);
          // print(rootController.currentScreen);
        }, destinations: [],

      ) ,




    );
  }
}
