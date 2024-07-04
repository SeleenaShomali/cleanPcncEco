
import 'package:pcnc_ecommerce/Domain/entities/signup_useer.dart';

abstract class SignupRepository {
  Future<SignupUser> signup(String name, String email, String password);
}
