import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:shop_smart/consts/assets.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({super.key, required this.imagePath, required this.text, required this.function});
  final String imagePath,text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        function();
      },
      leading: Image.asset(
       imagePath,
        height: 30,
      ),
      title:  SubtitleTextWidget(label: text, textDecorations: TextDecoration.none,),
      trailing:const Icon(IconlyLight.arrow_right_2) ,



    );
  }
}
