
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SEarchController extends GetxController {
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //not save in memory
    searchController.dispose();
  }


  void clearText(){
    searchController.clear();
    update();
  }



}