import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:thunderapp/screens/home/home_screen_controller.dart';

import '../../../../components/buttons/primary_button.dart';
import '../../../../components/utils/vertical_spacer_box.dart';
import '../../../../shared/constants/app_enums.dart';
import '../../../../shared/constants/style_constants.dart';
import '../../../../shared/core/assets_index.dart';

class PageThree extends StatefulWidget {
  const PageThree({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final HomeScreenController controller;

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  @override
  void initState() {
    widget.controller.getRandomTriviaText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const VerticalSpacerBox(size: SpacerSize.huge),
        Text(
          'Descubra',
          style: kTitle1.copyWith(color: textTheme.titleMedium!.color),
        ),
        Text(
          'Muitchas curiosidades',
          style: kBody1.copyWith(color: kDetailColor),
        ),
        const VerticalSpacerBox(size: SpacerSize.medium),
        const Spacer(),
        Column(
          children: [
            const Text(
              'Curiosidade do dia',
              style: kTitle2,
            ),
            Text(
              'Se liga nessa:',
              style: kCaption1.copyWith(color: kDetailColor),
            ),
            const VerticalSpacerBox(size: SpacerSize.medium),
            LottieBuilder.asset(
              Assets.eggLottie,
              width: 160,
            ),
            const VerticalSpacerBox(size: SpacerSize.medium),
            Text(widget.controller.triviaText ?? '...', style: kBody3, textAlign: TextAlign.center),
            const VerticalSpacerBox(size: SpacerSize.medium),
            PrimaryButton(
                hasIcon: true,
                icon: Icons.refresh,
                text: 'Me dê mais uma',
                onPressed: () {
                  widget.controller.getRandomTriviaText();
                })
          ],
        ),
        const Spacer(),

        // Column(
        //   children: List.generate(
        //       20,
        //       (index) => Column(
        //             children: <Widget>[
        //               Text(
        //                   'A galinha não depende do Galo para gerar um ovo')
        //             ],
        //           )),
        // )
      ],
    );
  }
}
