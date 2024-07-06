import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:shop_smart/consts/my_validators.dart';
import 'package:shop_smart/widgets/app_name_text.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';
import 'package:shop_smart/widgets/title_text.dart';
import '../../../controller/log_in_controller.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LogInController>(
        init: LogInController(),
        builder: (controller) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              body: Padding(
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
                            label: "Welcome back!",
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
                                FocusScope.of(context)
                                    .requestFocus(controller.passwordFocusNode);
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
                                controller.login();
                                controller.update();
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: () {},
                                  child: const SubtitleTextWidget(
                                    label: 'Forgot password?',
                                    textDecorations: TextDecoration.underline,
                                    fontStyle: FontStyle.italic,
                                  )),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  controller.login();
                                },
                                label: const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.login,
                                  color: Colors.white,
                                ),
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(12.0),
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const SubtitleTextWidget(
                                label: "OR CONNECT USING",
                                textDecorations: TextDecoration.none),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    controller.login();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(12.0),
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .surface,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      )),
                                  child: const Text(
                                    'Guest',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SubtitleTextWidget(
                                    label: "Don't have an account?",
                                    textDecorations: TextDecoration.none),
                                TextButton(
                                    onPressed: () {},
                                    child: const SubtitleTextWidget(
                                      label: 'Sign up',
                                      textDecorations: TextDecoration.underline,
                                      fontStyle: FontStyle.italic,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
