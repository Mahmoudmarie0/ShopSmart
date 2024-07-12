import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shop_smart/screens/OrderScreen/widgets/orders_widget.dart';
import '../../../../widgets/empty_bag.dart';
import '../../consts/assets.dart';
import '../../controller/orders_controller.dart';
import '../../widgets/title_text.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersControllerController>(
        init: OrdersControllerController(),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                title: const TitleTextWidget(
                  label: 'Placed orders',
                ),
              ),
              body: controller.isEmptyOrders
                  ? EmptyBagWidget(
                      imagePath: AssetsPaths.order,
                      title: "No orders has been placed yet",
                      subtitle: "",
                      buttonText: "Shop now")
                  : ListView.separated(
                      itemCount: 15,
                      itemBuilder: (ctx, index) {
                        return const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                          child: OrdersWidget(),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    ));
        });
  }
}
