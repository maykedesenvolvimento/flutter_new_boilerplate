import 'package:flutter_boilerplate/data/repositories/user_in_memory.dart';
import 'package:flutter_boilerplate/domain/models/user.dart';
import 'package:flutter_boilerplate/domain/repositories/auth.dart';

class AuthRepositoryInMemory implements AuthRepository {
  UserModel? _currentUser;
  final Map<String, String> _passwords = {};

  final _userRepository = UserRepositoryInMemory();

  @override
  Future<UserModel> getCurrentUser() {
    if (_currentUser != null) {
      return Future.value(_currentUser!);
    }
    throw Exception('User not authenticated');
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _userRepository.findOneUser({'email': email});
      if (_passwords[user!.id] == password) {
        _currentUser = user;
        return Future.value(_currentUser!);
      }
      throw Exception('Invalid credentials');
    } catch (e) {
      throw Exception('Invalid credentials');
    }
  }

  @override
  Future<void> logout() {
    _currentUser = null;
    return Future.value();
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      if (password != confirmPassword) {
        throw Exception('Passwords do not match');
      }
      final existingUser = await _userRepository.findOneUser({'email': email});
      if (existingUser != null) {
        throw Exception('Email already registered');
      }
      final user = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
      );
      await _userRepository.createUser(user);
      _passwords[user.id] = password;
      return Future.value(user);
    } catch (e) {
      throw Exception('Failed to register');
    }
  }
}
