import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shop_smart/screens/OrderScreen/widgets/orders_widget.dart';
import '../../../../widgets/empty_bag.dart';
import '../../consts/assets.dart';
import '../../controller/orders_controller.dart';
import '../../models/order_model.dart';
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
            body: FutureBuilder<List<OrdersModelAdvanced>>(
                future: controller.fetchOrder(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (!snapshot.hasData ||
                      controller.getOrders.isEmpty) {
                    return EmptyBagWidget(
                      imagePath: AssetsPaths.orderBag,
                      title: 'No orders yet',
                      subtitle: 'You have not placed any orders yet',
                      buttonText: 'Shop now',
                    );
                  }
                  return ListView.separated(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 6),
                        child: OrdersWidget(
                          ordersModelAdvanced: controller.getOrders[index],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  );
                })),
          );
        });
  }
}
