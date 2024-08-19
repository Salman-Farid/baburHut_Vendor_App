import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../components/loading.dart';
import '../../constants/colors.dart';
import '../../controller/entry_controller.dart';

class EntryScreen extends GetView<EntryController> {
  static const routeName = '/entry-screen';

  const EntryScreen({Key? key}) : super(key: key);

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
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        color: primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo1.png'),
            const SizedBox(height: 10),
            const Loading(
              color: Colors.white,
              kSize: 40,
            ),
          ],
        ),
      ),
    );
  }
}
