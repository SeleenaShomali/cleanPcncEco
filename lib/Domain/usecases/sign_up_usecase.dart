
import 'package:pcnc_ecommerce/Domain/entities/signup_useer.dart';
import 'package:pcnc_ecommerce/Domain/repositries/sign_up_repo.dart';

class SignupUseCase {
  final SignupRepository repository;

  SignupUseCase({required this.repository});

  Future<SignupUser> call(String name, String email, String password) {
    return repository.signup(name, email, password);
  }
}
