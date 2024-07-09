import 'package:get/get.dart';
import 'package:pcnc_ecommerce/Domain/entities/signup_useer.dart';

import 'package:pcnc_ecommerce/Domain/usecases/sign_up_usecase.dart';

class SignupController extends GetxController {
  var isSignedUp = false.obs;
  var user = SignupUser(name: '', email: '', password: '').obs;

  final SignupUseCase signupUseCase;
  RxBool isObscure = true.obs;
RxBool isObscure1 = true.obs;
  SignupController({required this.signupUseCase});

  Future<void> signup(String name, String email, String password) async {
    try {
      final signedUpUser = await signupUseCase.call(name, email, password);
      user.value = signedUpUser;
      isSignedUp.value = true;
      Get.offAllNamed('/home'); // Navigate to home screen
    } catch (e) {
      Get.snackbar('Error', 'Signup failed: ${e.toString()}');
    }
  }
  
  bool validateEmail(String email) {
    return GetUtils.isEmail(email);
  }

  bool validatePassword(String password) {
    return password.isNotEmpty && password.length >= 6;
  }

  void toggleObscure(){
    isObscure.value = !isObscure.value;
  }
  void toggleObscure2(){
    isObscure1.value = !isObscure1.value;
  }
}
