import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/order_model.dart';
import '../widgets/show_dialog_widget.dart';

class OrdersControllerController extends GetxController {
  bool isEmptyOrders = false;
  final List<OrdersModelAdvanced> orders = [];

  List<OrdersModelAdvanced> get getOrders => orders;

  Future<List<OrdersModelAdvanced>> fetchOrder() async {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    // if (user == null) {
    //   return;
    // }
    final uid = user!.uid;
    try {
      await FirebaseFirestore.instance
          .collection("ordersAdvanced")
          .get()
          .then((value) {
        orders.clear();
        for (var element in value.docs) {
          orders.insert(
              0,
              OrdersModelAdvanced(
                  orderId: element.get("orderId"),
                  productId: element.get("productId"),
                  userId: element.get("userId"),
                  price: element.get("price").toString(),
                  productTitle: element.get("productTitle").toString(),
                  quantity: element.get("quantity").toString(),
                  imageUrl: element.get("imageUrl"),
                  // userName: element.get("userName") ,
                  orderDate: element.get("orderDate")));
          return orders;
        }
      });
    } catch (e) {
      ShowDialogWidget.showErrorORWarningDialog(
          context: Get.context!, subtitle: e.toString(), fct: () {});
    }
    return orders;
  }
  // Future<List<OrdersModelAdvanced>> fetchOrder(BuildContext context) async {
  //   final auth = FirebaseAuth.instance;
  //   User? user = auth.currentUser;
  //
  //   // Handle case where user is not authenticated
  //   if (user == null) {
  //     ShowDialogWidget.showErrorORWarningDialog(
  //         context: context, subtitle: 'User is not authenticated', fct: () {});
  //     return [];
  //   }
  //
  //   final uid = user.uid;
  //   List<OrdersModelAdvanced> orders = [];
  //
  //   try {
  //     final snapshot = await FirebaseFirestore.instance.collection("ordersAdvanced").get();
  //     for (var element in snapshot.docs) {
  //
  //         orders.insert(0, OrdersModelAdvanced(
  //             orderId: element.get("orderId"),
  //             productId: element.get("productId"),
  //             userId: element.get("userId"),
  //             price: element.get("price").toString(),
  //             productTitle: element.get("productTitle").toString(),
  //             quantity: element.get("quantity").toString(),
  //             imageUrl: element.get("imageUrl"),
  //             userName: element.get("userName"),
  //             orderDate: element.get("orderDate")
  //         ));
  //
  //     }
  //   } catch (e) {
  //     ShowDialogWidget.showErrorORWarningDialog(
  //         context: context, subtitle: e.toString(), fct: () {});
  //     return [];
  //   }
  //
  //   return orders;
  // }

  @override
  void onInit() {
    super.onInit();
    fetchOrder();
    update();
  }
}
