import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';

import '../consts/assets.dart';

class ShowDialogWidget {
 static Future<void>showErrorORWarningDialog({required BuildContext context,required String subtitle,required Function fct,bool isError = true })async{
   await showDialog(
       context: context,
       builder: (context) {
         return AlertDialog(
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(12),
           ),
           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
           content: Column(
             mainAxisSize:MainAxisSize.min,
             children: [
               Image.asset(
                 AssetsPaths.warning,
                 height: 60,
                 width: 60,
               ),
               const SizedBox(height:16.0 ,),
                SubtitleTextWidget(label: subtitle, textDecorations: TextDecoration.none,fontWeight: FontWeight.w600,),
               const SizedBox(height:16.0 ,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Visibility(
                     visible: !isError,
                     child: TextButton(
                         onPressed: (){
                           Get.back();
                         },
                         child:const SubtitleTextWidget(label:  "Cancel", textDecorations: TextDecoration.none,color: Colors.green,)
                     ),
                   ),
                   TextButton(
                       onPressed: (){
                         fct();
                         Get.back();
                       },
                       child:const SubtitleTextWidget(label:  "Ok", textDecorations: TextDecoration.none,color: Colors.red,)
                   ),




                 ],


               )

             ],
           ),
         );


       }



   );





  }




}