import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pcnc_ecommerce/Data/repository/data_repo.dart';
import 'package:pcnc_ecommerce/Domain/usecases/login_useCase.dart';
import 'package:pcnc_ecommerce/presentation/pages/home.dart';
import 'package:pcnc_ecommerce/presentation/pages/login.dart';
import 'package:pcnc_ecommerce/presentation/pages/sign_up.dart';
import 'package:pcnc_ecommerce/presentation/controller/login_controller.dart';
import 'package:pcnc_ecommerce/presentation/pages/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put(sharedPreferences); // Put SharedPreferences into GetX
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
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => Splash()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/signup', page: () => SignupPage()),
        // Add other pages here
      ],
    );
  }
}
