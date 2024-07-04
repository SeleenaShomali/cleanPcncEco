// domain/usecases/logout_use_case.dart

import 'package:pcnc_ecommerce/Domain/repositries/logout_repo.dart';

class LogoutUseCase {
  final LogoutRepository repository;

  LogoutUseCase({required this.repository});

  Future<void> execute() {
    return repository.logout();
  }
}
