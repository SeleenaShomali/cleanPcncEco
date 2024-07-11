import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcnc_ecommerce/Data/repository/data_repo.dart';
import 'package:pcnc_ecommerce/Domain/usecases/login_useCase.dart';
import 'package:pcnc_ecommerce/presentation/controller/login_controller.dart';
import 'package:pcnc_ecommerce/presentation/pages/components/all_categories.dart';
import 'package:pcnc_ecommerce/presentation/pages/components/tending_products.dart';

import 'package:pcnc_ecommerce/presentation/pages/view/home.dart';
import 'package:pcnc_ecommerce/presentation/pages/view/login.dart';
import 'package:pcnc_ecommerce/presentation/pages/view/sign_up.dart';
import 'package:pcnc_ecommerce/presentation/pages/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put(sharedPreferences); // Put SharedPreferences into GetX
  
  // Initialize LoginController and dependencies
  final loginRepository = LoginRepositoryImpl();
  final loginUseCase = LoginUseCase(repository: loginRepository);
  Get.put(LoginController(loginUseCase: loginUseCase));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      initialRoute: '/splash', // Set initial route to splash screen
      getPages: [
        GetPage(name: '/splash', page: () => Splash()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/signup', page: () => SignupPage()),
        GetPage(name: '/AllCat', page: () => AllCategories()),
        GetPage(name: '/trend', page: () => TendingProducts()),
        // Add other pages here
      ],
    );
  }
}
