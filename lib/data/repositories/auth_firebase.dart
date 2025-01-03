import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_boilerplate/domain/models/user.dart';
import 'package:flutter_boilerplate/domain/repositories/auth.dart';

class AuthRepositoryFirebase implements AuthRepository {
  UserModel? _currentUser;
  bool get _isLogged => _currentUser != null;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel _mapFirebaseUserToUserModel(User user, DocumentSnapshot doc) {
    return UserModel(
      id: user.uid,
      name: doc.get('name'),
      email: user.email!,
    );
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      _currentUser = _mapFirebaseUserToUserModel(userCredential.user!, userDoc);
      return _currentUser!;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Failed to login');
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      if (_isLogged) {
        return Future.value(_currentUser!);
      }
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        final userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        _currentUser = _mapFirebaseUserToUserModel(user, userDoc);
        return _currentUser!;
      }
      throw Exception('User not authenticated');
    } catch (e) {
      throw Exception('Failed to get user');
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
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (password != confirmPassword) {
      throw Exception('Passwords do not match');
    }
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user!;
      await _firestore.collection('users').doc(user.uid).set({
        'name': name,
        'email': email,
      });
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      return _mapFirebaseUserToUserModel(user, userDoc);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Failed to register');
    }
  }
}
