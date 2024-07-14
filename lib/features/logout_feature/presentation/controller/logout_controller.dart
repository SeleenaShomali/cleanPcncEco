// presentation/controller/auth_controller.dart

import 'package:get/get.dart';
import 'package:pcnc_ecommerce/features/logout_feature/domain/usecase/logout_usecase.dart';

class AuthController extends GetxController {
  final LogoutUseCase logoutUseCase;
  var isLoading = false.obs;

  AuthController({required this.logoutUseCase});

  Future<void> logout() async {
    isLoading.value = true;
    try {
      await Future.delayed(Duration(seconds: 2)); // Simulate loading for 2 seconds
      await logoutUseCase.execute();
      Get.offAllNamed('/login'); // Navigate to login screen
    } catch (e) {
      Get.snackbar('Error', 'Logout failed: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
