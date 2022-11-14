import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thunderapp/screens/sign%20up/sign_up_controller.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';

import '../../components/buttons/primary_button.dart';
import '../../components/forms/custom_text_form_field.dart';
import '../../components/utils/vertical_spacer_box.dart';
import '../../shared/constants/app_enums.dart';
import '../../shared/constants/style_constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signUpKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => SignUpScreenController(),
      builder: ((context, child) =>
          Consumer<SignUpScreenController>(
            builder: (context, controller, child) => Scaffold(
              appBar: controller.stepIndex != controller.maxSteps
                  ? AppBar()
                  : null,
              body: Form(
                key: _signUpKey,
                child: Container(
                  width: size.width,
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: controller.stepIndex != controller.maxSteps
                      ? Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                              const Text(
                                'Quer se cadastrar? Vamos lá!',
                                style: kTitle1,
                              ),
                              const VerticalSpacerBox(
                                  size: SpacerSize.small),
                              Text(
                                controller.stepIndex == 1
                                    ? 'Primeiro, me diz seu email'
                                    : 'Ótimo, agora crie uma senha beeem bacana',
                                style: kBody3.copyWith(
                                    color: kTextColor),
                              ),
                              const VerticalSpacerBox(
                                  size: SpacerSize.small),
                              controller.stepIndex == 1
                                  ? CustomTextFormField(
                                      hintText:
                                          'exemplo@exemplo.com',
                                      controller: controller
                                          .emailTextEditingController,
                                    )
                                  : CustomTextFormField(
                                      hintText:
                                          'Criatividade, ein?!',
                                      isPassword: true,
                                      controller: controller
                                          .passwordTextEditingController,
                                    ),
                              const VerticalSpacerBox(
                                  size: SpacerSize.small),
                              const VerticalSpacerBox(
                                  size: SpacerSize.medium),
                              const Spacer(),
                              Center(
                                  child: Text.rich(
                                      style: kCaption1,
                                      TextSpan(children: [
                                        const TextSpan(
                                          text: 'Passo ',
                                        ),
                                        TextSpan(
                                            text: controller
                                                .stepIndex
                                                .toString(),
                                            style: kCaption1.copyWith(
                                                color:
                                                    kDetailColor)),
                                        const TextSpan(
                                            text: ' de '),
                                        TextSpan(
                                            text: controller
                                                .maxSteps
                                                .toString())
                                      ]))),
                              const VerticalSpacerBox(
                                  size: SpacerSize.small),
                              controller.stepIndex == 1
                                  ? PrimaryButton(
                                      text: 'Próximo',
                                      onPressed: () {
                                        if (_signUpKey.currentState!
                                            .validate()) {
                                          controller.nextStep();
                                        }
                                      })
                                  : controller.screenState ==
                                          ScreenState.loading
                                      ? const Center(
                                          child:
                                              CircularProgressIndicator(),
                                        )
                                      : PrimaryButton(
                                          text: 'Finalizar',
                                          onPressed: () {
                                            if (_signUpKey
                                                .currentState!
                                                .validate()) {
                                              controller
                                                  .finishSignUp();
                                            }
                                          }),
                            ])
                      : Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.center,
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'AEEE!!! Você é o mais novo usuário do iEgg!',
                              textAlign: TextAlign.center,
                              style: kTitle1.copyWith(
                                  color: kDetailColor),
                            ),
                            const VerticalSpacerBox(
                                size: SpacerSize.medium),
                            Text(
                              'Agora é só você fazer login e confirmar tudo. Bem-vindo! ',
                              textAlign: TextAlign.center,
                              style: kBody1.copyWith(
                                  color: kTextColor),
                            ),
                            const VerticalSpacerBox(
                                size: SpacerSize.medium),
                            // PrimaryButton(
                            //     text: 'Maravilha!',
                            //     onPressed: () {
                            //       navigatorKey.currentState!.pop();
                            //     })
                          ],
                        ),
                ),
              ),
            ),
          )),
    );
  }
}
