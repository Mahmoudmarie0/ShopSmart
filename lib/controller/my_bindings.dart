import 'package:get/get.dart';
import 'package:shop_smart/controller/main_controller.dart';
import 'package:shop_smart/controller/viewed_recently_controller.dart';
import 'package:shop_smart/controller/wishlist_controller.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController(), permanent: true);
    Get.put(WishlistController(), permanent: true);
    Get.put(ViewedRecentlyController(), permanent: true);

    // Get.put(CartController(), permanent: true);
  }
}
