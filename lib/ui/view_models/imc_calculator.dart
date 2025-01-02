import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/utils/command.dart';
import 'package:flutter_boilerplate/data/repositories/imc.dart';

class ImcCalculatorViewModel extends ChangeNotifier {
  final ImcRepository _imcRepository;
  final calculateImcCommand = Command<double>();

  ImcCalculatorViewModel(this._imcRepository);

  double _height = 0;
  double _weight = 0;

  double get height => _height;
  double get weight => _weight;

  void setHeight(dynamic value) {
    _height = value.runtimeType == String ? double.tryParse(value) ?? 0 : value;
    notifyListeners();
  }

  void setWeight(dynamic value) {
    _weight = value.runtimeType == String ? double.tryParse(value) ?? 0 : value;
    notifyListeners();
  }

  Future<void> calculateImc() async {
    calculateImcCommand.reset();
    await calculateImcCommand(() async {
      return await _imcRepository.calculateImc(
        height: _height,
        weight: _weight,
      );
    });
  }
}
