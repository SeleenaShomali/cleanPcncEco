// domain/usecases/logout_use_case.dart

import 'package:pcnc_ecommerce/features/logout_feature/domain/repository/logout_repo.dart';

class LogoutUseCase {
  final LogoutRepository repository;

  LogoutUseCase({required this.repository});

  Future<void> execute() {
    return repository.logout();
  }
}
