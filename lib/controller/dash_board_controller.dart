import 'package:get/get.dart';
import 'package:shop_smart/consts/assets.dart';
import 'package:shop_smart/controller/main_controller.dart';
import 'package:shop_smart/screens/SearchScreen/search_screen.dart';
import '../models/dash_board_model.dart';
import '../screens/OrderScreen/order_screen.dart';
import '../screens/UploadNewProduct/view.dart';

class DashBoardController extends GetxController {
  MainController mainController = Get.find();
  List<DashBoardModel> dashBoard = [
    DashBoardModel(
        title: 'Add a new product',
        image: AssetsPaths.cloud,
        onPressed: () {
          Get.to(const UploadNewProductScreen());
        }),
    DashBoardModel(
        title: 'inspect all products',
        image: AssetsPaths.shoppingCart,
        onPressed: () {
          Get.to(const SearchScreen());
        }),
    DashBoardModel(
        title: 'view orders',
        image: AssetsPaths.order,
        onPressed: () {
          Get.to(const OrdersScreen());
        }),
  ];
}
