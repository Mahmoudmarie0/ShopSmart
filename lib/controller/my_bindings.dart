import 'package:get/get.dart';
import 'package:shop_smart/controller/main_controller.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController(), permanent: true);
    // Get.put(CartController(), permanent: true);
  }
}
