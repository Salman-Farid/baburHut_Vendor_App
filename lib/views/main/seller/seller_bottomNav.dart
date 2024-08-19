import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:multivendor_shop/constants/colors.dart';
import '../../../controller/seller_bottom_nav_controller.dart';
import 'dashboard.dart';
import 'home.dart';
import 'profile.dart';
import 'category.dart';

class SellerBottomNav extends GetView<SellerBottomNavController> {
  static const routeName = '/seller-home';

  const SellerBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: litePrimary,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.grey,
        statusBarBrightness: Brightness.dark,
      ),
    );

    final _pages = [
      const HomeScreen(),
      DashboardScreen(),
      CategoryScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: Obx(
            () => ConvexAppBar(
          backgroundColor: primaryColor,
          activeColor: Colors.white,
          initialActiveIndex: controller.currentPageIndex.value,
          style: TabStyle.reactCircle,
          items: const [
            TabItem(
              icon: Icons.house_siding,
            ),
            TabItem(
              icon: Icons.dashboard_outlined,
            ),
            TabItem(
              icon: Icons.category_outlined,
            ),
            // TabItem(
            //   icon: Icons.storefront,
            // ),
            TabItem(
              icon: Icons.person_outline,
            )
          ],
              onTap: (index) {
                if (index < _pages.length) {
                  controller.selectPage(index);
                }
              },
        ),
      ),
      backgroundColor: Colors.grey.shade200,
      body: Obx(() => _pages[controller.currentPageIndex.value]),
    );
  }
}
