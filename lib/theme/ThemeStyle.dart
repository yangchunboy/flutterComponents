import 'package:flutter/material.dart';
import 'package:app/theme/ColorTheme.dart';
import 'package:app/theme/FontTheme.dart';

class ThemeStyle {

  static ThemeData light() {
    return ThemeData(
      primaryColor: LightColor.primary,
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: FontTheme.text,
          color: LightColor.description
        ),
        bodyText2: TextStyle(
          fontSize: FontTheme.text,
          color: LightColor.textColor
        )
      ),
      backgroundColor: LightColor.background,
      disabledColor: LightColor.description,
    );
  }


  static ThemeData dark() {
    return ThemeData(
      primaryColor: DarkColor.primary,
      accentColor: DarkColor.textColor
    );
  }


}