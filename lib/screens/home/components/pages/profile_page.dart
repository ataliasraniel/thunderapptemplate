import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:thunderapp/components/buttons/custom_text_button.dart';
import 'package:thunderapp/screens/home/home_screen_controller.dart';
import 'package:thunderapp/shared/components/dialogs/default_alert_dialog.dart';
import 'package:thunderapp/shared/constants/app_theme.dart';
import 'package:thunderapp/shared/core/db/firestore_db_manager.dart';

import '../../../../components/buttons/primary_button.dart';
import '../../../../components/utils/vertical_spacer_box.dart';
import '../../../../shared/constants/app_enums.dart';
import '../../../../shared/constants/style_constants.dart';
import '../../../../shared/core/assets_index.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final HomeScreenController controller;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const VerticalSpacerBox(size: SpacerSize.huge),
        Text(
          'Descubra',
          style:
              kTitle1.copyWith(color: textTheme.titleMedium!.color),
        ),
        Text(
          'Seu perfil',
          style: kBody1.copyWith(color: kDetailColor),
        ),
        const VerticalSpacerBox(size: SpacerSize.medium),
        const Spacer(),
        Column(
          children: [
            Text(
              context
                  .read<HomeScreenController>()
                  .user
                  .currentUser!
                  .email!,
              textAlign: TextAlign.center,
              style: kTitle2,
            ),
            const VerticalSpacerBox(size: SpacerSize.medium),
            LottieBuilder.asset(
              Assets.eggLottie,
              width: 120,
            ),
            const VerticalSpacerBox(size: SpacerSize.huge),
            CustomTextButton(
                title: context.watch<AppTheme>().currentAppTheme ==
                        CurrentAppTheme.dark
                    ? 'Desativar Modo Escuro'
                    : 'Ativar Modo Escuro',
                onPressed: () {
                  controller.changeAppTheme();
                }),
            CustomTextButton(
                title: 'Sair da sua conta',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return DefaultAlertDialog(
                            title: 'Deseja sair da sua conta',
                            body: 'Você poderá entrar novamente',
                            cancelText: 'Cancelar',
                            onConfirm: () => controller.signOut(),
                            confirmText: 'Sair');
                      });
                }),
            const Divider(),
            CustomTextButton(
                title: 'Excluir minha conta',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return DefaultAlertDialog(
                            title: 'Excluir conta',
                            body:
                                'Ao Excluir sua conta, todos seus dados serão perdidos.',
                            cancelText: 'Cancelar',
                            onConfirm: () {
                              FirestoreDatabaseManager()
                                  .deleteAccount();
                            },
                            confirmText: 'Excluir');
                      });
                }),
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
