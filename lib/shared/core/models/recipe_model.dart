class RecipeModel {
  final String? docId;
  final String title;
  final String description;
  final int timesMade;
  final double rating;
  final List<dynamic> steps;
  final List<dynamic> igredients;
  final int difficulty;
  final bool? isFavorite;
  RecipeModel(
    this.title,
    this.description,
    this.timesMade,
    this.rating,
    this.steps,
    this.igredients,
    this.difficulty, [
    this.isFavorite,
    this.docId,
  ]);

  factory RecipeModel.fromJson({required data}) {
    return RecipeModel(
      data['title'],
      data['description'],
      data['timesMade'],
      data['rating'].toDouble(),
      data['steps'],
      data['igredients'],
      data['difficulty'].runtimeType == String
          ? int.parse(data['difficulty'])
          : data['difficulty'],
      false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'steps': steps,
      'igredients': igredients
    };
  }
}
