import 'package:flutter/material.dart';
import 'package:thunderapp/screens/home/home_screen_controller.dart';

import '../../../components/utils/vertical_spacer_box.dart';
import '../../../shared/constants/app_enums.dart';
import '../../../shared/constants/app_number_constants.dart';
import '../../../shared/constants/style_constants.dart';
import '../../../shared/core/models/recipe_model.dart';
import '../../../shared/core/navigator.dart';
import '../../screens_index.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    Key? key,
    required this.recipe,
    required this.controller,
    required this.isScrollHorizontal,
  }) : super(key: key);
  final bool isScrollHorizontal;
  final RecipeModel recipe;
  final HomeScreenController controller;
  @override
  Widget build(BuildContext context) {
    bool isFav = false;
    checkIfIsFav() {
      isFav = controller.checkIfRecipeIsFavorite(recipe);
    }

    checkIfIsFav();
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => navigatorKey.currentState!.pushNamed(Screens.recipeView, arguments: {'recipe': recipe}),
      child: Card(
        child: isScrollHorizontal
            ? HorizontalBuilder(isFav: isFav, controller: controller, recipe: recipe, size: size)
            : VerticalBuilder(
                recipe: recipe,
                isFav: isFav,
                controller: controller,
              ),
      ),
    );
  }
}

class VerticalBuilder extends StatelessWidget {
  const VerticalBuilder({super.key, required this.recipe, required this.controller, required this.isFav});
  final RecipeModel recipe;
  final HomeScreenController controller;
  final bool isFav;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Align(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () => isFav ? controller.unfavorite(isFromOutside: true, recipe: recipe) : controller.favoriteRecipe(recipe),
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border_outlined,
                  color: kPrimaryColor,
                ))),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(60)),
              child: Image.network(
                'https://www.acouplecooks.com/wp-content/uploads/2020/12/How-to-Fry-an-Egg-075-735x919.jpg',
                width: 68,
                fit: BoxFit.cover,
                height: 68,
              ),
            ),
            const VerticalSpacerBox(size: SpacerSize.medium),
            SizedBox(
              width: size.width * 0.3,
              child: Text(
                recipe.title,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: kCaption2,
              ),
            ),
            const VerticalSpacerBox(size: SpacerSize.small),
            Text(
              recipe.rating.toString(),
              style: kCaption2.copyWith(color: kDetailColor, fontFamily: kSecondaryFontFamily),
            ),
          ],
        ),
      ],
    );
  }
}

class HorizontalBuilder extends StatelessWidget {
  const HorizontalBuilder({
    Key? key,
    required this.isFav,
    required this.controller,
    required this.recipe,
    required this.size,
  }) : super(key: key);

  final bool isFav;
  final HomeScreenController controller;
  final RecipeModel recipe;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () => isFav ? controller.unfavorite(isFromOutside: true, recipe: recipe) : controller.favoriteRecipe(recipe),
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border_outlined,
                  color: kPrimaryColor,
                ))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kMediumSize, vertical: kSmallSize),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(60)),
                child: Image.network(
                  'https://www.acouplecooks.com/wp-content/uploads/2020/12/How-to-Fry-an-Egg-075-735x919.jpg',
                  width: 68,
                  fit: BoxFit.cover,
                  height: 68,
                ),
              ),
              const VerticalSpacerBox(size: SpacerSize.small),
              SizedBox(
                width: size.width * 0.3,
                child: Text(
                  recipe.title,
                  textAlign: TextAlign.left,
                  style: kCaption2,
                ),
              ),
              Text(
                recipe.rating.toString(),
                style: kCaption2.copyWith(color: kDetailColor, fontFamily: kSecondaryFontFamily),
              ),
              const VerticalSpacerBox(size: SpacerSize.small)
            ],
          ),
        ),
      ],
    );
  }
}
