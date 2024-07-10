import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_smart/screens/SearchScreen/search_screen.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';

class CategoryRoundedWidget extends StatelessWidget {
  final String image, name;
  const CategoryRoundedWidget(
      {super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    //HomeController controller = Get.put(HomeController());
    return GestureDetector(
      onTap: () async {
        await Get.to(const SearchScreen(), arguments: name);
      },
      child: Column(
        children: [
          Image.asset(
            image,
            height: 50,
            width: 50,
          ),
          const SizedBox(
            height: 15,
          ),
          SubtitleTextWidget(
            label: name,
            textDecorations: TextDecoration.none,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
