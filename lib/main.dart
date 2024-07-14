import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcnc_ecommerce/features/category_feature/presentation/components/All_categories.dart';
import 'package:pcnc_ecommerce/features/dashboard/presentation/view/home.dart';
import 'package:pcnc_ecommerce/features/login_feature/data/repo/data_repo.dart';
import 'package:pcnc_ecommerce/features/login_feature/domain/usecase/login_useCase.dart';
import 'package:pcnc_ecommerce/features/login_feature/presentation/controller/login_controller.dart';
import 'package:pcnc_ecommerce/features/login_feature/presentation/view/login.dart';
import 'package:pcnc_ecommerce/features/products_feature/presentation/components/tending_products.dart';
import 'package:pcnc_ecommerce/features/signup_feature/data/repo/sign_up_datarepoImp.dart';
import 'package:pcnc_ecommerce/features/signup_feature/data/sources/Sign_remoteDataS.dart';
import 'package:pcnc_ecommerce/features/signup_feature/domain/usecase/sign_up_usecase.dart';
import 'package:pcnc_ecommerce/features/signup_feature/presentation/controller/sign_up_controller.dart';
import 'package:pcnc_ecommerce/features/signup_feature/presentation/view/sign_up.dart';
import 'package:pcnc_ecommerce/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put(sharedPreferences); // Put SharedPreferences into GetX

  // Initialize LoginController and dependencies
  final loginRepository = LoginRepositoryImpl();
  final remoteDataSource = SRemoteDataSource();
  final SignupRepository =
      SignupRepositoryImpl(remoteDataSource: remoteDataSource);
  final loginUseCase = LoginUseCase(repository: loginRepository);
  final signupUseCase = SignupUseCase(repository: SignupRepository);
  Get.put(LoginController(loginUseCase: loginUseCase));
  Get.put(SignupController(signupUseCase: signupUseCase));
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
