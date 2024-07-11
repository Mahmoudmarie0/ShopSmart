// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:shop_smart/models/cart_model.dart';
// import 'package:uuid/uuid.dart';
//
// class CartController extends GetxController {
//   final Map<String, CartModel> cartItem = {};
//   bool isAddedToCart(String productId) {
//     return cartItem.containsKey(productId);
//   }
//
//
//
//
//  void addToCart({required String productId}) {
//     cartItem.putIfAbsent(
//         productId,
//         () => CartModel(
//             cartId: const Uuid().v4(), productId: productId, quantity: 1)
//     );
//     update();
//   }
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     update();
//
//   }
//
//
// }
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shop_smart/controller/search_controller.dart';
import 'package:shop_smart/models/cart_model.dart';
import 'package:uuid/uuid.dart';

class CartController extends GetxController {
  final Map<String, CartModel> cartItem = {};

  Map<String, CartModel> get getCartItem => cartItem;
  SEarchController searchController = SEarchController();

  bool isAddedToCart(String productId) {
    return cartItem.containsKey(productId);
  }

  // void addToCart({required String productId}) {
  //   if (isAddedToCart(productId)) {
  //     cartItem.remove(productId);
  //   } else {
  //     cartItem[productId] = CartModel(
  //       cartId: const Uuid().v4(),
  //       productId: productId,
  //       quantity: 1,
  //     );
  //   }
  //   update();
  // }

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
      String price =
          searchController.findByProdId(value.productId)!.productPrice;
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCartItem;
    update();
  }
}
