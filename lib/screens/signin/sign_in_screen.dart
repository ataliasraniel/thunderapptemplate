import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thunderapp/components/buttons/custom_text_button.dart';
import 'package:thunderapp/components/buttons/primary_button.dart';
import 'package:thunderapp/components/forms/custom_text_form_field.dart';
import 'package:thunderapp/components/utils/vertical_spacer_box.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/screens/signin/sign_in_controller.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:thunderapp/shared/core/navigator.dart';

import '../../shared/components/util/svg_pic_renderer.dart';
import '../../shared/constants/app_enums.dart';
import '../../shared/core/assets_index.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _signInKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    /**Declare this variable to get the Media Query of the screen in the current context */
    Size size = MediaQuery.of(context).size;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SignInController()),
        ],
        builder: (context, child) {
          return Consumer<SignInController>(
            builder: (context, controller, child) => Scaffold(
              body: Form(
                key: _signInKey,
                child: Container(
                  width: size.width,
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      // Center(
                      //     child: Image.asset(
                      //   Assets.logo,
                      //   width: 68,
                      // )),
                      const VerticalSpacerBox(size: SpacerSize.large),
                      const Text(
                        'Olá, bem-vinde. Faça seu login para continuar',
                        style: kTitle2,
                      ),
                      const VerticalSpacerBox(size: SpacerSize.large),
                      CustomTextFormField(
                        hintText: 'email@email.com',
                        controller: controller.emailController,
                      ),
                      const VerticalSpacerBox(size: SpacerSize.small),
                      CustomTextFormField(
                        hintText: 'Sua senha',
                        isPassword: true,
                        controller: controller.passwordController,
                      ),
                      const VerticalSpacerBox(size: SpacerSize.medium),
                      controller.status == SignInStatus.loading
                          ? const Center(child: CircularProgressIndicator())
                          : PrimaryButton(
                              text: 'Continuar',
                              onPressed: () {
                                if (_signInKey.currentState!.validate()) {
                                  controller.signIn(context);
                                }
                              }),
                      const VerticalSpacerBox(size: SpacerSize.small),
                      SizedBox(
                        width: size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            controller.errorMessage != null
                                ? Text(
                                    textAlign: TextAlign.center,
                                    controller.errorMessage!,
                                    style: kCaption1.copyWith(color: kErrorColor),
                                  )
                                : const SizedBox(),
                            const Divider(),
                            ElevatedButton.icon(onPressed: () => controller.signInAnonimously(), icon: const Icon(Icons.person), label: const Text('Continuar como Anônimo')),
                            ElevatedButton.icon(onPressed: () async => controller.signInWithGoogle(), icon: const SvgPicRenderer(filePath: Assets.google, width: 26), label: const Text('Continuar com Google')),
                            const VerticalSpacerBox(size: SpacerSize.medium),
                            const Text('ou'),
                            CustomTextButton(
                              title: 'Cadastre-se',
                              onPressed: () {
                                navigatorKey.currentState!.pushNamed(Screens.signup);
                              },
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
