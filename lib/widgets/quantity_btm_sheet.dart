
import 'package:flutter/material.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';

class QuantityBtmSheet extends StatelessWidget {
  const QuantityBtmSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 6,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
         const SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              // shrinkWrap: true,
              // physics:const  NeverScrollableScrollPhysics(),
              itemCount: 30,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                   //  print(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Center(child: SubtitleTextWidget(label: "${index + 1}", textDecorations: TextDecoration.none,)),
                    ),
                  );
                }
            
            
            ),
          ),
        ],
      ),
    );
  }
}
