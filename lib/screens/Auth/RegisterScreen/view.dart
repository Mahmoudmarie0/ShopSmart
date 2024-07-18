import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:iconly/iconly.dart';
import 'package:shop_smart/controller/register_controller.dart';
import 'package:shop_smart/screens/Auth/RegisterScreen/widgets/pick_image_widget.dart';
import 'package:shop_smart/widgets/loading_manager.dart';

import '../../../consts/my_validators.dart';
import '../../../widgets/app_name_text.dart';
import '../../../widgets/title_text.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (controller) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              body: LoadingManager(
                isLoading: controller.isloading,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 60.0,
                        ),
                        const AppNameTextWidgets(
                          fontSize: 30,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: TitleTextWidget(
                              label: "Welcome",
                            )),
                        const SizedBox(
                          height: 16.0,
                        ),
                        SizedBox(
                            height: size.width * 0.3,
                            width: size.width * 0.3,
                            child: PickImageWidget(
                              function: () async {
                                await controller.localImagePicker();
                              },
                              pickedImage: controller.pickedImage,
                            )),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Form(
                          key: controller.formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                controller: controller.usernameController,
                                focusNode: controller.usernameFocusNode,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  hintText: "user123",
                                  prefixIcon: Icon(IconlyLight.profile),
                                ),
                                validator: (value) {
                                  return MyValidators.displayNamevalidator(
                                      value);
                                },
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(controller.emailFocusNode);
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                controller: controller.emailController,
                                focusNode: controller.emailFocusNode,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  hintText: "Email address",
                                  prefixIcon: Icon(IconlyLight.message),
                                ),
                                validator: (value) {
                                  return MyValidators.emailValidator(value);
                                },
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context).requestFocus(
                                      controller.passwordFocusNode);
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                controller: controller.passwordController,
                                focusNode: controller.passwordFocusNode,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: controller.obsecureText,
                                decoration: InputDecoration(
                                  hintText: "***********",
                                  prefixIcon: const Icon(IconlyLight.lock),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.obsecureText =
                                          !controller.obsecureText;
                                      controller.update();
                                    },
                                    icon: Icon(controller.obsecureText
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                ),
                                validator: (value) {
                                  return MyValidators.passwordValidator(value);
                                },
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context).requestFocus(
                                      controller.confirmpasswordFocusNode);
                                  controller.register();
                                  controller.update();
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                controller:
                                    controller.confirmpasswordController,
                                focusNode: controller.confirmpasswordFocusNode,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: controller.obsecureText,
                                decoration: InputDecoration(
                                  hintText: "***********",
                                  prefixIcon: const Icon(IconlyLight.lock),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.obsecureText =
                                          !controller.obsecureText;
                                      controller.update();
                                    },
                                    icon: Icon(controller.obsecureText
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                ),
                                validator: (value) {
                                  return MyValidators.repeatPasswordValidator(
                                      value: value,
                                      password:
                                          controller.passwordController.text);
                                },
                                onFieldSubmitted: (value) {
                                  controller.register();
                                  controller.update();
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    await controller.register();
                                  },
                                  icon: const Icon(
                                    IconlyLight.add_user,
                                    color: Colors.white,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(12.0),
                                      backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      )),
                                  label: const Text(
                                    'Sign up',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
