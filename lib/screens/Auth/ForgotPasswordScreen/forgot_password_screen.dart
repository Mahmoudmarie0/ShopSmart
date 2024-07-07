import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:iconly/iconly.dart';
import 'package:shop_smart/consts/assets.dart';
import 'package:shop_smart/controller/forgot_password_controller.dart';
import 'package:shop_smart/widgets/app_name_text.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';
import 'package:shop_smart/widgets/title_text.dart';

import '../../../consts/my_validators.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<ForgotPasswordController>(
        init: ForgotPasswordController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const AppNameTextWidgets(
                fontSize: 22,
              ),
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SafeArea(
                child: ListView(
                  // shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    // Section 1 - Header
                    const SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      AssetsPaths.forgotPassword,
                      width: size.width * 0.6,
                      height: size.width * 0.6,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TitleTextWidget(
                      label: 'Forgot password',
                      fontSize: 22,
                    ),
                    const SubtitleTextWidget(
                      label:
                          'Please enter the email address you\'d like your password reset information sent to',
                      fontSize: 14,
                      textDecorations: TextDecoration.none,
                    ),
                    const SizedBox(
                      height: 40,
                    ),

                    Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: controller.emailController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'youremail@email.com',
                              prefixIcon: Container(
                                padding: const EdgeInsets.all(12),
                                child: const Icon(IconlyLight.message),
                              ),
                              filled: true,
                            ),
                            validator: (value) {
                              return MyValidators.emailValidator(value);
                            },
                            onFieldSubmitted: (_) {
                              // Move focus to the next field when the "next" button is pressed
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                          // backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                        ),
                        icon: const Icon(IconlyBold.send),
                        label: const Text(
                          "Request link",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () async {
                          controller.forgetPassFCT();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
