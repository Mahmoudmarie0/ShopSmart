import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';
import 'package:shop_smart/widgets/title_text.dart';

import '../../consts/my_validators.dart';
import '../../controller/upload_new_product_controller.dart';
import '../../widgets/pick_image_widget.dart';

class UploadNewProductScreen extends StatelessWidget {
  const UploadNewProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<UploadNewProductController>(
        init: UploadNewProductController(),
        builder: (controller) {
          return Scaffold(
            bottomSheet: SizedBox(
              height: kBottomNavigationBarHeight + 10,
              child: Material(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(12),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                      ),
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Clear",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {},
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.all(12),
                        // backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                      ),
                      icon: const Icon(
                        Icons.upload,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Upload Product",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        controller.uploadProduct();
                      },
                    ),
                  ],
                ),
              ),
            ),
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: const TitleTextWidget(
                label: "Upload a new product",
              ),
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      /* Image picker here ***********************************/
                      const PickImageWidget(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                controller.localImagePicker();
                              },
                              child: const Text("pick another image ",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ))),
                          TextButton(
                              onPressed: () {
                                controller.removeImage();
                              },
                              child: const Text("Remove image",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ))),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      DropdownButton(
                          hint: const Text("Select Category"),
                          value: controller.categoryValue,
                          items: controller.categoriesDropdownList,
                          onChanged: (String? value) {
                            controller.categoryValue = value!;
                          }),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 0),
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: controller.titleController,
                                key: const ValueKey('Title'),
                                maxLength: 80,
                                minLines: 1,
                                maxLines: 2,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                decoration: const InputDecoration(
                                  filled: true,
                                  contentPadding: EdgeInsets.all(12),
                                  hintText: 'Product Title',
                                ),
                                validator: (value) {
                                  return MyValidators.uploadProdTexts(
                                    value: value,
                                    toBeReturnedString:
                                        "Please enter a valid title",
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: TextFormField(
                                      controller: controller.priceController,
                                      key: const ValueKey('Price \$'),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'^(\d+)?\.?\d{0,2}'),
                                        ),
                                      ],
                                      decoration: const InputDecoration(
                                          filled: true,
                                          contentPadding: EdgeInsets.all(12),
                                          hintText: 'Price',
                                          prefix: SubtitleTextWidget(
                                            label: "\$ ",
                                            color: Colors.blue,
                                            fontSize: 16,
                                            textDecorations:
                                                TextDecoration.none,
                                          )),
                                      validator: (value) {
                                        return MyValidators.uploadProdTexts(
                                          value: value,
                                          toBeReturnedString:
                                              "Price is missing",
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: TextFormField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      controller: controller.quantityController,
                                      keyboardType: TextInputType.number,
                                      key: const ValueKey('Quantity'),
                                      decoration: const InputDecoration(
                                        filled: true,
                                        contentPadding: EdgeInsets.all(12),
                                        hintText: 'Qty',
                                      ),
                                      validator: (value) {
                                        return MyValidators.uploadProdTexts(
                                          value: value,
                                          toBeReturnedString:
                                              "Quantity is missed",
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                                key: const ValueKey('Description'),
                                controller: controller.descriptionController,
                                minLines: 3,
                                maxLines: 8,
                                maxLength: 1000,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: const InputDecoration(
                                  filled: true,
                                  contentPadding: EdgeInsets.all(12),
                                  hintText: 'Product description',
                                ),
                                validator: (value) {
                                  return MyValidators.uploadProdTexts(
                                    value: value,
                                    toBeReturnedString: "Description is missed",
                                  );
                                },
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height:
                            WidgetsBinding.instance.window.viewInsets.bottom >
                                    0.0
                                ? 10
                                : kBottomNavigationBarHeight + 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
