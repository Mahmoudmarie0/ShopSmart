import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../models/cart_model.dart';
import 'main_controller.dart';

class WishlistController extends GetxController {
  final Map<String, CartModel> cartItem = {};

  Map<String, CartModel> get getCartItem => cartItem;
  MainController mainController = Get.find();

  bool isAddedToCart(String productId) {
    return cartItem.containsKey(productId);
  }

  void addToCart({required String productId}) {
    cartItem.putIfAbsent(
        productId,
        () => CartModel(
            cartId: const Uuid().v4(), productId: productId, quantity: 1));
    update();
  }

  void changeQuantity({required String productId, required int quantity}) {
    cartItem.update(
      productId,
      (value) => CartModel(
        cartId: value.cartId,
        productId: productId,
        quantity: quantity,
      ),
    );
    update();
  }

  double getTotalPrice() {
    double total = 0.0;
    cartItem.forEach((key, value) {
      String price = mainController.findByProdId(value.productId)!.productPrice;
      if (price.isEmpty) {
        return;
      } else {
        total += double.parse(price) * value.quantity;
      }
    });
    return total;
  }

  void removeOneItem(String productId) {
    cartItem.remove(productId);
    update();
  }

  void clearCart() {
    cartItem.clear();
    update();
  }

  int getQtyuantity() {
    int total = 0;
    cartItem.forEach((key, value) {
      total += value.quantity;
    });
    return total;
    update();
  }
}
