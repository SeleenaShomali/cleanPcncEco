
import 'package:either_dart/either.dart';
import 'package:pcnc_ecommerce/features/login_feature/domain/entities/user.dart';
import 'package:pcnc_ecommerce/features/login_feature/faliuer/Faliuer.dart';
import 'package:pcnc_ecommerce/features/login_feature/domain/repository/login_repo.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure, User>> login(String email, String password) {
    return repository.login(email, password);
  }
}
