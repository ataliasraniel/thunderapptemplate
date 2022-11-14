import 'package:flutter/material.dart';
import 'package:thunderapp/shared/components/index.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';

import '../../../../components/buttons/primary_button.dart';
import '../../../../components/utils/vertical_spacer_box.dart';
import '../../../../shared/constants/app_enums.dart';
import '../../../../shared/constants/style_constants.dart';
import '../../../../shared/core/assets_index.dart';
import '../../../screens_index.dart';

class UtilityPage extends StatefulWidget {
  const UtilityPage({
    Key? key,
    this.navigatorKey,
  }) : super(key: key);
  final navigatorKey;
  @override
  State<UtilityPage> createState() => _UtilityPageState();
}

class _UtilityPageState extends State<UtilityPage> {
  Route _onGenerateRoute(RouteSettings settings) {
    TextTheme textTheme = Theme.of(context).textTheme;

    late Widget page;
    page = const SizedBox();
    switch (settings.name) {
      case Screens.home:
        page = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const VerticalSpacerBox(size: SpacerSize.huge),
            const Text(
              'Descubra',
              style: kTitle1,
            ),
            Text(
              'Utilitários',
              style: kBody1.copyWith(color: kDetailColor),
            ),
            const VerticalSpacerBox(size: SpacerSize.large),
            Column(
              children: <Widget>[
                UtilCardHolder(
                    title: 'iEgg Timer', filePath: Assets.eggNutritionPng, onPushingRoute: () => widget.navigatorKey.currentState!.pushNamed(Screens.eggTimer), subtitle: 'Calcule o tempo de cozimento do ovo para ter aquela consistência bacana'),
                UtilCardHolder(
                    title: 'Informações nutricionais', filePath: Assets.eggTimerPng, onPushingRoute: () => widget.navigatorKey.currentState!.pushNamed(Screens.eggNutrition), subtitle: 'Saiba o que você está consumindo, calorias, nutrientes etc')
              ],
            )
          ],
        );
        break;
      // case Screens.eggTimer:
      //   page = EggTimerScreen();
      //   break;
      // case Screens.eggNutrition:
      //   page = EggNutritionScreen();
      //   break;
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      initialRoute: Screens.home,
      onGenerateRoute: _onGenerateRoute,
    );
  }
}

class UtilCardHolder extends StatelessWidget {
  const UtilCardHolder({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.filePath,
    required this.onPushingRoute,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final String filePath;
  final Function() onPushingRoute;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onPushingRoute,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(kMediumSize),
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Image.asset(
                    filePath,
                    width: 64,
                    height: 64,
                  )),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: kBody3.copyWith(color: textTheme.bodySmall!.color),
                        ),
                        Text(
                          subtitle,
                          style: kCaption2.copyWith(fontFamily: kDescriptionFontFamily),
                        )
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: kLargeSize,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
