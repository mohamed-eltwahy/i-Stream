import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:streamit_flutter/utils/resources/colors.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: appBackground,
    splashColor: navigationBackground,
    primaryColor: colorPrimary,
    primaryColorDark: colorPrimaryDark,
    accentColor: colorPrimary,
    errorColor: Color(0xFFE15858),
    hoverColor: Colors.grey,
    cardColor: navigationBackground,
    disabledColor: Colors.white10,
    fontFamily: GoogleFonts.nunito().fontFamily,
    appBarTheme: AppBarTheme(
      color: appBackground,
      iconTheme: IconThemeData(color: textColorPrimary),
    ),
    colorScheme: ColorScheme.light(
      primary: colorPrimary,
      onPrimary: colorPrimary,
      primaryVariant: colorPrimary,
      secondary: colorPrimary,
    ),
    cardTheme: CardTheme(color: navigationBackground),
    iconTheme: IconThemeData(color: textColorPrimary),
    textTheme: TextTheme(
      button: TextStyle(color: Colors.white),
      subtitle1: TextStyle(color: textColorPrimary),
      subtitle2: TextStyle(color: textColorSecondary),
      caption: TextStyle(color: textColorThird),
      headline6: TextStyle(color: Colors.white),
    ),
    dialogBackgroundColor: navigationBackground,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: navigationBackground,
    ),
  );
}
