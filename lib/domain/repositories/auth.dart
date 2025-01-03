import 'package:flutter_boilerplate/domain/models/user.dart';

abstract class AuthRepository {
  Future<UserModel> login({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUser();
  Future<void> logout();
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  });
}
