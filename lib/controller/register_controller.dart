import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import '../screens/RootScreen/root_screen.dart';
import '../widgets/show_dialog_widget.dart';

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
  bool isloading = false;
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

  Future<void> register() async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(Get.context!).unfocus();
    if (isValid) {
      formKey.currentState!.save();
      // if (pickedImage == null) {
      //   ShowDialogWidget.showErrorORWarningDialog(
      //       context: Get.context!,
      //       subtitle: 'Make sure you pick an image',
      //       fct: () {});
      // }
      try {
        isloading = true;
        update();
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        User user = FirebaseAuth.instance.currentUser!;
        final uid = user.uid;
        await FirebaseFirestore.instance.collection("users").doc(uid).set({
          'userId': uid,
          'userName': usernameController.text,
          'userImage': '',
          'userEmail': emailController.text.toLowerCase(),
          'createdAt': Timestamp.now(),
          'userCart': [],
          'userWish': [],
        });
        Fluttertoast.showToast(
          msg: "Account created successfully",
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
    }
    // formKey.currentState!.save();
  }

//   cameraFCT: () {},
// galleryFCT: () {},
// removeFCT: () {},

  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await ShowDialogWidget.imagePickerDialog(
        context: Get.context!,
        cameraFCT: () async {
          pickedImage = await picker.pickImage(source: ImageSource.camera);
          update();
        },
        galleryFCT: () async {
          pickedImage = await picker.pickImage(source: ImageSource.gallery);
          update();
        },
        removeFCT: () {
          pickedImage = null;
          update();
        });
  }
}
