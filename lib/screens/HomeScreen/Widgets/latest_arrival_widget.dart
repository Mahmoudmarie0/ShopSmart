import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';
import '../../../consts/assets.dart';
import '../../../widgets/heart_btn.dart';
import '../../ProductDetails/product_details.dart';

class LatestArrivalProductWidget extends StatelessWidget {
  const LatestArrivalProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          await Get.to(() => const ProductDetails());
        },
        child: SizedBox(
          width: size.width * 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FancyShimmerImage(
                    imageUrl: AssetsPaths.productImageUrl,
                    width: size.width * 0.28,
                    height: size.height * 0.28,
                  ),
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title" * 10,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          // IconButton(onPressed: (){}, icon:const Icon(IconlyLight.heart)),
                          const HeartButtonWidget(),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.add_shopping_cart_rounded,
                                size: 18,
                              )),
                        ],
                      ),
                    ),
                    const FittedBox(
                        child: SubtitleTextWidget(
                      label: "166.5\$",
                      textDecorations: TextDecoration.none,
                      color: Colors.blue,
                    )),
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
