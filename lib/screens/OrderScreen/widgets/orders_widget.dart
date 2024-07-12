import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';
import '../../../consts/assets.dart';
import '../../../widgets/title_text.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({super.key});

  @override
  State<OrdersWidget> createState() => _OrdersWidgetFreeState();
}

class _OrdersWidgetFreeState extends State<OrdersWidget> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FancyShimmerImage(
              height: size.width * 0.25,
              width: size.width * 0.25,
              imageUrl: AssetsPaths.cloud,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        child: TitleTextWidget(
                          label: 'productTitle',
                          maxLines: 2,
                          fontSize: 15,
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.red,
                            size: 22,
                          )),
                    ],
                  ),
                  const Row(
                    children: [
                      TitleTextWidget(
                        label: 'Price:  ',
                        fontSize: 15,
                      ),
                      Flexible(
                        child: SubtitleTextWidget(
                          label: "11.99 \$",
                          fontSize: 15,
                          color: Colors.blue,
                          textDecorations: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SubtitleTextWidget(
                    label: "Qty: 10",
                    fontSize: 15,
                    textDecorations: TextDecoration.none,
                  ),
                  // const Row(
                  //   children: [
                  //     Flexible(
                  //       child: TitlesTextWidget(
                  //         label: 'Qty:  ',
                  //         fontSize: 15,
                  //       ),
                  //     ),
                  //     Flexible(
                  //       child: SubtitleTextWidget(
                  //         label: "10",
                  //         fontSize: 15,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
