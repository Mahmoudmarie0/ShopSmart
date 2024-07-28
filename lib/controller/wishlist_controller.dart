import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shop_smart/models/wishlist_model.dart';
import 'package:uuid/uuid.dart';
import '../widgets/show_dialog_widget.dart';
import 'main_controller.dart';

class WishlistController extends GetxController {
  final Map<String, WishlistModel> wishlistItem = {};
  bool isLoading = false;

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

  final auth = FirebaseAuth.instance;
  final userDB = FirebaseFirestore.instance.collection("users");

  Future<void> addToWishListFirebase(
      {required String productId, required BuildContext buildContext}) async {
    final User? user = auth.currentUser;
    if (user == null) {
      ShowDialogWidget.showErrorORWarningDialog(
          context: buildContext, subtitle: 'No user logged in', fct: () {});
      return;
    }

    final uid = user.uid;
    final wishListId = const Uuid().v4();
    try {
      await userDB.doc(uid).update({
        'userWish': FieldValue.arrayUnion([
          {
            "wishlistId": wishListId,
            "productId": productId,
          }
        ])
      });
      // await fetchWishList();
      Fluttertoast.showToast(
        msg: "Item has been added to wishlist",
      );
    } catch (e) {
      ShowDialogWidget.showErrorORWarningDialog(
          context: buildContext, subtitle: e.toString(), fct: () {});
    }
  }

  Future<void> fetchWishList() async {
    User? user = auth.currentUser;
    if (user == null) {
      wishlistItem.clear();
      return;
    }
    try {
      final userDoc = await userDB.doc(user.uid).get();
      final data = userDoc.data();
      if (data == null || !data.containsKey("userWish")) {
        return;
      }
      final leng = userDoc.get("userWish").length;

      for (int i = 0; i < leng; i++) {
        wishlistItem.putIfAbsent(
            userDoc.get("userWish")[i]["productId"],
            () => WishlistModel(
                  id: userDoc.get("userWish")[i]["wishlistId"],
                  productId: userDoc.get("userWish")[i]["productId"],
                ));
        update();
      }
    } catch (e) {
      ShowDialogWidget.showErrorORWarningDialog(
          context: Get.context!, subtitle: e.toString(), fct: () {});
    }
  }

  Future<void> clearWishListFromFirebase() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    try {
      await mainController.userDB.doc(user.uid).update({"userWish": []});
      wishlistItem.clear();
      update();
    } catch (e) {
      ShowDialogWidget.showErrorORWarningDialog(
          context: Get.context!, subtitle: e.toString(), fct: () {});
    }
  }

  Future<void> removeWishListItemFromFirebase({
    required String wishlistId,
    required String productId,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    try {
      await mainController.userDB.doc(user.uid).update({
        "userWish": FieldValue.arrayRemove([
          {"wishlistId": wishlistId, "productId": productId}
        ])
      });
      wishlistItem.remove(productId);
      // await fetchWishList();
      update();
    } catch (e) {
      ShowDialogWidget.showErrorORWarningDialog(
          context: Get.context!, subtitle: e.toString(), fct: () {});
    }
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
