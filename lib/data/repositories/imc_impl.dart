import 'imc.dart';

class ImcRepositoryImpl implements ImcRepository {
  @override
  Future<double> calculateImc({
    required double height,
    required double weight,
  }) async {
    try {
      if (height <= 0) {
        throw Exception('Height must be greater than 0!');
      }
      await Future.delayed(const Duration(seconds: 1));
      return weight / (height * height);
    } catch (e) {
      throw Exception('Failed to calculate IMC');
    }
  }
}
