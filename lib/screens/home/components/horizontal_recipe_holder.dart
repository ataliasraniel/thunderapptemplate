import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thunderapp/screens/home/components/recipe_card.dart';
import 'package:thunderapp/screens/home/home_screen_controller.dart';

import '../../../components/utils/horizontal_spacer_box.dart';
import '../../../components/utils/vertical_spacer_box.dart';
import '../../../shared/constants/app_enums.dart';
import '../../../shared/constants/style_constants.dart';

class HorizontalRecipeListHolder extends StatelessWidget {
  const HorizontalRecipeListHolder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Receitinhas em alta',
          style: kCaption1,
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        SizedBox(
          height: size.height * 0.2,
          child: ListView.separated(
              separatorBuilder: (_, index) =>
                  const HorizontalSpacerBox(size: SpacerSize.tiny),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: context
                  .read<HomeScreenController>()
                  .topRecipes!
                  .length,
              itemBuilder: (context, index) {
                return RecipeCard(
                  isScrollHorizontal: false,
                  controller: context.read<HomeScreenController>(),
                  recipe: context
                      .read<HomeScreenController>()
                      .topRecipes![index],
                );
              }),
        ),
      ],
    );
  }
}
