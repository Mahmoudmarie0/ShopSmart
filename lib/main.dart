import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_smart/consts/theme_data.dart';
import 'package:shop_smart/controller/main_controller.dart';
import 'package:shop_smart/controller/my_bindings.dart';
import 'package:shop_smart/firebase_options.dart';
import 'package:shop_smart/screens/RootScreen/root_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

MainController mainController = Get.put(MainController());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
        init: MainController(),
        builder: (controller) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialBinding: MyBindings(),
            title: 'Shop Smart',
            theme: Styles.themeData(
                isDarkTheme: controller.getIsDarkTheme, context: context),
            home: const RootScreen(),
            // const LogInScreen(),
            // const RegisterScreen(),
          );
        });
  }
}
