class Assets {
  ///this class is used to store all the assets of the app
  ///so we can easily access them from anywhere in the app
  ///and we can easily change the assets without changing the code
  ///the assets should be separated by sections
  static const svgsAssetsPath = 'assets/svg/';
  static const pngAssetsPath = 'assets/png/';
  static const String lottieAssetsPath = 'assets/lotties/';
  //**PNGS */
  static const String eggNutritionPng =
      '${pngAssetsPath}egg_timer.png';
  static const String eggTimerPng =
      '${pngAssetsPath}egg_nutrition.png';
  static const String logo = '${pngAssetsPath}Logo.png';
  //**SVGS */
  static const String eggTimer = 'assets/svg/egg_timer.svg';
  static const String eggNutrition = 'assets/svg/egg_nutrition.svg';
  static const String google = '${svgsAssetsPath}google.svg';
  //**LOTTIES */
  static const String eggLottie =
      '${lottieAssetsPath}egg_lottie.json';
  static const String eggCrackingLottie =
      '${lottieAssetsPath}egg_cracking.json';
  static const String eggBoucingLottie =
      '${lottieAssetsPath}egg_boucing.json';
  static const String eggRecipeLottie =
      '${lottieAssetsPath}egg_recipe.json';
  static const String eggCookingLottie =
      '${lottieAssetsPath}cooking_egg.json';
  static const String eggPanLottie =
      '${lottieAssetsPath}egg_pan.json';
  static const String introLottie =
      '${lottieAssetsPath}intro_lottie.json';
  static const String intro = '${lottieAssetsPath}intro.json';
}
