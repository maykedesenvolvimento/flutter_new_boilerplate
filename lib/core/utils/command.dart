import 'package:flutter/material.dart';

class Command<T> extends ChangeNotifier {
  T? _result;
  bool _isLoading = false;
  Object? _error;

  T? get result => _result;
  bool get isLoading => _isLoading;
  bool get isSuccessful => _result != null;
  bool get isFailure => _error != null;
  Object? get error => _error;

  Future<void> call(Future<T> Function() action) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _result = await action();
    } catch (e) {
      _error = e;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _result = null;
    _error = null;
    _isLoading = false;
    notifyListeners();
  }
}
