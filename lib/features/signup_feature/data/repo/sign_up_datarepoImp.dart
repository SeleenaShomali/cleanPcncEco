import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pcnc_ecommerce/features/signup_feature/data/sources/Sign_remoteDataS.dart';
import 'package:pcnc_ecommerce/features/signup_feature/domain/entity/signup_useer.dart';

import 'package:pcnc_ecommerce/features/signup_feature/domain/repository/sign_up_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupRepositoryImpl implements SignupRepository {
  final SRemoteDataSource remoteDataSource;
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  static const String defaultAvatarUrl = 'https://picsum.photos/800'; // Default avatar URL

  SignupRepositoryImpl({required this.remoteDataSource});

  @override
  Future<SignupUser> signup(String name, String email, String password) async {
    final data = await remoteDataSource.signup(name, email, password, defaultAvatarUrl);

    final user = SignupUser.fromJson(data);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', json.encode(user.toJson()));
    await storage.write(key: 'name', value: name);
    await storage.write(key: 'email', value: email);
    await storage.write(key: 'password', value: password);

    return user;
  }
}
