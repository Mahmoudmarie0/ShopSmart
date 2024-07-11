import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../models/viewed_prod_model.dart';
import 'main_controller.dart';

class ViewedRecentlyController extends GetxController {
  final Map<String, ViewedRecentlyModel> viewedRecently = {};

  Map<String, ViewedRecentlyModel> get getViewedRecently => viewedRecently;
  MainController mainController = Get.find();

  void addToViewedRecently({required String productId}) {
    viewedRecently.putIfAbsent(productId,
        () => ViewedRecentlyModel(id: const Uuid().v4(), productId: productId));
    update();
  }
}
