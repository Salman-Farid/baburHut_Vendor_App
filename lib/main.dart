import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:multivendor_shop/providers/cart.dart';
import 'package:multivendor_shop/providers/order.dart';
import 'package:multivendor_shop/views/splash/entry.dart';
import 'package:provider/provider.dart';
import 'constants/colors.dart';
import 'controller/entry_controller.dart';
import 'routes/routes.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(EntryController());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartData(),
        ),
      ],
      child: const MultiVendor(),
    ),
  );
}

// class MultiVendor extends StatefulWidget {
//   const MultiVendor({Key? key}) : super(key: key);
//
//   @override
//   State<MultiVendor> createState() => _MultiVendorState();
// }
//
// class _MultiVendorState extends State<MultiVendor> {

class MultiVendor extends StatelessWidget {
  const MultiVendor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'MultiVendor App',
        theme: ThemeData(
          canvasColor: Colors.white, // Sets the background color of the app
          fontFamily: 'Roboto',
          primaryColor: primaryColor,
        ),
        debugShowCheckedModeBanner: false,
        home: const EntryScreen(),
        getPages: routes);
  }
}
