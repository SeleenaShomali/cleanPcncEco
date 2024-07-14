// data/repositories/logout_repository_impl.dart

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pcnc_ecommerce/features/logout_feature/domain/repository/logout_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LogoutRepositoryImpl implements LogoutRepository {
  final FlutterSecureStorage storage;
  final SharedPreferences sharedPreferences;

  LogoutRepositoryImpl({required this.storage, required this.sharedPreferences});

  @override
  Future<void> logout() async {
    await storage.deleteAll();
    await sharedPreferences.clear();
  }
}
