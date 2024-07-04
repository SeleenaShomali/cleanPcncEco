// presentation/controllers/auth_controller.dart

import 'package:get/get.dart';
import 'package:pcnc_ecommerce/Domain/usecases/logout_usecase.dart';


class AuthController extends GetxController {
  final LogoutUseCase logoutUseCase;

  AuthController({required this.logoutUseCase});

  Future<void> logout() async {
    try {
      await logoutUseCase.execute();
      Get.offAllNamed('/login'); // Navigate to login screen
    } catch (e) {
      Get.snackbar('Error', 'Logout failed: ${e.toString()}');
    }
  }
}
