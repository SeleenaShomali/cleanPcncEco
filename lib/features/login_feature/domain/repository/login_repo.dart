
import 'package:either_dart/either.dart';
import 'package:pcnc_ecommerce/features/login_feature/domain/entities/user.dart';
import 'package:pcnc_ecommerce/features/login_feature/faliuer/Faliuer.dart';


abstract class LoginRepository {
  Future<Either<Failure, User>> login(String email, String password);
}
