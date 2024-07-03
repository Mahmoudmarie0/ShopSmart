import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';
import 'package:shop_smart/widgets/title_text.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FittedBox(
      child: IntrinsicWidth(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  imageUrl:
                      'https://images.unsplash.com/photo-1465572089651-8fde36c892dd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
                  height: size.height * 0.2,
                  width: size.width * 0.4,
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            width: size.width * 0.6,
                            child: TitleTextWidget(
                              label: "Title" * 10,
                              maxLines: 2,
                            )),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  IconlyLight.heart,
                                  color: Colors.red,
                                )),
                          ],
                        ),

                      ],
                    ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       const SubtitleTextWidget(label: "16\$", textDecorations: TextDecoration.none,fontSize: 20,color: Colors.blue,),
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              side:const BorderSide(
                                width: 2,
                                color: Colors.blue,
                              )
                            ),
                           onPressed: (){},
                           icon:const  Icon(IconlyLight.arrow_down_2,color: Colors.blue,) ,
                           label:const Text("Qty:6",style: TextStyle(color: Colors.blue),) ,

                         )

                      ],

                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
