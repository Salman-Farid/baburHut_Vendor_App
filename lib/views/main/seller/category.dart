import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../controller/CategoryController.dart';
import '../../../models/category.dart';
import '../categories/children.dart';
import '../categories/men.dart';
import '../categories/other.dart';
import '../categories/sneakers.dart';
import '../categories/women.dart';

class CategoryScreen extends GetView<CategoryController> {
  static const routeName = '/category';
  CategoryScreen({super.key});

  final _pageController = PageController();

  final List<CategoryItem> categories = [
    CategoryItem(
      title: 'Men',
      imgUrl: 'assets/images/category_imgs/men.png',
      isActive: true,
    ),
    CategoryItem(
      title: 'Women',
      imgUrl: 'assets/images/category_imgs/women.png',
    ),
    CategoryItem(
      title: 'Children',
      imgUrl: 'assets/images/category_imgs/children.png',
    ),
    CategoryItem(
      title: 'Sneakers',
      imgUrl: 'assets/images/category_imgs/sneakers.png',
    ),
    CategoryItem(
      title: 'Others',
      imgUrl: 'assets/images/category_imgs/other.png',
    )
  ];

  final categoriesList = const [
    MenCategories(),
    WomenCategories(),
    ChildrenCategories(),
    SneakersCategories(),
    OtherCategories(),
  ];

  Widget kCategoryContainer(
      CategoryItem category,
      int index,
      ) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          controller.activeIndex.value = index;
          _pageController.jumpToPage(index);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(10),
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: controller.activeIndex.value == index
                ? Colors.white
                : Colors.transparent,
          ),
          child: Column(
            children: [
              Image.asset(
                category.imgUrl,
                color: controller.activeIndex.value == index
                    ? primaryColor
                    : Colors.black,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 5),
              Text(
                category.title,
                style: TextStyle(
                  fontWeight: controller.activeIndex.value == index
                      ? FontWeight.w600
                      : FontWeight.w500,
                  color: controller.activeIndex.value == index
                      ? primaryColor
                      : Colors.black,
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 48.0),
        child: Column(
          children: [
            const Center(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(
                    Icons.category,
                    color: primaryColor,
                  ),
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 28,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: size.width / 1.25,
                  height: size.height * 0.83,
                  child: PageView(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    onPageChanged: (value) {
                      controller.activeIndex.value = value;
                    },
                    children: categoriesList,
                  ),
                ),
                Container(
                  width: size.width / 5,
                  height: size.height * 0.83,
                  decoration: BoxDecoration(
                    color: litePrimary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    itemCount: categories.length,
                    itemBuilder: (context, index) =>
                        kCategoryContainer(categories[index], index),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
