import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_smart/consts/app_colors.dart';
import 'package:shop_smart/controller/main_controller.dart';

import '../widgets/subtitle_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (controller) =>
         Scaffold(

           body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
          const SubtitleTextWidget(label: "hi again",fontSize: 70, textDecorations: TextDecoration.underline,),
           ElevatedButton(onPressed: (){}, child:const Text('Hello World'),),
           SwitchListTile(
               title: controller.getIsDarkTheme ? const Text('Dark mode') : const Text('Light mode'),
               value: controller.getIsDarkTheme,
               onChanged: (value) {
                 controller.setDarkTheme(themeValue: value);
               }),
         ],
           ),


        ),

    );
  }
}
