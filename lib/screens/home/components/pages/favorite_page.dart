import 'package:flutter/material.dart';
import 'package:thunderapp/screens/home/home_screen_controller.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/shared/core/models/recipe_model.dart';
import 'package:thunderapp/shared/core/navigator.dart';

import '../../../../components/utils/vertical_spacer_box.dart';
import '../../../../shared/constants/app_enums.dart';
import '../../../../shared/constants/app_number_constants.dart';
import '../../../../shared/constants/style_constants.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final HomeScreenController controller;

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.getUserFavorites();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const VerticalSpacerBox(size: SpacerSize.huge),
        const Text(
          'Descubra',
          style: kTitle1,
        ),
        Text(
          'Seus favoritos',
          style: kBody1.copyWith(color: kDetailColor),
        ),
        const VerticalSpacerBox(size: SpacerSize.medium),
        widget.controller.userFavorites != null
            ? Expanded(
                child: widget.controller.userFavorites!.isNotEmpty
                    ? ListView(
                        padding: EdgeInsets.zero,
                        children: List.generate(
                            widget.controller.userFavorites != null
                                ? widget.controller.userFavorites!
                                    .length
                                : 0,
                            (index) => FavoriteCard(
                                  size: size,
                                  controller: widget.controller,
                                  index: index,
                                  recipe: widget.controller
                                      .userFavorites![index],
                                )),
                      )
                    : const Center(
                        child: Text(
                            'Nenhum favorito por enquanto. Adicione seu primeiro')),
              )
            : SizedBox(
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text('Um minutinho...'),
                    VerticalSpacerBox(size: SpacerSize.medium),
                    Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
      ],
    );
  }
}

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({
    Key? key,
    required this.size,
    required this.controller,
    required this.index,
    required this.recipe,
  }) : super(key: key);

  final Size size;
  final HomeScreenController controller;
  final int index;
  final RecipeModel recipe;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () => navigatorKey.currentState!.pushNamed(
          Screens.recipeView,
          arguments: {'recipe': controller.userFavorites![index]}),
      child: Card(
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      controller.unfavorite(index: index);
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: kPrimaryColor,
                    ))),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kMediumSize, vertical: kSmallSize),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(60)),
                    child: Image.network(
                      'https://www.acouplecooks.com/wp-content/uploads/2020/12/How-to-Fry-an-Egg-075-735x919.jpg',
                      width: 62,
                      fit: BoxFit.cover,
                      height: 62,
                    ),
                  ),
                  const VerticalSpacerBox(size: SpacerSize.small),
                  SizedBox(
                    width: size.width * 0.3,
                    child: Text(
                      controller.userFavorites![index].title,
                      textAlign: TextAlign.left,
                      style: kCaption2.copyWith(
                          color: textTheme.bodySmall!.color),
                    ),
                  ),
                  const VerticalSpacerBox(size: SpacerSize.small)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
