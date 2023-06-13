import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light();

ThemeData darkTheme = ThemeData.dark();


///Темные темы:
///1
ThemeData blueDarkTheme = darkTheme.copyWith(
    ///цвет фона и плажки
    backgroundColor: const Color(0xff161616),
    scaffoldBackgroundColor: const Color(0xff2E2E2E),

    ///Цвета тёмной темы который меняется
    canvasColor: const Color(0xFF658FC9),

    ///цвета шрифтов
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Color(0xFFFFFFFF),
      ),
      bodyText2: TextStyle(
        color: Color(0xFF979797),
      ),
      headline1: TextStyle(
        color: Color(0xFF646464),
      ),
    ),

    ///Акцентные цвета
    primaryColor: const Color(0xFF658FC9),
    cardColor: const Color(0xFF313043),
    focusColor: const Color(0xFFF82525),

    ///Дополнительные цвета
    secondaryHeaderColor: const Color(0xFFF95E4F),
    indicatorColor: const Color(0xFFFC8619),
    selectedRowColor: const Color(0xFF373737),
    disabledColor: const Color(0xFF4BB848),
    errorColor: const Color(0xFFBBBBBB),
);

///2
ThemeData orangeDarkTheme = darkTheme.copyWith(
  ///цвет фона и плажки
  backgroundColor: const Color(0xff161616),
  scaffoldBackgroundColor: const Color(0xff2E2E2E),

  ///Цвета тёмной темы который меняется
  canvasColor: const Color(0xFFF95E4F),

  ///цвета шрифтов
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Color(0xFFFFFFFF),
    ),
    bodyText2: TextStyle(
      color: Color(0xFF979797),
    ),
    headline1: TextStyle(
      color: Color(0xFF646464),
    ),
  ),

  ///Акцентные цвета
  primaryColor: const Color(0xFF658FC9),
  cardColor: const Color(0xFF313043),
  focusColor: const Color(0xFFF82525),

  ///Дополнительные цвета
  secondaryHeaderColor: const Color(0xFFF95E4F),
  indicatorColor: const Color(0xFFFC8619),
  selectedRowColor: const Color(0xFF373737),
  disabledColor: const Color(0xFF4BB848),
  errorColor: const Color(0xFFBBBBBB),
);

///3
ThemeData greenDarkTheme = darkTheme.copyWith(
  ///цвет фона и плажки
  backgroundColor: const Color(0xff161616),
  scaffoldBackgroundColor: const Color(0xff2E2E2E),

  ///Цвета тёмной темы который меняется
  canvasColor: const Color(0xFF4BB848),

  ///цвета шрифтов
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Color(0xFFFFFFFF),
    ),
    bodyText2: TextStyle(
      color: Color(0xFF979797),
    ),
    headline1: TextStyle(
      color: Color(0xFF646464),
    ),
  ),

  ///Акцентные цвета
  primaryColor: const Color(0xFF658FC9),
  cardColor: const Color(0xFF313043),
  focusColor: const Color(0xFFF82525),

  ///Дополнительные цвета
  secondaryHeaderColor: const Color(0xFFF95E4F),
  indicatorColor: const Color(0xFFFC8619),
  selectedRowColor: const Color(0xFF373737),
  disabledColor: const Color(0xFF4BB848),
  errorColor: const Color(0xFFBBBBBB),
);


///Светлые темы:
///1
ThemeData blueLightTheme = lightTheme.copyWith(
  ///цвет фона и плажки
  backgroundColor: const Color(0xffF6F6F6),
  scaffoldBackgroundColor: const Color(0xffFFFFFF),

  ///Цвета тёмной темы который меняется
  canvasColor: const Color(0xFFA9C8F2),

  ///цвета шрифтов
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Color(0xFF111111),
    ),
    bodyText2: TextStyle(
      color: Color(0xFF373737),
    ),
    headline1: TextStyle(
      color: Color(0xFF979797),
    ),
  ),

  ///Акцентные цвета
  primaryColor: const Color(0xFFA9C8F2),
  cardColor: const Color(0xFF3F3D56),
  focusColor: const Color(0xFFEE2C2C),

  ///Дополнительные цвета
  secondaryHeaderColor: const Color(0xFFFF6F61),
  indicatorColor: const Color(0xFFFF8A1E),
  selectedRowColor: const Color(0xFF373737),
  disabledColor: const Color(0xFF5EB95C),
  errorColor: const Color(0xFF646464),
);

///2
ThemeData orangeLightTheme = lightTheme.copyWith(
  ///цвет фона и плажки
  backgroundColor: const Color(0xffF6F6F6),
  scaffoldBackgroundColor: const Color(0xffFFFFFF),

  ///Цвета тёмной темы который меняется
  canvasColor: const Color(0xFFFF6F61),

  ///цвета шрифтов
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Color(0xFF111111),
    ),
    bodyText2: TextStyle(
      color: Color(0xFF373737),
    ),
    headline1: TextStyle(
      color: Color(0xFF979797),
    ),
  ),

  ///Акцентные цвета
  primaryColor: const Color(0xFFA9C8F2),
  cardColor: const Color(0xFF3F3D56),
  focusColor: const Color(0xFFEE2C2C),

  ///Дополнительные цвета
  secondaryHeaderColor: const Color(0xFFFF6F61),
  indicatorColor: const Color(0xFFFF8A1E),
  selectedRowColor: const Color(0xFF373737),
  disabledColor: const Color(0xFF5EB95C),
  errorColor: const Color(0xFF646464),
);

///3
ThemeData greenLightTheme = lightTheme.copyWith(
  ///цвет фона и плажки
  backgroundColor: const Color(0xffF6F6F6),
  scaffoldBackgroundColor: const Color(0xffFFFFFF),

  ///Цвета тёмной темы который меняется
  canvasColor: const Color(0xFF5EB95C),

  ///цвета шрифтов
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Color(0xFF111111),
    ),
    bodyText2: TextStyle(
      color: Color(0xFF373737),
    ),
    headline1: TextStyle(
      color: Color(0xFF979797),
    ),
  ),

  ///Акцентные цвета
  primaryColor: const Color(0xFFA9C8F2),
  cardColor: const Color(0xFF3F3D56),
  focusColor: const Color(0xFFEE2C2C),

  ///Дополнительные цвета
  secondaryHeaderColor: const Color(0xFFFF6F61),
  indicatorColor: const Color(0xFFFF8A1E),
  selectedRowColor: const Color(0xFF373737),
  disabledColor: const Color(0xFF5EB95C),
  errorColor: const Color(0xFF646464),
);

