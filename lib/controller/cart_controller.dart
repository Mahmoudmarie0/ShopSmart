import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shop_smart/controller/profile_controller.dart';
import 'package:shop_smart/models/cart_model.dart';
import 'package:uuid/uuid.dart';
import '../widgets/show_dialog_widget.dart';
import 'main_controller.dart';

class CartController extends GetxController {
  MainController mainController = Get.find();
  ProfileController profileController = Get.put(ProfileController());
  bool isLoading = false;

  void changeQuantity({required String productId, required int quantity}) {
    mainController.cartItem.update(
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
    mainController.cartItem.forEach((key, value) {
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
    mainController.cartItem.remove(productId);
    update();
  }

  void clearCart() {
    mainController.cartItem.clear();
    update();
  }

  Future<void> clearCartFromFirebase() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    try {
      await mainController.userDB.doc(user.uid).update({"userCart": []});
      mainController.cartItem.clear();
      update();
    } catch (e) {
      ShowDialogWidget.showErrorORWarningDialog(
          context: Get.context!, subtitle: e.toString(), fct: () {});
    }
  }

  Future<void> removeCartItemFromFirebase(
      {required String cartId,
      required String productId,
      required int quantity}) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    try {
      await mainController.userDB.doc(user.uid).update({
        "userCart": FieldValue.arrayRemove([
          {"cartId": cartId, "productId": productId, "quantity": quantity}
        ])
      });
      mainController.cartItem.remove(productId);
      await mainController.fetchCart();
      update();
    } catch (e) {
      ShowDialogWidget.showErrorORWarningDialog(
          context: Get.context!, subtitle: e.toString(), fct: () {});
    }
  }

  int getQtyuantity() {
    int total = 0;
    mainController.cartItem.forEach((key, value) {
      total += value.quantity;
    });
    return total;
    update();
  }

  Future<void> placeOrder() async {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      return;
    }
    final uid = user.uid;
    try {
      isLoading = true;
      update();
      mainController.getCartItem.forEach((key, value) async {
        final getCurrProduct = mainController.findByProdId(value.productId);
        final orderId = const Uuid().v4();
        await FirebaseFirestore.instance
            .collection("ordersAdvanced")
            .doc(orderId)
            .set({
          "orderId": orderId,
          "userId": uid,
          "productId": value.productId,
          "productTitle": getCurrProduct!.productTitle,
          "price": double.parse(getCurrProduct.productPrice) * value.quantity,
          "totalPrice":
              double.parse(getCurrProduct.productPrice) * value.quantity,
          "quantity": value.quantity,
          "imageUrl": getCurrProduct.productImage,
          //"userName": profileController.userModel?.userName,
          "orderDate": Timestamp.now(),
        });
        clearCart();
        isLoading = false;
        update();
      });
    } catch (e) {
      ShowDialogWidget.showErrorORWarningDialog(
          context: Get.context!, subtitle: e.toString(), fct: () {});
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    mainController.getCartItem;
    update();
  }
}
