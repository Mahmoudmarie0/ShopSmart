import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ForgotPasswordController extends GetxController {
  late final TextEditingController _emailController;
  late final _formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    // TODO: implement onInit
    _emailController = TextEditingController();
    super.onInit();
  }


  @override
  void dispose() {
    // TODO: implement dispose
      _emailController.dispose();
    super.dispose();
    update();
  }

  Future<void> _forgetPassFCT() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(Get.context!).unfocus();
    if (isValid) {}
  }



}