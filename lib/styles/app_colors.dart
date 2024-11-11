import 'package:flutter/material.dart';

abstract class AppColors {
  // static const Color primary = Color(0xFFC11718);
  // static const Color primary = Color(0xFF9fd276);
  // static const Color primary = Color(0xFF49B81F);
  static const Color primary = Color(0xFF49B81F);
  static const Color errorToastColor = Color(0xFFC11718);
  static const Color successToastColor = Color(0xFF2EBD44);
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);
  static const Color lightBlack = Color(0xff333333);
  static const Color lightOrange = Color(0xfffe9654);
  static const Color greyShadow = Color(0xffD9D9D9);
  static const Color blue = Color(0xFF2196F3);
  static const Color lightBlue = Color(0xFF58b9f0);
  static const Color whiteGrey = Color(0xFF595858);
  static const Color scaffoldColor = Color(0xffe7e5e5);
  static const Color lightGrey = Color(0xffe1e0e0);
  static const Color iconColor = Color(0x9E545252);
  static const Color blackGrey = Color(0xFF333232);
  static const Color blackLight = Colors.black54;
  static Color textFieldColor = const Color(0xFFBDBDBD).withOpacity(0.3) ;

  static const LinearGradient primaryIngredientColor = LinearGradient(
    colors: [Color(0xFF49B81F), Color(0xFF49B81F)],
    stops: [0, 1],
  );

  static const LinearGradient redButtonColor = LinearGradient(
    colors: [Color(0xFFD31D1D), Color(0xFFC11718)],
    stops: [0, 1],
  );

  static const LinearGradient disableIngredientColor = LinearGradient(
    colors: [Color(0xffa8a6a6), Color(0xFF646464)],
    stops: [0, 1],
  );
}

//0xffe7e5e5
