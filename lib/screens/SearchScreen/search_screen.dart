import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_smart/screens/SearchScreen/Widgets/products_widget.dart';
import 'package:shop_smart/widgets/title_text.dart';
import '../../consts/assets.dart';
import '../../controller/search_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: GetBuilder<SEarchController>(
        init: SEarchController(),
        builder: (controller) => Scaffold(
            appBar: AppBar(
              title: const TitleTextWidget(label: "Search "),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsPaths.shoppingCart),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            controller.clearText();
                            FocusScope.of(context).unfocus();
                          },
                          child: const Icon(
                            Icons.clear,
                            color: Colors.red,
                          )),
                    ),
                    onChanged: (value) {},
                    onSubmitted: (value) {
                      print(value);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: DynamicHeightGridView(
                      itemCount: controller.localProds.length,
                      crossAxisCount: 2,
                      builder: (context, index) {
                        return ProductWidget(
                          image: controller.localProds[index].productImage,
                          title: controller.localProds[index].productTitle,
                          price: controller.localProds[index].productPrice,
                          id: controller.localProds[index].productId,
                        );
                        // return controller.localProds[index];
                      },
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
