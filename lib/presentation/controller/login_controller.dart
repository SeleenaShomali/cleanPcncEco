import 'package:get/get.dart';
import 'package:pcnc_ecommerce/Domain/entities/user.dart';
import 'package:pcnc_ecommerce/Domain/usecases/login_useCase.dart';


class LoginController extends GetxController {
  var isLoggedIn = false.obs;
  var user = User(accessToken: 'accessToken', refreshToken: 'refreshToken', email: 'email').obs;

  final LoginUseCase loginUseCase;

  LoginController({required this.loginUseCase});

  Future<void> login(String email, String password) async {
    final result = await loginUseCase.login(email, password);
    result.fold(
      (failure) {
        Get.snackbar('Error', failure.message);
      },
      (user) {
        this.user.value = user;
        isLoggedIn.value = true;
        Get.offAllNamed('/home');
      },
    );
  }
}
