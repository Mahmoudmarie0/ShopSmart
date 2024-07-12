import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shop_smart/consts/assets.dart';
import 'package:shop_smart/controller/dash_board_controller.dart';
import 'package:shop_smart/screens/DashBoard/widgets/dashboard_btn.dart';
import 'package:shop_smart/widgets/title_text.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetBuilder<DashBoardController>(
        init: DashBoardController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const TitleTextWidget(label: "Dashboard Screen"),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsPaths.shoppingCart),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    controller.mainController.setDarkTheme(
                        themeValue: !controller.mainController.getIsDarkTheme);
                    controller.mainController.update();
                  },
                  icon: Icon(controller.mainController.getIsDarkTheme
                      ? Icons.light_mode
                      : Icons.dark_mode),
                ),
              ],
            ),
            body: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1,
              children: List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DashboardButtonsWidget(
                    title: controller.dashBoard[index].title,
                    imagePath: controller.dashBoard[index].image,
                    onPressed: () {
                      controller.dashBoard[index].onPressed();
                    },
                  ),
                ),
              ),
            ),
          );
        });
  }
}
