import 'package:get/get.dart';
import 'package:shop_smart/consts/assets.dart';
import 'package:shop_smart/controller/search_controller.dart';

import '../models/cat_model.dart';
import 'main_controller.dart';

class HomeController extends GetxController {
  SEarchController searchController = SEarchController();
  MainController mainController = Get.find();
  List<String> bannersImage = [AssetsPaths.banner1, AssetsPaths.banner2];
  List<CategoryModel> categories = [
    CategoryModel(
        id: AssetsPaths.mobiles, image: AssetsPaths.mobiles, name: "Phones"),
    CategoryModel(
        id: AssetsPaths.electronics,
        image: AssetsPaths.electronics,
        name: "Electronics"),
    CategoryModel(
        id: AssetsPaths.cosmetics,
        image: AssetsPaths.cosmetics,
        name: "Cosmetics"),
    CategoryModel(
        id: AssetsPaths.shoes, image: AssetsPaths.shoes, name: "Shoes"),
    CategoryModel(id: AssetsPaths.book, image: AssetsPaths.book, name: "Books"),
    CategoryModel(
        id: AssetsPaths.watch, image: AssetsPaths.watch, name: "Watches"),
  ];
}
