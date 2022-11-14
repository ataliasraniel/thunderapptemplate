class EggUser {
  EggUser(
      {required this.id,
      required this.ratedRecipes,
      required this.email});
  final String email;
  final String id;
  final List<String> ratedRecipes;
}
