import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/home_carousel.dart';
import '../../../components/search_box.dart';
import '../../../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    Widget kText(String text, int index) {
      return GestureDetector(
        onTap: () => controller.updateTabIndex(index),
        child: Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Obx(() => Text(
            text,
            style: TextStyle(
              color: controller.currentTabIndex.value == index ? Colors.black : Colors.grey,
              fontSize: controller.currentTabIndex.value == index ? 27 : 18,
              fontWeight: controller.currentTabIndex.value == index
                  ? FontWeight.bold
                  : FontWeight.w500,
            ),
          )),
        ),
      );
    }

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                child: const SearchBox(),
              ),
              const SizedBox(height: 10),
              buildCarouselSlider(),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) =>
                      kText(controller.categories[index], index),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1,
                child: Column(
                  children: [
                    Obx(() => controller.categoriesList[controller.currentTabIndex.value]),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Other Contents can come in.....')
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
