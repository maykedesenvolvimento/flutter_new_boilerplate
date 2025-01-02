abstract class ImcRepository {
  Future<double> calculateImc({
    required double height,
    required double weight,
  });
}
