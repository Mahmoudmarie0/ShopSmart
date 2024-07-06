import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LogInController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;
  late final formKey = GlobalKey<FormState>();
  bool obsecureText = true;

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
      // return;
    }
    // formKey.currentState!.save();
  }
}
