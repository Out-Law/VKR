import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:run_app/modules/color_selection_module/color_selection_part.dart';
import 'package:run_app/modules/language_selection_module/presentation/widgets/language_selection_widget.dart';
import 'package:run_app/ui/components/base_background_container.dart';
import 'package:run_app/ui/components/base_screen.dart';
import 'package:run_app/ui/components/base_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
   const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ColoredBox(
            color: Theme.of(context).backgroundColor,
            child: Column(
              children: [
                appBar(context),
                body(context),
              ],
            ),
          ),
      ),
    );
  }

  Widget appBar(BuildContext context){
    return Container(
      alignment: Alignment.topLeft,
      width: MediaQuery.of(context).size.width/1.6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 26),
            child: IconButton(
              onPressed: (){
                context.router.navigateBack();
              },
              icon: SvgPicture.asset(
                "assets/icons/back_arrow.svg",
              ),
            ),
          ),
          const BaseText(
            title: "Настройки",
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget body(BuildContext context) {
    return BaseBackgroundContainer(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children:  [
            BaseText(
              title: AppLocalizations.of(context)!.languageSelection,
              size: 18,
            ),//Выбор языка
            const LanguageSelectionWidget(),
            BaseText(
              title: AppLocalizations.of(context)!.customization,
              size: 18,
            ),//Кастомизация
            const ThemeSelectionWidget(),
            BaseText(
              title: AppLocalizations.of(context)!.colorStyling,
              size: 18,
            ),//Цветовая стилистика
            const ColorSelectionWidget(),
          ],
        )
    );
  }
}
