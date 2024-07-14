
import 'package:pcnc_ecommerce/features/signup_feature/domain/entity/signup_useer.dart';
import 'package:pcnc_ecommerce/features/signup_feature/domain/repository/sign_up_repo.dart';

class SignupUseCase {
  final SignupRepository repository;

  SignupUseCase({required this.repository});

  Future<SignupUser> call(String name, String email, String password) {
    return repository.signup(name, email, password);
  }
}
