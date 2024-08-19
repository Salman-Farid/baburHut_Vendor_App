import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import '../../constants/colors.dart';
import '../../controller/splash_controller.dart';
import '../auth/auth.dart';

class SplashScreen extends GetView<SplashController> {
  static const routeName = '/splash-screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<SplashController>();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: litePrimary,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.grey,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe.builder(
            itemCount: controller.pages.length,
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                color: controller.pages[index].color,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      controller.pages[index].image,
                      height: 400,
                      fit: BoxFit.contain,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          controller.pages[index].title,
                          style: controller.pages[index].titleStyle,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          controller.pages[index].content,
                          style: controller.pages[index].contentStyle,
                        ),
                        controller.page.value == controller.pages.length - 1
                            ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50.0),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 10),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.all(15),
                                  ),
                                  icon: const Icon(
                                    Icons.chevron_left,
                                    color: Colors.white,
                                  ),
                                  onPressed: () =>
                                      Get.toNamed(Auth.routeName),
                                  label: const Text(
                                    'Get started',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                            : const SizedBox.shrink()
                      ],
                    ),
                  ],
                ),
              );
            },
            slideIconWidget: controller.page.value != controller.pages.length - 1
                ? Icon(
              Icons.arrow_back_ios,
              color: controller.pages[controller.page.value].color,
            )
                : const SizedBox.shrink(),
            onPageChangeCallback: controller.pageChangeCallback,
            waveType: WaveType.liquidReveal,
            liquidController: controller.liquidController,
            enableSideReveal: true,
            ignoreUserGestureWhileAnimating: true,
          ),
          controller.page.value != controller.pages.length - 1
              ? Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                const Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                      controller.pages.length, _buildDot),
                ),
              ],
            ),
          )
              : const SizedBox.shrink(),
          controller.page.value != controller.pages.length - 1
              ? Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextButton(
                onPressed: () {
                  controller.liquidController.animateToPage(
                    page: controller.pages.length - 1,
                    duration: 700,
                  );
                },
                child: Text(
                  "Skip to End",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: controller.pages[controller.page.value].btnColor,
                  ),
                ),
              ),
            ),
          )
              : const SizedBox.shrink(),
          controller.page.value != controller.pages.length - 1
              ? Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextButton(
                onPressed: () {
                  controller.liquidController.jumpToPage(
                    page: controller.liquidController.currentPage + 1 >
                        controller.pages.length - 1
                        ? 0
                        : controller.liquidController.currentPage + 1,
                  );
                },
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: controller.pages[controller.page.value].btnColor,
                  ),
                ),
              ),
            ),
          )
              : const SizedBox.shrink()
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    final controller = Get.find<SplashController>();
    double select = Curves.easeOut.transform(
      max(0.0, 1.0 - (controller.page.value - index).abs()),
    );
    double zoom = 1.0 + (2.0 - 1.0) * select;
    return SizedBox(
      width: 25.0,
      child: Center(
        child: Material(
          color: controller.pages[controller.page.value].btnColor,
          type: MaterialType.circle,
          child: SizedBox(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }
}
