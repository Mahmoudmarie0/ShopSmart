import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_smart/consts/assets.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';
import 'package:shop_smart/widgets/title_text.dart';

import '../../../controller/cart_controller.dart';
import '../../../controller/search_controller.dart';
import '../../../widgets/heart_btn.dart';
import '../../ProductDetails/product_details.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key, this.image, this.title, this.price, this.id});
  final String? image, title, price, id;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  SEarchController searchController = Get.put(SEarchController());
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: () async {
          searchController.findByProdId(widget.id!);
          await Get.to(() => const ProductDetails(), arguments: widget.id!);
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: FancyShimmerImage(
                imageUrl: widget.image ?? AssetsPaths.productImageUrl,
                width: double.infinity,
                height: size.height * 0.2,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                    flex: 5,
                    child: TitleTextWidget(
                      label: widget.title ?? "Title" * 10,
                      maxLines: 2,
                      fontSize: 18,
                    )),
                const Flexible(flex: 2, child: HeartButtonWidget()),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      flex: 3,
                      child: SubtitleTextWidget(
                        label: "${widget.price}\$",
                        textDecorations: TextDecoration.none,
                      )),
                  Flexible(
                      child: GetBuilder<CartController>(builder: (controller) {
                    return Material(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.lightBlue,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          controller.addToCart(productId: widget.id!);
                          controller.update();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            controller.isAddedToCart(widget.id!)
                                ? Icons.check
                                : Icons.add_shopping_cart_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    );
                  })),
                  // const SizedBox(width: 1,),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
