class Utils {
  static double calculateRecipeAverageScore(List<dynamic>? data) {
    if (data == null || data.isEmpty) {
      return 5;
    }
    if (data.length >= 2) {
      double finalRate = 0;
      for (var i = 0; i < data.length; i++) {
        finalRate += data[i].toDouble();
      }
      return double.parse(
          (finalRate / data.length).toStringAsFixed(1));
    } else if (data.length == 1) {
      return data.first.toDouble();
    }
    return 0;
  }
}
