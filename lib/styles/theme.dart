import 'package:flutter/material.dart';


import 'app_colors.dart';
import 'font_styles.dart';

class AppTheme {
  static final appTheme = _baseTheme.copyWith(
    cardTheme: _baseTheme.cardTheme.copyWith(
      margin: EdgeInsets.zero,
    ),
    iconTheme: _baseTheme.iconTheme.copyWith(
      color: _colorScheme.onBackground,
    ),
    textTheme: _baseTextTheme,
    // accentTextTheme: _baseTextTheme.apply(
    //   fontFamily: 'Montserrat',
    //   bodyColor: _colorScheme.secondary,
    //   displayColor: _colorScheme.secondary,
    // ),
  );

  static final onPrimaryTextTheme = _baseTextTheme.apply(
    fontFamily: 'Montserrat',
    bodyColor: Colors.white,
    displayColor: Colors.white,
  );

  static final _baseTextTheme = _baseTheme.textTheme
      .copyWith(
        headline1: const TextStyle(
            fontSize: 24,
            fontWeight: FontStyles.fontWeightSemiBold,
            color: AppColors.black),
        headline2: const TextStyle(
            fontSize: 22,
            fontWeight: FontStyles.fontWeightSemiBold,
            color: AppColors.black),
        headline3: const TextStyle(
            fontSize: 20,
            fontWeight: FontStyles.fontWeightSemiBold,
            color: AppColors.black),
        headline4: const TextStyle(
            fontSize: 18, fontWeight: FontStyles.fontWeightSemiBold
            //  color:AppColors.headingColor
            ),
        headline5: const TextStyle(
            fontSize: 16, fontWeight: FontStyles.fontWeightSemiBold
            // color:AppColors.headingColor
            ),
        headline6: const TextStyle(
            fontSize: 14, fontWeight: FontStyles.fontWeightSemiBold
            //  color:AppColors.headingColor
            ),
        subtitle1: const TextStyle(
          fontSize: 12,
          // color:AppColors.headingColor
        ),
        subtitle2: const TextStyle(fontSize: 10),
      )
      .apply(
        fontFamily: 'Montserrat',
        displayColor: _colorScheme.onBackground,
        bodyColor: _colorScheme.onBackground,
      );

  static final _baseTheme = ThemeData.from(
    colorScheme: _colorScheme,
    textTheme: Typography.material2018().black,
  );

  static const _colorScheme = ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.lightOrange,
    onSecondary: Colors.white,
  );

  AppTheme._();
}
