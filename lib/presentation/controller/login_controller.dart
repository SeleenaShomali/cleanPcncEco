import 'package:get/get.dart';
import 'package:pcnc_ecommerce/Domain/entities/user.dart';
import 'package:pcnc_ecommerce/Domain/usecases/login_useCase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LoginController extends GetxController {
  var isLoggedIn = false.obs;
  var user = User(
    accessToken: '',
    refreshToken: '',
    email: '',
  ).obs;

  final LoginUseCase loginUseCase;

  // Observable for password visibility
  RxBool isObscure = true.obs;

  LoginController({required this.loginUseCase});

  // Future<void> login(String email, String password) async {
  //   if (_validateEmail(email) && _validatePassword(password)) {
  //     final result = await loginUseCase.login(email, password);
  //     result.fold(
  //       (failure) {
  //         Get.snackbar('Error', failure.message);
  //       },
  //       (user) {
  //         this.user.value = user;
  //         isLoggedIn.value = true;
  //         _saveUserState(user);
  //         Get.offAllNamed('/home');
  //       },
  //     );
  //   } else {
  //     Get.snackbar('Error', 'Invalid email or password');
  //   }
  // }
  Future<void> login(String email, String password) async {
    final result = await loginUseCase.login(email, password);
    result.fold(
      (failure) => {Get.snackbar('Error', failure.message)},
      (user) => {
        this.user.value = user,
        Get.snackbar("Success", 'Login Successful'),
        Get.offAllNamed('/home')
      }
    );
  }


  Future<void> initializeLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user')) {
      var userData = json.decode(prefs.getString('user')!);
      user.value = User.fromJson(userData);
      isLoggedIn.value = true;
    }
  }

  // Method to toggle password visibility
  void toggleObscure() {
    isObscure.value = !isObscure.value;
  }

  @override
  void onInit() {
    super.onInit();
    initializeLoginState();
  }
}
