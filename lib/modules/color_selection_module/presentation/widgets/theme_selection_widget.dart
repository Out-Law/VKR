part of '../../color_selection_part.dart';

class ThemeSelectionWidget extends StatelessWidget {
  const ThemeSelectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorSelectionCubit, ColorThemeState>(
        builder: (ctx, value){
          return BaseSlideSwitcher(
            onSelect: (int index) {
              if(index == 0){
                context.read<ColorSelectionCubit>().setTheme(ThemeState.light, value.colorState);
              }
              else{
                context.read<ColorSelectionCubit>().setTheme(ThemeState.black, value.colorState);
              }
            },
            indents: 4,
            containerHeight: 50,
            containerWight: 235,
            children: const [
              BaseText(
                title: "Светлая",
                size: 15,
              ),
              BaseText(
                title: "Тёмная",
                size: 15,
              )
            ],
          );
        }
    );
  }
}
