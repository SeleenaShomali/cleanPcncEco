
import 'package:either_dart/either.dart';
import 'package:pcnc_ecommerce/Domain/entities/user.dart';
import 'package:pcnc_ecommerce/Domain/faliuer/Faliuer.dart';
import 'package:pcnc_ecommerce/Domain/repositries/login_repo.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure, User>> login(String email, String password) {
    return repository.login(email, password);
  }
}
