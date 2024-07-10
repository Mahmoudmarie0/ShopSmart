import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shop_smart/consts/assets.dart';
import 'package:shop_smart/controller/search_controller.dart';

import '../models/cat_model.dart';

class HomeController extends GetxController {
  SEarchController searchController = SEarchController();
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
