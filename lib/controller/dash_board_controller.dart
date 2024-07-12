import 'package:get/get.dart';
import 'package:shop_smart/consts/assets.dart';
import 'package:shop_smart/controller/main_controller.dart';

import '../models/dash_board_model.dart';

class DashBoardController extends GetxController {
  MainController mainController = Get.find();
   List <DashBoardModel> dashBoard = [
    DashBoardModel(title: 'Add a new product', image: AssetsPaths.cloud, onPressed: (){}),
    DashBoardModel(title: 'inspect all products', image: AssetsPaths.shoppingCart, onPressed: (){}),
    DashBoardModel(title: 'view orders', image: AssetsPaths.order, onPressed: (){}),
  ];



}