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
    final catId = ModalRoute.of(context)!.settings.arguments as String? ?? "";
    final productModel = SEarchController().findByCategory(ctgId: catId);

    return productModel.isEmpty
        ? const Scaffold(body: Center(child: Text("Not Found")))
        : GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: GetBuilder<SEarchController>(
              init: SEarchController(),
              builder: (controller) => Scaffold(
                  appBar: AppBar(
                    title:
                        TitleTextWidget(label: catId == "" ? "Search" : catId),
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
                          onChanged: (value) {
                            // controller.searchQuery(
                            //     searchText: controller.searchController.text);
                            controller.update();
                          },
                          onSubmitted: (value) {
                            controller.searchQuery(
                                searchText: controller.searchController.text,
                                passedList: productModel);
                            controller.update();
                            print(value);
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        controller.searchController.text.isNotEmpty &&
                                controller
                                    .searchQuery(
                                        searchText:
                                            controller.searchController.text,
                                        passedList: productModel)
                                    .isEmpty
                            ? const TitleTextWidget(
                                label: "No Result",
                                fontSize: 22,
                              )
                            : Expanded(
                                child: DynamicHeightGridView(
                                  itemCount: controller
                                          .searchController.text.isNotEmpty
                                      ? controller
                                          .searchQuery(
                                              searchText: controller
                                                  .searchController.text,
                                              passedList: productModel)
                                          .length
                                      : catId.isNotEmpty
                                          ? productModel.length
                                          : controller
                                              .mainController.localProds.length,
                                  crossAxisCount: 2,
                                  builder: (context, index) {
                                    return controller
                                            .searchController.text.isNotEmpty
                                        ? ProductWidget(
                                            image: controller
                                                .searchQuery(
                                                    searchText: controller
                                                        .searchController.text,
                                                    passedList:
                                                        productModel)[index]
                                                .productImage,
                                            title: controller
                                                .searchQuery(
                                                    searchText: controller
                                                        .searchController.text,
                                                    passedList:
                                                        productModel)[index]
                                                .productTitle,
                                            price: controller
                                                .searchQuery(
                                                    searchText: controller
                                                        .searchController.text,
                                                    passedList:
                                                        productModel)[index]
                                                .productPrice,
                                            id: controller
                                                .searchQuery(
                                                    searchText: controller
                                                        .searchController.text,
                                                    passedList:
                                                        productModel)[index]
                                                .productId,
                                          )
                                        : catId.isNotEmpty
                                            ? ProductWidget(
                                                image: productModel[index]
                                                    .productImage,
                                                title: productModel[index]
                                                    .productTitle,
                                                price: productModel[index]
                                                    .productPrice,
                                                id: productModel[index]
                                                    .productId,
                                              )
                                            : ProductWidget(
                                                image: controller
                                                    .mainController
                                                    .localProds[index]
                                                    .productImage,
                                                title: controller
                                                    .mainController
                                                    .localProds[index]
                                                    .productTitle,
                                                price: controller
                                                    .mainController
                                                    .localProds[index]
                                                    .productPrice,
                                                id: controller
                                                    .mainController
                                                    .localProds[index]
                                                    .productId,
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
