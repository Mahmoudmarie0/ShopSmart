import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/product_details.dart';
import '../../controller/search_controller.dart';
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
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    SEarchController searchController = Get.put(SEarchController());
    final productModel =
        searchController.mainController.findByProdId(productId);
    return GetBuilder<ProductDetailsController>(
        init: ProductDetailsController(),
        builder: (controller) {
          return Scaffold(
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
                  imageUrl: productModel!.productImage,
                  height: size.height * 0.26,
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
                            productModel.productTitle,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          const SizedBox(
                            width: 14,
                          ),
                          SubtitleTextWidget(
                            label: "${productModel.productPrice}\$",
                            textDecorations: TextDecoration.none,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            HeartButtonWidget(
                              color: Colors.blue.shade300,
                              productId: productId,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: SizedBox(
                                    height: kBottomNavigationBarHeight - 10,
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        controller.mainController
                                            .addToCart(productId: productId);
                                        controller.update();
                                      },
                                      label: Text(
                                        controller.mainController
                                                .isAddedToCart(productId)
                                            ? "In cart"
                                            : 'Add to cart',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      icon: Icon(
                                        controller.mainController
                                                .isAddedToCart(productId)
                                            ? Icons.check
                                            : Icons.add_shopping_cart,
                                        color: Colors.white,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.lightBlue),
                                    )))
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TitleTextWidget(label: "About this item"),
                          SubtitleTextWidget(
                              label: productModel.productCategory,
                              textDecorations: TextDecoration.none)
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SubtitleTextWidget(
                          label: productModel.productDescription,
                          textDecorations: TextDecoration.none)
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
