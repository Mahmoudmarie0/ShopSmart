import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:shop_smart/consts/assets.dart';
import 'package:shop_smart/widgets/title_text.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: (){},
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: FancyShimmerImage(
                  imageUrl:AssetsPaths.productImageUrl,
                width: double.infinity,
                height: size.height * 0.2,
              ),
            ),
          const SizedBox(height: 10,),
            Row(
              children: [
                Flexible(
                    flex: 5,
                    child: TitleTextWidget(label: "Title"*10,maxLines: 2,)),
                Flexible(child: IconButton(onPressed: (){}, icon:const Icon(IconlyLight.heart))),
        
        
              ],
        
        
        
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const Flexible(
                    flex: 3,
                    child: TitleTextWidget(label: "166.5\$")),
                Flexible(
                    child: Material(
                      borderRadius:BorderRadius.circular(16),
                      color: Colors.lightBlue,
                      child: InkWell(
                        borderRadius:BorderRadius.circular(16),
                        onTap: (){},
                        child:  const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.add_shopping_cart_rounded,size: 18,),
                        ),
        
                      ),
                    )),
        
        
              ],
        
        
        
            ),
           const SizedBox(height: 10,),
        
        
        
        
          ],
        
        
        ),
      ),
    );
  }
}
