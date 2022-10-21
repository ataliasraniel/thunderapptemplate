import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thunderapp/components/buttons/custom_text_button.dart';
import 'package:thunderapp/components/buttons/primary_button.dart';
import 'package:thunderapp/components/forms/custom_text_form_field.dart';
import 'package:thunderapp/components/utils/vertical_spacer_box.dart';
import 'package:thunderapp/screens/sign%20up/sign_up_controller.dart';
import 'package:thunderapp/screens/signin/sign_in_controller.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

import '../../shared/constants/app_enums.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /**Declare this variable to get the Media Query of the screen in the current context */
    Size size = MediaQuery.of(context).size;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => SignUpController()),
        ],
        builder: (context, child) {
          return Consumer<SignUpController>(
            builder: (context, controller, child) =>
                Scaffold(
              appBar: AppBar(),
              backgroundColor: kPrimaryColor,
              body: Stack(
                children: [
                  Container(
                    width: size.width,
                    margin: EdgeInsets.only(
                        top: size.height * 0.3),
                    padding: const EdgeInsets.all(
                        kDefaultPadding),
                    decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius:
                            BorderRadius.circular(30)),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Center(
                          child: Text(
                            controller.infoIndex == 0
                                ? 'Cadastro'
                                : 'Endereço',
                            style: kTitle1.copyWith(
                                fontWeight:
                                    FontWeight.bold),
                          ),
                        ),
                        const VerticalSpacerBox(
                            size: SpacerSize.huge),
                        Form(
                          child: Column(
                            children: controller
                                        .infoIndex ==
                                    0
                                ? [
                                    CustomTextFormField(
                                      hintText: 'Nome',
                                      icon: Icons.person,
                                      controller: controller
                                          .emailController,
                                    ),
                                    const VerticalSpacerBox(
                                        size: SpacerSize
                                            .small),
                                    CustomTextFormField(
                                      hintText: 'E-mail',
                                      icon: Icons.email,
                                      controller: controller
                                          .passwordController,
                                    ),
                                    const VerticalSpacerBox(
                                        size: SpacerSize
                                            .small),
                                    CustomTextFormField(
                                      hintText: 'Senha',
                                      isPassword: true,
                                      icon: Icons.lock,
                                      controller: controller
                                          .passwordController,
                                    ),
                                    const VerticalSpacerBox(
                                        size: SpacerSize
                                            .small),
                                    CustomTextFormField(
                                      hintText: 'Telefone',
                                      icon: Icons.phone,
                                      controller: controller
                                          .passwordController,
                                    ),
                                  ]
                                : [
                                    CustomTextFormField(
                                      hintText: 'Rua',
                                      icon: Icons
                                          .location_city,
                                      controller: controller
                                          .emailController,
                                    ),
                                    const VerticalSpacerBox(
                                        size: SpacerSize
                                            .small),
                                    CustomTextFormField(
                                      hintText: 'CEP',
                                      icon: Icons
                                          .numbers_outlined,
                                      controller: controller
                                          .passwordController,
                                    ),
                                    const VerticalSpacerBox(
                                        size: SpacerSize
                                            .small),
                                    CustomTextFormField(
                                      hintText: 'Cidade',
                                      icon: Icons
                                          .location_city_rounded,
                                      controller: controller
                                          .passwordController,
                                    ),
                                    const VerticalSpacerBox(
                                        size: SpacerSize
                                            .small),
                                    CustomTextFormField(
                                      hintText: 'Número',
                                      icon:
                                          Icons.home_filled,
                                      controller: controller
                                          .passwordController,
                                    ),
                                  ],
                          ),
                        ),
                        const VerticalSpacerBox(
                            size: SpacerSize.huge),
                        controller.screenState ==
                                ScreenState.loading
                            ? const CircularProgressIndicator()
                            : PrimaryButton(
                                text: 'Próximo',
                                onPressed: () {
                                  controller.next();
                                }),
                        const VerticalSpacerBox(
                            size: SpacerSize.large),
                        controller.infoIndex != 0
                            ? Center(
                                child: CustomTextButton(
                                    onPressed: () =>
                                        controller.back(),
                                    title: 'Anterior'),
                              )
                            : const SizedBox(),
                        SizedBox(
                          width: size.width,
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.center,
                            children: <Widget>[
                              controller.errorMessage !=
                                      null
                                  ? Text(
                                      controller
                                          .errorMessage!,
                                      style: kCaption1,
                                    )
                                  : const SizedBox(),
                              const VerticalSpacerBox(
                                  size: SpacerSize.small),
                              controller.infoIndex == 0
                                  ? CustomTextButton(
                                      title:
                                          'Já tenho conta',
                                      onPressed: () {},
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          textAlign: TextAlign.center,
                          'Bem-vindo(a) ao App Bonito Produtor',
                          style: kTitle1.copyWith(
                              color: kBackgroundColor),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.5,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
