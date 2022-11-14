import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:thunderapp/components/buttons/custom_text_button.dart';
import 'package:thunderapp/components/buttons/primary_button.dart';
import 'package:thunderapp/components/utils/vertical_spacer_box.dart';
import 'package:thunderapp/screens/carrousel/carrousel_controller.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:thunderapp/shared/core/assets_index.dart';

class CarrouselScreen extends StatelessWidget {
  const CarrouselScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CarrouselScreenController(),
      builder: (context, child) => Consumer<CarrouselScreenController>(
        builder: ((context, controller, child) => Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: PageView(
                  controller: controller.pageController,
                  children: const [
                    PageTemplate(
                      title: 'Olá, bem-vindo ao Aplicativo do Diretório Acadêmico de Letras',
                      lottiePath: Assets.eggLottie,
                      primaryButtonTitle: 'Começar',
                      subtitle: 'Subtítulo do carrossel',
                    ),
                    PageTemplate(
                      title: 'Receita pra tudo!',
                      primaryButtonTitle: 'Próximo',
                      lottiePath: Assets.eggRecipeLottie,
                      subtitle: 'Aqui você vai encontrat TUDO sobre ovos, as melhores receitas estão aqui. Que paraíso ein?!',
                    ),
                    PageTemplate(
                      title: 'É isso!',
                      primaryButtonTitle: 'Oba!',
                      lottiePath: Assets.eggCrackingLottie,
                      subtitle: 'Espero de ovocoração que você faça muitas receitinhas. Divirta-se <3',
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class PageTemplate extends StatelessWidget {
  const PageTemplate({
    Key? key,
    required this.title,
    required this.lottiePath,
    required this.subtitle,
    required this.primaryButtonTitle,
  }) : super(key: key);
  final String title;
  final String lottiePath;
  final String subtitle;
  final String primaryButtonTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const VerticalSpacerBox(size: SpacerSize.huge),
        Text(
          '${context.watch<CarrouselScreenController>().currentPageIndex}/3',
          style: kBody1,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Text(
          title,
          style: kTitle2,
          textAlign: TextAlign.center,
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        // LottieBuilder.asset(
        //   lottiePath,
        //   width: 220,
        // ),
        const VerticalSpacerBox(size: SpacerSize.small),
        Text(
          subtitle,
          style: kBody2,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Column(
          children: <Widget>[
            PrimaryButton(
              text: primaryButtonTitle,
              onPressed: () {
                context.read<CarrouselScreenController>().nextPage();
              },
            ),
            const VerticalSpacerBox(size: SpacerSize.small),
            context.watch<CarrouselScreenController>().currentPageIndex > 1
                ? CustomTextButton(
                    title: 'Voltar',
                    onPressed: () {
                      context.read<CarrouselScreenController>().previousPage();
                    })
                : CustomTextButton(
                    title: 'Pular',
                    onPressed: () {
                      context.read<CarrouselScreenController>().changePageIndex(2);
                    }),
          ],
        )
      ],
    );
  }
}
