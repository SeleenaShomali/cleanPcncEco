import 'package:get/get.dart';
import 'package:pcnc_ecommerce/features/login_feature/domain/entities/user.dart';
import 'package:pcnc_ecommerce/features/login_feature/domain/usecase/login_useCase.dart';
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

  Future<void> login(String email, String password) async {
    final result = await loginUseCase.login(email, password);
    result.fold(
      (failure) => {Get.snackbar('Error', failure.message)},
      (user) => {
        this.user.value = user,
        Get.snackbar("Success", 'Login Successful'),
        _saveUserState(user),
        Get.offAllNamed('/home')
      }
    );
  }

  Future<void> initializeLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user')) {
      var userData = prefs.getString('user');
      if (userData != null) {
        var jsonUserData = json.decode(userData);
        user.value = User.fromJson(jsonUserData);
        isLoggedIn.value = true;
      }
    }
  }

  // Method to toggle password visibility
  void toggleObscure() {
    isObscure.value = !isObscure.value;
  }

  Future<void> _saveUserState(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userData = json.encode(user.toJson());
    await prefs.setString('user', userData);
  }

  @override
  void onInit() {
    super.onInit();
    initializeLoginState();
  }
}
