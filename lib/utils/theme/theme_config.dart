import 'package:flutter/material.dart';
import '../color/color_constants.dart';

class ThemeConfig {
  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: ColorConstants.scaffoldBackgroundColor,
    fontFamily: 'Nunito',
    cardColor: ColorConstants.cardColor,
    cardTheme: CardTheme(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.hardEdge,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: ColorConstants.cardColor),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.w600,
        color: ColorConstants.fontColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600,
        color: ColorConstants.fontColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: ColorConstants.fontColor,
      ),
      displayLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w400,
        color: ColorConstants.fontColor,
      ),
      displayMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: ColorConstants.fontColor,
      ),
      displaySmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: ColorConstants.fontColor,
      ),
    ),
  );
}
