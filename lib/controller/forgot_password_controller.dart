import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  late final TextEditingController emailController;
  late final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    // TODO: implement onInit
    emailController = TextEditingController();
    super.onInit();
    update();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
    update();
  }

  Future<void> forgetPassFCT() async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(Get.context!).unfocus();
    if (isValid) {}
  }
}
