import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconly/iconly.dart';

import '../../consts/assets.dart';
import '../../widgets/app_name_text.dart';
import '../../widgets/heart_btn.dart';
import '../../widgets/subtitle_text.dart';
import '../../widgets/title_text.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        title: const AppNameTextWidgets(
          fontSize: 20,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
        ),


      ),
      body: Column(
        children: [
          FancyShimmerImage(
            imageUrl: AssetsPaths.productImageUrl,
            height:size.height*0.26,
            width: double.infinity,
            boxFit: BoxFit.contain,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        child: Text(
                          "Title"*16,
                           style:const TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                           ),

                        )),
                   const SizedBox(width: 14,),
                    const  SubtitleTextWidget(label: "166.5\$",textDecorations: TextDecoration.none,color: Colors.blue,fontWeight: FontWeight.bold,fontSize:20 ,),
                  ],
                ),
               const SizedBox(height: 15,),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 30),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: [
                       HeartButtonWidget(color: Colors.blue.shade300, ),
                      const SizedBox(
                         width: 10,
                       ),
                       Expanded(child: SizedBox(
                           height:kBottomNavigationBarHeight -10 ,
                           child: ElevatedButton.icon(onPressed: (){}, label: const Text('Add to cart',style: TextStyle(color: Colors.white), ),icon:const Icon(Icons.add_shopping_cart,color: Colors.white,),style: ElevatedButton.styleFrom( backgroundColor: Colors.lightBlue), )))
                     ],
                   ),
                 ),
              const  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleTextWidget(label: "About this item"),
                    SubtitleTextWidget(label: "In Phones", textDecorations: TextDecoration.none)
                  ],
                ),
              const  SizedBox(height: 25,),
                  SubtitleTextWidget(label: "description" *15, textDecorations: TextDecoration.none)


              ],
            ),
          ),





        ],


      ),
    );
  }
}
