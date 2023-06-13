import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:run_app/modules/reg_log_module/presentation/bloc/state_reg_log_cubit.dart';
import 'package:run_app/ui/components/base_background_container.dart';
import 'package:run_app/ui/components/base_button.dart';
import 'package:run_app/ui/components/base_screen.dart';
import 'package:run_app/ui/components/base_text.dart';
import 'package:run_app/ui/components/base_text_input.dart';
import 'package:run_app/utils/helper.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _login = "";
    String _password = "";
    String _passwordRepeat = "";

    return BaseScreen(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 12),
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      context.read<StateRegLogCubit>().switchAuthorization();
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/back_arrow.svg",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 22, right: 22, top: 25, bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/registr_img.svg",
                      width: 220,
                      height: 163,
                    ),
                    BaseBackgroundContainer(
                        margin: const EdgeInsets.only(top: 20),
                        color: Theme.of(context).canvasColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const BaseText(title: "Войти", size: 20),
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
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: BaseTextInput(
                                onChanged: (text) {
                                  _passwordRepeat = text;
                                },
                                obscureText: true,
                                hintText: "Повторите пароль",
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
                          if (_login.isEmpty) {
                            showSnackbar(context, "Введите логин");
                            return;
                          }

                          if (_password.length < 6) {
                            showSnackbar(
                                context, "Длина пароля не менее 6 символов!");
                            return;
                          }

                          if (_password == _passwordRepeat) {
                            context
                                .read<StateRegLogCubit>()
                                .signUp(_login, _password);
                          } else {
                            showSnackbar(context, "Пароли не совпадают!");
                            return;
                          }
                        },
                        title: "Зарегестрироваться",
                        active: true,
                        sizeText: 24,
                        color: Theme.of(context).cardColor,
                        colorText: Theme.of(context).backgroundColor,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: BaseButton(
                        onClick: () {
                          context
                              .read<StateRegLogCubit>()
                              .switchNoRegistration();
                        },
                        title: "Продолжить без регистрации",
                        active: false,
                        sizeText: 16,
                        color: Theme.of(context).cardColor,
                        colorText: Theme.of(context).cardColor,
                        activeBorder: true,
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 100,
                      margin: const EdgeInsets.only(top: 4),
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
                          )
                        ],
                      ),
                    ),
                    const BaseText(
                      title: "Добро пожаловать в нашу команду!",
                      size: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
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
