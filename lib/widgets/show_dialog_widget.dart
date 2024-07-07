import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';
import 'package:shop_smart/widgets/title_text.dart';

import '../consts/assets.dart';

class ShowDialogWidget {
  static Future<void> showErrorORWarningDialog(
      {required BuildContext context,
      required String subtitle,
      required Function fct,
      bool isError = true}) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AssetsPaths.warning,
                  height: 60,
                  width: 60,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                SubtitleTextWidget(
                  label: subtitle,
                  textDecorations: TextDecoration.none,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: !isError,
                      child: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const SubtitleTextWidget(
                            label: "Cancel",
                            textDecorations: TextDecoration.none,
                            color: Colors.green,
                          )),
                    ),
                    TextButton(
                        onPressed: () {
                          fct();
                          Get.back();
                        },
                        child: const SubtitleTextWidget(
                          label: "Ok",
                          textDecorations: TextDecoration.none,
                          color: Colors.red,
                        )),
                  ],
                )
              ],
            ),
          );
        });
  }

  static Future<void> imagePickerDialog(
      {required BuildContext context,
      required Function cameraFCT,
      required Function galleryFCT,
      required Function removeFCT}) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: TitleTextWidget(
                label: "Choose option",
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      cameraFCT();

                      Get.back();
                    },
                    icon: const Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                    label: const Text(
                      "Camera",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      galleryFCT();

                      Get.back();
                    },
                    icon: const Icon(
                      Icons.image,
                      color: Colors.blue,
                    ),
                    label: const Text(
                      "Gallery",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      removeFCT();

                      Get.back();
                    },
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.blue,
                    ),
                    label: const Text(
                      "Remove",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
