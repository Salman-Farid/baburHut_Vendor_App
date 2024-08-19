import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multivendor_shop/components/loading.dart';
import 'package:multivendor_shop/constants/colors.dart';
import '../../../controller/ProfileController.dart';
import '../../../controller/ProfileController.dart';
import '../../../controller/ProfileController.dart';
import '../../auth/auth.dart';
import 'dashboard_screens/account_balance.dart';
import 'dashboard_screens/manage_products.dart';
import 'edit_profile.dart';
import '../../../components/kListTile.dart';

class ProfileScreen extends GetView<ProfileController> {
  static const routeName = '/profile';
  const ProfileScreen({super.key});


  showLogoutOptions(BuildContext context) {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Image.asset(
              'assets/images/profile.png',
              width: 35,
              color: primaryColor,
            ),
            const Text(
              'Logout Account',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: const Text(
          'Are you sure you want to log out?',
          style: TextStyle(
            color: primaryColor,
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => controller.logout(),
            child: const Text(
              'Yes',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: Loading(
            color: primaryColor,
            kSize: 50,
          ),
        );
      }

      var credential = controller.credential.value!;
      return CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            expandedHeight: 130,
            backgroundColor: primaryColor,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                return FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  title: AnimatedOpacity(
                    opacity: constraints.biggest.height <= 120 ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: primaryColor,
                          backgroundImage: NetworkImage(
                            credential['image'],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          credential['fullname'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor, Colors.black26],
                        stops: [0.1, 1],
                        end: Alignment.topRight,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: primaryColor,
                          backgroundImage: NetworkImage(
                            credential['image'],
                          ),
                        ),
                        Text(
                          credential['fullname'],
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: size.width / 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              backgroundColor: bWhite,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                ),
                              ),
                            ),
                            onPressed: () => {},
                            child: const Text(
                              'Order',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () => Get.toNamed(
                                AccountBalanceScreen.routeName),
                            child: const Text(
                              'Account',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              backgroundColor: bWhite,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                              ),
                            ),
                            onPressed: () => Get.toNamed(
                                ManageProductsScreen.routeName),
                            child: const Text(
                              'Products',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: size.height / 2.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        KListTile(
                          title: 'Email Address',
                          subtitle: credential['email'],
                          icon: Icons.email,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(thickness: 1),
                        ),
                        KListTile(
                          title: 'Phone Number',
                          subtitle: credential['phone'] == ""
                              ? 'Not set yet'
                              : credential['phone'],
                          icon: Icons.phone,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(thickness: 1),
                        ),
                        KListTile(
                          title: 'Delivery Address',
                          subtitle: credential['address'] == ""
                              ? 'Not set yet'
                              : credential['address'],
                          icon: Icons.location_pin,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: size.height / 3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        KListTile(
                          title: 'App Settings',
                          icon: Icons.settings,
                          onTapHandler: controller.settings, // Corrected method call
                          showSubtitle: false,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(thickness: 1),
                        ),
                        KListTile(
                          title: 'Order Tracking',
                          icon: Icons.track_changes_outlined,
                          onTapHandler: controller.orderTracking, // Corrected method call
                          showSubtitle: false,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(thickness: 1),
                        ),
                        KListTile(
                          title: 'Privacy Policy',
                          icon: Icons.privacy_tip,
                          onTapHandler: controller.privacyPolicy, // Corrected method call
                          showSubtitle: false,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(thickness: 1),
                        ),
                        KListTile(
                          title: 'Help Center',
                          icon: Icons.help,
                          onTapHandler: controller.helpCenter, // Corrected method call
                          showSubtitle: false,
                        ),

                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(thickness: 1),
                        ),
                        KListTile(
                          title: 'Logout',
                          icon: Icons.logout,
                          onTapHandler: () => showLogoutOptions(context),
                          showSubtitle: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
