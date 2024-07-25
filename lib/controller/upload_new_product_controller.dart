import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

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
  bool _isLoading = false;
  String? productNetworkImage;

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
    final isValid = formKey.currentState!.validate();
    FocusScope.of(Get.context!).unfocus();
    if (pickedImage == null) {
      ShowDialogWidget.showErrorORWarningDialog(
        context: Get.context!,
        subtitle: "Make sure to pick up an image",
        fct: () {},
      );
      return;
    }
    if (categoryValue == null) {
      ShowDialogWidget.showErrorORWarningDialog(
        context: Get.context!,
        subtitle: "Category is empty",
        fct: () {},
      );

      return;
    }
    if (isValid) {
      formKey.currentState!.save();
      try {
        _isLoading = true;
        update();

        final ref = FirebaseStorage.instance
            .ref()
            .child("productsImages")
            .child('${titleController.text.trim()}.jpg');
        await ref.putFile(File(pickedImage!.path));
        productNetworkImage = await ref.getDownloadURL();

        final productID = const Uuid().v4();
        await FirebaseFirestore.instance
            .collection("products")
            .doc(productID)
            .set({
          'productId': productID,
          'productTitle': titleController.text,
          'productPrice': priceController.text,
          'productImage': productNetworkImage,
          'productCategory': categoryValue,
          'productDescription': descriptionController.text,
          'productQuantity': quantityController.text,
          'createdAt': Timestamp.now(),
        });
        Fluttertoast.showToast(
          msg: "Product has been added",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
        await ShowDialogWidget.showErrorORWarningDialog(
          isError: false,
          context: Get.context!,
          subtitle: "Clear form?",
          fct: () {
            clearText();
          },
        );
      } on FirebaseException catch (error) {
        await ShowDialogWidget.showErrorORWarningDialog(
          context: Get.context!,
          subtitle: "An error has been occured ${error.message}",
          fct: () {},
        );
      } catch (error) {
        await ShowDialogWidget.showErrorORWarningDialog(
          context: Get.context!,
          subtitle: "An error has been occured $error",
          fct: () {},
        );
      } finally {
        _isLoading = false;
        update();
      }
    }
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
