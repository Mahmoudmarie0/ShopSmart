import 'package:get/get.dart';
import 'package:shop_smart/models/wishlist_model.dart';
import 'package:uuid/uuid.dart';
import 'main_controller.dart';

class WishlistController extends GetxController {
  final Map<String, WishlistModel> wishlistItem = {};

  Map<String, WishlistModel> get getWishListItem => wishlistItem;
  MainController mainController = Get.find();

  bool isAddedToWishList(String productId) {
    return wishlistItem.containsKey(productId);
  }

  void addOrRemoveToWishList({required String productId}) {
    if (wishlistItem.containsKey(productId)) {
      wishlistItem.remove(productId);
      update();
    } else {
      wishlistItem.putIfAbsent(productId,
          () => WishlistModel(id: const Uuid().v4(), productId: productId));
      update();
    }
    update();
  }

  void clearWishList() {
    wishlistItem.clear();
    update();
  }

  // int getQtyuantity() {
  //   int total = 0;
  //   cartItem.forEach((key, value) {
  //     total += value.quantity;
  //   });
  //   return total;
  //   update();
  // }
}
