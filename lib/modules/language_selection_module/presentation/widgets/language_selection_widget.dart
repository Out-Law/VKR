import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_app/modules/language_selection_module/entities/language.dart';
import 'package:run_app/modules/language_selection_module/presentation/bloc/language_selection_bloc.dart';
import 'package:run_app/ui/components/base_switcher.dart';
import 'package:run_app/ui/components/base_text.dart';

class LanguageSelectionWidget extends StatelessWidget {
  const LanguageSelectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, String>(
      builder: (context, state) {
        return BaseSlideSwitcher(
          onSelect: (int index) {
            print(index);
            switch (index) {
              case 0:
                context.read<LocaleCubit>().changeLocalization(Language.Russian);
                break;
              case 1:
                context.read<LocaleCubit>().changeLocalization(Language.English);
                break;
              default:
                throw ArgumentError('Invalid index: $index');
            }
          },
          indents: 4,
          containerHeight: 50,
          containerWight: 235,
          children: const [
            BaseText(
              title: "Русский",
              size: 15,
            ),
            BaseText(
              title: "English",
              size: 15,
            )
          ],
        );
      },
    );
  }
}
