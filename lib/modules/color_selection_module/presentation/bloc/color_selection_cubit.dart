part of '../../color_selection_part.dart';

@injectable
class ColorSelectionCubit extends Cubit<ColorThemeState> with BaseCubit<ColorThemeState> {

  ColorSelectionCubit() : super(ColorThemeState(colorState: ColorState.blue, themeState: ThemeState.light, themeData: blueLightTheme));

  void setTheme(ThemeState valueTheme, ColorState valueColor) {
    emit(ColorThemeState(colorState: valueColor, themeState: valueTheme, themeData: _getTheme(valueTheme, valueColor)));
  }

  ThemeData _getTheme(ThemeState valueTheme, ColorState valueColor){
    if(valueTheme == ThemeState.light){
      switch(valueColor){
        case ColorState.blue:
          return blueLightTheme;
        case ColorState.red:
          return orangeLightTheme;
        case ColorState.green:
          return greenLightTheme;
        default:
          return blueLightTheme;
      }
    }
    else{
      switch(valueColor){
        case ColorState.blue:
          return blueDarkTheme;
        case ColorState.red:
          return orangeDarkTheme;
        case ColorState.green:
          return greenDarkTheme;
        default:
          return blueDarkTheme;
      }
    }
  }
}