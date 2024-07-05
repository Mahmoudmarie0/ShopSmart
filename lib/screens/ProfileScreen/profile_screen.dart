import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_smart/consts/assets.dart';
import 'package:shop_smart/screens/ViewedRecentlyScreen/viewed_recently_screen.dart';
import 'package:shop_smart/widgets/list_tile.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';
import 'package:shop_smart/widgets/title_text.dart';

import '../../controller/main_controller.dart';
import '../../widgets/app_name_text.dart';
import '../../widgets/show_dialog_widget.dart';
import '../WishlistScreen/wishlish_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (controller) => Scaffold(
          appBar: AppBar(
            title: const AppNameTextWidgets(
              fontSize: 20,
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(AssetsPaths.shoppingCart),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Visibility(
                  visible: false,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TitleTextWidget(
                        label: "Please login to have ultimate access"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).cardColor,
                            border: Border.all(
                                color: Theme.of(context).colorScheme.surface,
                                width: 3),
                            image: const DecorationImage(
                              image: NetworkImage(
                                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png",
                              ),
                              fit: BoxFit.fill,
                            )),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleTextWidget(label: "Mahmoud Marie"),
                          SubtitleTextWidget(
                            label: "mahmoudmarie500@gmail.com",
                            textDecorations: TextDecoration.none,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleTextWidget(label: "General"),
                      ListTileWidget(
                          imagePath: AssetsPaths.orderSvg,
                          text: "All Orders",
                          function: () {}),
                      ListTileWidget(
                          imagePath: AssetsPaths.wishlistSvg,
                          text: "Wishlist",
                          function: () async {
                           await Get.to(const WishlistScreen());
                          }),
                      ListTileWidget (
                          imagePath: AssetsPaths.recent,
                          text: "Viewed recently",
                          function: ()async {
                            await Get.to(const ViewedRecentlyScreen());

                          }),
                      ListTileWidget(
                          imagePath: AssetsPaths.address,
                          text: "Address",
                          function: () {}),
                      const Divider(
                        thickness: 1,
                      ),
                      const TitleTextWidget(label: "Settings"),
                      const SizedBox(
                        height: 7,
                      ),
                      SwitchListTile(
                          secondary: Image.asset(
                            AssetsPaths.theme,
                            height: 30,
                          ),
                          title: controller.getIsDarkTheme
                              ? const Text('Dark mode')
                              : const Text('Light mode'),
                          value: controller.getIsDarkTheme,
                          onChanged: (value) {
                            controller.setDarkTheme(themeValue: value);
                          }),
                      const Divider(
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
                Center(
                    child: ElevatedButton.icon(
                  onPressed: () async {
                    await ShowDialogWidget.showErrorORWarningDialog(
                      context: context,
                      subtitle: "Are you sure you want to logout?",
                      isError: false,
                      fct: () {}

                    );
                  },
                  label: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                ))
              ],
            ),
          )),
    );
  }
}
