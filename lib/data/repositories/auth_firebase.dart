import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_boilerplate/domain/models/user.dart';
import 'package:flutter_boilerplate/domain/repositories/auth.dart';

class AuthRepositoryFirebase implements AuthRepository {
  UserModel? _currentUser;
  bool get _isLogged => _currentUser != null;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Map Firebase user to UserModel
  UserModel _mapFirebaseUserToUserModel(User user) {
    return UserModel(
      id: user.uid,
      name: user.displayName!,
      email: user.email!,
    );
  }

  @override
  Future<UserModel> getUser() async {
    try {
      if (_isLogged) {
        return Future.value(_currentUser!);
      }
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        _currentUser = _mapFirebaseUserToUserModel(user);
        return Future.value(_currentUser!);
      }
      throw Exception('User not authenticated');
    } catch (e) {
      throw Exception('Failed to get user');
    }
  }

  @override
  Future<bool> isLogged() => Future.value(_isLogged);

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _currentUser = _mapFirebaseUserToUserModel(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Failed to login');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      _currentUser = null;
    } catch (e) {
      throw Exception('Failed to logout');
    }
  }

  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    if (password != confirmPassword) {
      throw Exception('Passwords do not match');
    }
    try {
      return _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Failed to register');
    }
  }
}
