import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shop_smart/screens/RootScreen/root_screen.dart';

import '../widgets/show_dialog_widget.dart';

class LogInController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;
  late final formKey = GlobalKey<FormState>();
  bool obsecureText = true;
  bool isloading = false;

  @override
  void onInit() {
    // TODO: implement onInit
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    super.onInit();
    update();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
    update();
  }

  Future<void> login() async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(Get.context!).unfocus();
    if (isValid) {
      try {
        isloading = true;
        update();
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        Fluttertoast.showToast(
          msg: "Logged in successfully",
          textColor: Colors.white,
        );

        Get.to(() => const RootScreen());
      } on FirebaseAuthException catch (e) {
        ShowDialogWidget.showErrorORWarningDialog(
            context: Get.context!,
            subtitle: "An error occured ${e.message}",
            fct: () {});
        print(e);
      } finally {
        isloading = false;
        update();
      }
      // return;
    }
    // formKey.currentState!.save();
  }
}
