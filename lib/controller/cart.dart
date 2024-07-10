import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shop_smart/models/cart_model.dart';
import 'package:uuid/uuid.dart';

class CartController extends GetxController {
  final Map<String, CartModel> cartItem = {};
  bool isAddedToCart(String productId) {
    return cartItem.containsKey(productId);
  }

  AddToCart({required String productId}) {
    cartItem.putIfAbsent(
        productId,
        () => CartModel(
            cartId: const Uuid().v4(), productId: productId, quantity: 1));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    update();
  }
}
