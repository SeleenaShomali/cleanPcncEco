import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcnc_ecommerce/features/login_feature/domain/usecase/login_useCase.dart';
import 'package:pcnc_ecommerce/features/login_feature/data/repo/data_repo.dart';
import 'package:pcnc_ecommerce/features/login_feature/presentation/controller/login_controller.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final LoginController loginController = Get.put(LoginController(
      loginUseCase: LoginUseCase(repository: LoginRepositoryImpl())));

  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  void _navigateToNextPage() async {
    await Future.delayed(const Duration(seconds: 2));
    await loginController.initializeLoginState();
    if (loginController.isLoggedIn.value) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/pcncLogo.png"),
      ),
    );
  }
}
