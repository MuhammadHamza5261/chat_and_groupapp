import 'package:flutter/material.dart';
import 'colors.dart';

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
    displayMedium: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color:AppColors.black9,
    ),
    displaySmall: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color:AppColors.black9,
    ),
    headlineMedium: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color:AppColors.black9
    ),
    headlineLarge: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color:AppColors.black9
    ),
    headlineSmall: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color:AppColors.black9,
    ),
    titleLarge: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color:AppColors.black9
    ),
    titleMedium: const TextStyle(
      fontSize: 10,
      color:AppColors.black9,
    ),
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
    primary: AppColors.black9,
    secondary: AppColors.black9,
    onSecondary: Colors.white,
  );

  AppTheme._();
}