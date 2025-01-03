import 'package:flutter_boilerplate/domain/models/user.dart';

abstract class AuthRepository {
  Future<void> login({
    required String email,
    required String password,
  });
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  });
  Future<void> logout();
  Future<bool> isLogged();
  Future<UserModel> getUser();
}
