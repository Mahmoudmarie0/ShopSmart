import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_smart/controller/home_controller.dart';
import 'package:shop_smart/screens/HomeScreen/Widgets/ctg_rounded_widget.dart';
import 'package:shop_smart/widgets/title_text.dart';
import '../../consts/assets.dart';
import '../../widgets/app_name_text.dart';
import 'Widgets/latest_arrival_widget.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Scaffold(
          appBar: AppBar(
            title: const AppNameTextWidgets(
              fontSize: 20,
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(AssetsPaths.shoppingCart),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.24,

                    child: ClipRRect(
                      child: Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return Image.asset(
                            controller.bannersImage[index],
                            fit: BoxFit.fill,
                          );
                        },
                        autoplay: true,
                        itemCount: controller.bannersImage.length,
                        pagination:const SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                            color: Colors.white,
                            activeColor: Colors.red,
                          ),
                        ),
                       // control: SwiperControl(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18,),
                  const TitleTextWidget(label: "Latest Arrival",fontSize: 22, ),
                  const SizedBox(height: 18,),
                  SizedBox(
                    height:size.height * 0.2,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                        itemBuilder: (context, index) {

                          return const LatestArrivalProductWidget();
                        }



                    ),



                  ),
                  const SizedBox(height: 18,),
                  const TitleTextWidget(label: "Categories",fontSize: 22, ),
                  const SizedBox(height: 18,),
                  GridView.count(
                    shrinkWrap: true,
                      physics:const  NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                    children: List.generate(controller.categories.length, (index) {
                      return CategoryRoundedWidget(image: controller.categories[index].image, name: controller.categories[index].name);
                    })




                  )

                ],
              ),
            ),
          )),
    );
  }
}
