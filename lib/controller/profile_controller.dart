import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shop_smart/controller/main_controller.dart';
import 'package:shop_smart/models/user_model.dart';
import 'package:shop_smart/widgets/show_dialog_widget.dart';

class ProfileController extends GetxController {
  UserModel? userModel;
  UserModel? get getUserModel => userModel;
  bool isLoading = false;
  MainController mainController = Get.find();
  User? user = FirebaseAuth.instance.currentUser;

  // Future<void> fetchUser() async {
  //  // final FirebaseAuth auth=;
  //
  //   if(user==null){
  //     isloading=false;
  //     update();
  //    return ;
  //   }
  //   var uid =user!.uid;
  //
  //   try{
  //
  //   final userDoc =await FirebaseFirestore.instance.collection('users').doc(uid).get();
  //   final userDocDict=userDoc.data() ; //we use it to see if contains key like userCart or not
  //   userModel=UserModel(
  //       userId: userDoc.get('userId'),
  //       userName: userDoc.get('userName'),
  //       userImage: userDoc.get('userImage'),
  //       userEmail: userDoc.get('userEmail'),
  //       createdAt: userDoc.get('createdAt'),
  //       userCart:  userDocDict!.containsKey('userCart')?  userDoc.get('userCart'):[],
  //       userWish: userDocDict!.containsKey('userWish')?  userDoc.get('userWish'):[],);
  //
  //   // return userModel;
  //   }
  //  on FirebaseException catch(e){
  //     ShowDialogWidget.showErrorORWarningDialog(
  //       context: Get.context!,
  //       subtitle: e.message.toString(),
  //       fct: () {},
  //     );
  //
  //
  //     throw e.message.toString();
  //
  //   }
  // }
  Future<void> fetchUser() async {
    if (user == null) {
      isLoading = false;
      update();
      return;
    }
    var uid = user!.uid;

    try {
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        final userDocDict = userDoc.data();
        userModel = UserModel(
          userId: userDoc.get('userId'),
          userName: userDoc.get('userName'),
          userImage: userDoc.get('userImage'),
          userEmail: userDoc.get('userEmail'),
          createdAt: userDoc.get('createdAt'),
          userCart: userDocDict!.containsKey('userCart')
              ? userDoc.get('userCart')
              : [],
          userWish: userDocDict.containsKey('userWish')
              ? userDoc.get('userWish')
              : [],
        );
      } else {
        ShowDialogWidget.showErrorORWarningDialog(
          context: Get.context!,
          subtitle: "User document does not exist.",
          fct: () {},
        );
      }
    } on FirebaseException catch (e) {
      ShowDialogWidget.showErrorORWarningDialog(
        context: Get.context!,
        subtitle: e.message.toString(),
        fct: () {},
      );
      throw e.message.toString();
    }
    isLoading = false;
    update();
  }

  @override
  void onInit() {
    user;
    fetchUser();

    update();
    super.onInit();
  }
}
