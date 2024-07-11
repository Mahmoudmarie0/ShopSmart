import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_smart/controller/viewed_recently_controller.dart';
import '../models/product_model.dart';
import 'main_controller.dart';

class SEarchController extends GetxController {
  TextEditingController searchController = TextEditingController();
  MainController mainController = Get.find();
  ViewedRecentlyController viewedRecentlyController = Get.find();

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

  void clearText() {
    searchController.clear();
    update();
  }

  List<ProductModel> findByCategory({required String ctgId}) {
    List<ProductModel> ctgList = mainController.localProds
        .where((element) =>
            element.productCategory.toLowerCase().contains(ctgId.toLowerCase()))
        .toList();
    return ctgList;
  }

  List<ProductModel> searchQuery(
      {required String searchText, required List<ProductModel> passedList}) {
    List<ProductModel> searchList = passedList
        .where((element) => element.productTitle
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();
    return searchList;
  }
}
