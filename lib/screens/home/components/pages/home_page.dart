import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:thunderapp/screens/home/home_screen_controller.dart';

import '../../../../components/buttons/custom_text_button.dart';
import '../../../../components/utils/vertical_spacer_box.dart';
import '../../../../shared/constants/app_enums.dart';
import '../../../../shared/constants/style_constants.dart';
import '../../../../shared/core/assets_index.dart';
import '../home_search_bar.dart';
import '../recipe_card.dart';
import '../horizontal_recipe_holder.dart';

class HomePageOne extends StatefulWidget {
  const HomePageOne({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final HomeScreenController controller;
  @override
  State<HomePageOne> createState() => _HomePageOneState();
}

class _HomePageOneState extends State<HomePageOne> {
  @override
  void initState() {
    super.initState();
    // widget.controller.initController();
    // widget.controller.getTodaysRecipe();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return widget.controller.todayRecipes != null
        ? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const VerticalSpacerBox(size: SpacerSize.huge),
                Text(
                  'Bem-vindo(a), @Usuário',
                  style: kTitle2.copyWith(color: textTheme.titleMedium!.color),
                ),
                // Text(
                //   'Receitas ovosensacionais',
                //   style: kBody1.copyWith(color: kDetailColor),
                // ),
                // const VerticalSpacerBox(size: SpacerSize.large),
                // Text('Bom dia, vamos fritar uns ovos?', style: kBody3.copyWith(color: textTheme.titleMedium!.color)),
                // LottieBuilder.asset(
                //   Assets.eggPanLottie,
                //   height: 120,
                //   width: size.width,
                // ),
                // const VerticalSpacerBox(size: SpacerSize.huge),
                // HomeSearchBar(
                //   textController: widget.controller.searchTextEditingController,
                //   onChanged: (value) => widget.controller.onChangeSearchBarText(value),
                //   onSearch: (value) => widget.controller.searchWithQuery(),
                //   onCloseSearchBar: () => widget.controller.closeSearchBar(),
                // ),
                // const VerticalSpacerBox(size: SpacerSize.medium),
                // widget.controller.isSearching
                //     ? Column(
                //         children: <Widget>[
                //           Row(
                //             children: <Widget>[
                //               const Text(
                //                 'Resultados para: ',
                //                 style: kBody2,
                //               ),
                //               Text(
                //                 '${widget.controller.searchTextEditingController.text} (${widget.controller.foundRecipes.length})',
                //                 style: kBody2.copyWith(color: kDetailColor),
                //               )
                //             ],
                //           ),
                //           const VerticalSpacerBox(size: SpacerSize.medium),
                //           widget.controller.foundRecipes.isNotEmpty
                //               ? SizedBox(
                //                   child: ListView.builder(
                //                       padding: EdgeInsets.zero,
                //                       shrinkWrap: true,
                //                       itemCount: widget.controller.foundRecipes.length,
                //                       physics: const NeverScrollableScrollPhysics(),
                //                       itemBuilder: (context, index) {
                //                         return RecipeCard(recipe: widget.controller.foundRecipes[index], controller: widget.controller, isScrollHorizontal: true);
                //                       }),
                //                 )
                //               : const Center(child: Text('Nenhum resultado'))
                //         ],
                //       )
                //     : Column(
                //         children: <Widget>[
                //           const VerticalSpacerBox(size: SpacerSize.huge),
                //           const HorizontalRecipeListHolder(),
                //           const VerticalSpacerBox(size: SpacerSize.medium),
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: <Widget>[
                //               const Text(
                //                 'Todas as receitas',
                //                 style: kCaption1,
                //               ),
                //             ],
                //           ),
                //           const VerticalSpacerBox(size: SpacerSize.medium),
                //           ListView.separated(
                //               padding: EdgeInsets.zero,
                //               shrinkWrap: true,
                //               separatorBuilder: (_, index) => const VerticalSpacerBox(size: SpacerSize.tiny),
                //               physics: const NeverScrollableScrollPhysics(),
                //               scrollDirection: Axis.vertical,
                //               itemCount: widget.controller.todayRecipes!.length,
                //               itemBuilder: (context, index) {
                //                 return RecipeCard(
                //                   isScrollHorizontal: true,
                //                   recipe: widget.controller.todayRecipes![index],
                //                   controller: widget.controller,
                //                 );
                //               }),
                //         ],
                //       )
              ],
            ),
          )
        : SizedBox(
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
              ],
            ),
          );
  }
}
