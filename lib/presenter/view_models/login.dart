import 'package:flutter/foundation.dart';
import 'package:flutter_boilerplate/core/utils/command.dart';
import 'package:flutter_boilerplate/domain/models/user.dart';
import 'package:flutter_boilerplate/domain/repositories/auth.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final loginCommand = Command<UserModel>();

  LoginViewModel(this._authRepository);

  String _email = '';
  String _password = '';

  String get email => _email;
  String get password => _password;

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void login() {
    loginCommand(() {
      return _authRepository.login(
        email: _email,
        password: _password,
      );
    });
  }
}
