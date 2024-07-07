import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

class RegisterController extends GetxController {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmpasswordController;
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;
  late final FocusNode confirmpasswordFocusNode;
  late final FocusNode usernameFocusNode;
  late final formKey = GlobalKey<FormState>();
  bool obsecureText = true;
  XFile? pickedImage;

  @override
  void onInit() {
    // TODO: implement onInit
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmpasswordController = TextEditingController();
    usernameController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmpasswordFocusNode = FocusNode();
    usernameFocusNode = FocusNode();
    super.onInit();
    update();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmpasswordFocusNode.dispose();
    usernameFocusNode.dispose();
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
