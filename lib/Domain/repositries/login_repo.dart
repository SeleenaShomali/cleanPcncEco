
import 'package:either_dart/either.dart';
import 'package:pcnc_ecommerce/Domain/entities/user.dart';
import 'package:pcnc_ecommerce/Domain/faliuer/Faliuer.dart';


abstract class LoginRepository {
  Future<Either<Failure, User>> login(String email, String password);
}
