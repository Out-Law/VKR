part of '../../color_selection_part.dart';

class ColorSelectionWidget extends StatelessWidget {
  const ColorSelectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorSelectionCubit, ColorThemeState>(
      builder: (ctx, value){
        return BaseColorSelection(
          choiceThemeColors: value.themeState == ThemeState.light,
          onTap: (int index){
            if(index == 0){
              context.read<ColorSelectionCubit>().setTheme(value.themeState, ColorState.blue);
            }
            else if(index == 1){
              context.read<ColorSelectionCubit>().setTheme(value.themeState, ColorState.red);
            }
            else{
              context.read<ColorSelectionCubit>().setTheme(value.themeState, ColorState.green);
            }
          },
          choiceColor: value.colorState.index,
        );
      }
    );
  }
}
