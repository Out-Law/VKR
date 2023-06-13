import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:run_app/modules/reg_log_module/presentation/bloc/state_reg_log_cubit.dart';
import 'package:run_app/ui/components/base_background_container.dart';
import 'package:run_app/ui/components/base_button.dart';
import 'package:run_app/ui/components/base_screen.dart';
import 'package:run_app/ui/components/base_text.dart';
import 'package:run_app/ui/components/base_text_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _login = "";
    String _password = "";

    return BaseScreen(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 22, right: 22, top: 25, bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: SvgPicture.asset(
                        "assets/icons/previe_image.svg",
                        width: 222,
                        height: 180,
                      ),
                    ),
                    BaseBackgroundContainer(
                        margin: const EdgeInsets.only(top: 20),
                        color: Theme.of(context).canvasColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                             BaseText(
                                title: AppLocalizations.of(context)!.signIn,
                                size: 20),//Войти
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: BaseTextInput(
                                onChanged: (text) {
                                  _login = text;
                                },
                                hintText: "Введите логин",
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: BaseTextInput(
                                onChanged: (text) {
                                  _password = text;
                                },
                                hintText: "Введите пароль",
                                obscureText: true,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const BaseText(
                                    title: "Запомнить меня",
                                    size: 10,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w800,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read<StateRegLogCubit>()
                                          .switchRegistration();
                                    },
                                    child: const BaseText(
                                      title: "Востановить пароль?",
                                      size: 12,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w800,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                    Container(
                      margin: const EdgeInsets.only(top: 26),
                      child: BaseButton(
                        onClick: () {
                          context
                              .read<StateRegLogCubit>()
                              .signIn(_login, _password);
                        },
                        title: "Войти",
                        active: true,
                        sizeText: 24,
                        color: Theme.of(context).cardColor,
                        colorText: Theme.of(context).backgroundColor,
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 100,
                      margin: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 75,
                            height: 75,
                            child: IconButton(
                              onPressed: () {
                                context
                                    .read<StateRegLogCubit>()
                                    .signInWithGoogle();
                              },
                              icon: SvgPicture.asset(
                                "assets/icons/google.svg",
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 75,
                            height: 75,
                            child: IconButton(
                              onPressed: () {
                                context
                                    .read<StateRegLogCubit>()
                                    .signInWithApple();
                              },
                              icon: SvgPicture.asset(
                                "assets/icons/ios.svg",
                                width: 55,
                                height: 55,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // TODO: УДАЛИТЬ
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: IconButton(
                        onPressed: () {
                          context.read<StateRegLogCubit>().switchApplication();
                        },
                        icon: SvgPicture.asset(
                          "assets/icons/ios.svg",
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      child: const BaseText(
                          title: "Новый пользователь?", size: 14),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<StateRegLogCubit>().switchRegistration();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: const BaseText(
                          title: "Зарегестрируйся!",
                          size: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
