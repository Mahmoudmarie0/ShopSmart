import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:shop_smart/models/cart_model.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';
import 'package:shop_smart/widgets/title_text.dart';
import '../../../controller/cart_controller.dart';
import '../../../widgets/heart_btn.dart';
import '../../SearchScreen/Widgets/quantity_btm_sheet.dart';

class CartWidget extends StatelessWidget {
  final CartModel cartModel;
  const CartWidget({super.key, required this.cartModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    CartController controller = Get.find();
    final getCurrProduct =
        controller.mainController.findByProdId(cartModel.productId);

    return FittedBox(
      child: IntrinsicWidth(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  imageUrl: getCurrProduct!.productImage,
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
                              label: getCurrProduct.productTitle,
                              maxLines: 2,
                            )),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  controller
                                      .removeOneItem(getCurrProduct.productId);
                                },
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                )),
                            const HeartButtonWidget(),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubtitleTextWidget(
                          label: "${getCurrProduct.productPrice}\$",
                          textDecorations: TextDecoration.none,
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              side: const BorderSide(
                                width: 2,
                                color: Colors.blue,
                              )),
                          onPressed: () async {
                            await showModalBottomSheet(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16))),
                                context: context,
                                builder: (context) {
                                  return QuantityBtmSheet(
                                    productId: getCurrProduct.productId,
                                  );
                                });
                          },
                          icon: const Icon(
                            IconlyLight.arrow_down_2,
                            color: Colors.blue,
                          ),
                          label: Text(
                            "Qty:${getCurrProduct.productQuantity}",
                            style: const TextStyle(color: Colors.blue),
                          ),
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
