import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shop_smart/controller/upload_new_product_controller.dart';

class PickImageWidget extends StatelessWidget {
  const PickImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<UploadNewProductController>(builder: (controller) {
      return controller.pickedImage == null
          ? SizedBox(
              width: size.width * 0.4 + 10,
              height: size.width * 0.4,
              child: Column(
                children: [
                  DottedBorder(
                    color: Colors.blue,
                    radius: const Radius.circular(12),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.image_outlined,
                            size: 80,
                            color: Colors.blue,
                          ),
                          TextButton(
                            onPressed: () {
                              controller.localImagePicker();
                            },
                            child: const Text("pick product image"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(controller.pickedImage!.path),
                height: size.width * 0.5,
              ),
            );
    });
  }
}
