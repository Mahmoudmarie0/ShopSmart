import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_smart/controller/home_controller.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';
import '../../../consts/assets.dart';
import '../../../widgets/heart_btn.dart';
import '../../ProductDetails/product_details.dart';

class LatestArrivalProductWidget extends StatefulWidget {
  const LatestArrivalProductWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.price,
      required this.id});
  final String? image, title, price, id;

  @override
  State<LatestArrivalProductWidget> createState() =>
      _LatestArrivalProductWidgetState();
}

class _LatestArrivalProductWidgetState
    extends State<LatestArrivalProductWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                controller.mainController.findByProdId(widget.id!);
                await Get.to(() => const ProductDetails(),
                    arguments: widget.id!);
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
                          imageUrl: widget.image ?? AssetsPaths.productImageUrl,
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
                            widget.title ?? "Title" * 10,
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
                          FittedBox(
                              child: SubtitleTextWidget(
                            label: "${widget.price}\$",
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
        });
  }
}
