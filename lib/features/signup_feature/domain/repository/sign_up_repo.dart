
import 'package:pcnc_ecommerce/features/signup_feature/domain/entity/signup_useer.dart';

abstract class SignupRepository {
  Future<SignupUser> signup(String name, String email, String password);
}
