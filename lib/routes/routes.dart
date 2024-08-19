import 'package:get/get.dart';
import 'package:multivendor_shop/views/auth/auth.dart';
import 'package:multivendor_shop/views/auth/forgot_password.dart';
import 'package:multivendor_shop/views/main/seller/dashboard_screens/account_balance.dart';
import 'package:multivendor_shop/views/main/seller/dashboard_screens/manage_products.dart';
import 'package:multivendor_shop/views/main/seller/dashboard_screens/orders.dart';
import 'package:multivendor_shop/views/main/seller/dashboard_screens/statistics.dart';
import 'package:multivendor_shop/views/main/seller/dashboard_screens/store_setup.dart';
import 'package:multivendor_shop/views/main/seller/seller_bottomNav.dart';
import '../controller/Bindings/SellerBottomNav_binding.dart';
import '../controller/Bindings/category_binding.dart';
import '../controller/Bindings/edit_profile.dart';
import '../controller/Bindings/entry_binding.dart';
import '../controller/Bindings/profile_binding.dart';
import '../controller/Bindings/splash_binding.dart';
import '../controller/seller_bottom_nav_controller.dart';
import '../views/main/seller/category.dart';
import '../views/main/seller/dashboard_screens/edit_product.dart';
import '../views/main/seller/dashboard_screens/upload_product.dart';
import '../views/main/seller/edit_profile.dart';
import '../views/main/seller/home.dart';
import '../views/main/seller/profile.dart';
import '../views/splash/entry.dart';
import '../views/splash/splash.dart';
final List<GetPage> routes = [
  GetPage(
    name: Auth.routeName,
    page: () => const Auth(),
    //binding: AuthBinding(),
  ),

  GetPage(
    name: HomeScreen.routeName,
    page: () => const HomeScreen(),
    //binding: AuthBinding(),
  ),
  GetPage(
    name: ForgotPassword.routeName,
    page: () => const ForgotPassword(),
  ),
  GetPage(
    name: SplashScreen.routeName,
    page: () => const SplashScreen(),
    binding: SplashBindings(),
  ),
  GetPage(
    name: EntryScreen.routeName,
    page: () => const EntryScreen(),
    binding: EntryBinding(),
  ),









  GetPage(
    name: SellerBottomNav.routeName,
    page: () => const SellerBottomNav(),
    bindings: [
      SellerBottomNavBinding(),
      CategoryBindings(),
      ProfileBinding(),
    ],
  ),



  GetPage(
    name: ManageProductsScreen.routeName,
    page: () => const ManageProductsScreen(),
    //binding: ManageProductsBinding(),
  ),
  GetPage(
    name: UploadProduct.routeName,
    page: () => const UploadProduct(),
    // Add binding if necessary
  ),
  GetPage(
    name: StatisticsScreen.routeName,
    page: () => const StatisticsScreen(),
    // Add binding if necessary
  ),
  GetPage(
    name: AccountBalanceScreen.routeName,
    page: () => const AccountBalanceScreen(),
    // Add binding if necessary
  ),
  GetPage(
    name: EditProduct.routeName,
    page: () => const EditProfile(),
    binding: EditProfileBinding(),
    // Add binding if necessary
  ),

  GetPage(
    name:ProfileScreen.routeName,
    page: () => ProfileScreen(),
    binding: ProfileBinding(),
  ),
  GetPage(
    name: CategoryScreen.routeName,
    page: () => CategoryScreen(),
    binding: CategoryBindings(),
  ),
];
























// final List<GetPage> routes = [
//   GetPage(
//     name: Auth.routeName,
//     page: () => const Auth(),
//     //binding: AuthBinding(),
//   ),
//   GetPage(
//     name: ForgotPassword.routeName,
//     page: () => const ForgotPassword(),
//   ),
//   GetPage(
//     name: SplashScreen.routeName,
//     page: () => const SplashScreen(),
//   ),
//   GetPage(
//     name: EntryScreen.routeName,
//     page: () => const EntryScreen(),
//     binding: EntryBinding(),
//   ),
//   GetPage(
//     name: SellerBottomNav.routeName,
//     page: () => const SellerBottomNav(),
//   ),
//   GetPage(
//     name: ManageProductsScreen.routeName,
//     page: () => const ManageProductsScreen(),
//     //binding: ManageProductsBinding(),
//   ),
//   GetPage(
//     name: UploadProduct.routeName,
//     page: () => const UploadProduct(),
//     // Add binding if necessary
//   ),
//   GetPage(
//     name: StatisticsScreen.routeName,
//     page: () => const StatisticsScreen(),
//     // Add binding if necessary
//   ),
//   GetPage(
//     name: AccountBalanceScreen.routeName,
//     page: () => const AccountBalanceScreen(),
//     // Add binding if necessary
//   ),
//   GetPage(
//     name: EditProduct.routeName,
//     page: () => const EditProfile(),
//     binding: EditProfileBinding(),
//     // Add binding if necessary
//   ),
//   GetPage(
//     name: SellerBottomNav.routeName,
//     page: () => const SellerBottomNav(),
//     binding: SellerBottomNavBinding(),
//   ),
//   GetPage(
//     name:ProfileScreen.routeName,
//     page: () => ProfileScreen(),
//     binding: ProfileBinding(),
//   ),
//   GetPage(
//     name: CategoryScreen.routeName,
//     page: () => CategoryScreen(),
//     binding: CategoryBindings(),
//   ),
// ];
