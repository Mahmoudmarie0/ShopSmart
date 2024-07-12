import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/show_dialog_widget.dart';

class UploadNewProductController extends GetxController {
  XFile? pickedImage;
  late TextEditingController titleController;
  late TextEditingController priceController;
  late TextEditingController quantityController;
  late TextEditingController descriptionController;
  late final FocusNode titleFocusNode;
  late final FocusNode priceFocusNode;
  late final FocusNode quantityFocusNode;
  late final FocusNode descriptionFocusNode;
  late final formKey = GlobalKey<FormState>();
  String? categoryValue;

  @override
  void onInit() {
    // TODO: implement onInit
    titleController = TextEditingController();
    priceController = TextEditingController();
    quantityController = TextEditingController();
    descriptionController = TextEditingController();
    titleFocusNode = FocusNode();
    priceFocusNode = FocusNode();
    quantityFocusNode = FocusNode();
    descriptionFocusNode = FocusNode();
    super.onInit();
    update();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    priceController.dispose();
    quantityController.dispose();
    descriptionController.dispose();
    titleFocusNode.dispose();
    priceFocusNode.dispose();
    quantityFocusNode.dispose();
    descriptionFocusNode.dispose();
    update();
  }

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

  void clearText() {
    titleController.clear();
    priceController.clear();
    quantityController.clear();
    descriptionController.clear();
    removeImage();
    update();
  }

  void removeImage() {
    pickedImage = null;
    update();
  }

  Future<void> uploadProduct() async {
    //final isValid = formKey.currentState!.validate();
    FocusScope.of(Get.context!).unfocus();
    if (categoryValue == null) {
      ShowDialogWidget.showErrorORWarningDialog(
          context: Get.context!,
          subtitle: 'Please select a category',
          fct: () {});
      return;
    }
    final isValid = formKey.currentState!.validate();

    if (isValid) {
      formKey.currentState!.save();
      if (pickedImage == null) {
        ShowDialogWidget.showErrorORWarningDialog(
            context: Get.context!,
            subtitle: 'Make sure you pick an image',
            fct: () {});
      }
    }
    // formKey.currentState!.save();
  }

  List<String> categoriesList = [
    "phones",
    "clothes",
    "Beauty",
    "Shoes",
    "Funiture",
    "Watches",
  ];

  List<DropdownMenuItem<String>>? get categoriesDropdownList {
    List<DropdownMenuItem<String>>? menuItems =
        List<DropdownMenuItem<String>>.generate(
      categoriesList.length,
      (index) => DropdownMenuItem(
        value: categoriesList[index],
        child: Text(categoriesList[index]),
      ),
    );
    return menuItems;
  }

//List<DropdownMenuItem<Object>>? items
}
