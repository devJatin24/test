import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

ThemeData get defaultAppThemeData => ThemeData(
    fontFamily: AppFonts.textRegular,
    primarySwatch: materialPrimaryColor,
    accentColor: materialAccentColor,
    // scaffoldBackgroundColor: CupertinoColors.extraLightBackgroundGray,
    appBarTheme: AppBarTheme().copyWith(brightness: Brightness.dark),
    platform: TargetPlatform.android,
    iconTheme: IconThemeData(color: Colors.white),
    primaryIconTheme: IconThemeData(color: Colors.white));

const MaterialColor materialPrimaryColor = const MaterialColor(
  0xffFFBE1F,
  const <int, Color>{
    50: const Color(0xffFFBE1F),
    100: const Color(0xffFFBE1F),
    200: const Color(0xffFFBE1F),
    300: const Color(0xffFFBE1F),
    400: const Color(0xffFFBE1F),
    500: const Color(0xffFFBE1F),
    600: const Color(0xffFFBE1F),
    700: const Color(0xffFFBE1F),
    800: const Color(0xffFFBE1F),
    900: const Color(0xffFFBE1F),
  },
);

/*
* New colors added to make ui more clean
* */

const textColorPrimary = Color(0xFF444444);
const cboGrey = Color(0xFFF2F2F2);
const widgetViewColor = Color(0xFFEEEEF1);
const layout_background = Color(0xFFF6F7FA);
const dbShadowColor = Color(0x95E9EBF0);
const appIconTint_sky_blue = Color(0xFF73d8d4);
const appIconTint_mustard_yellow = Color(0xFFffc980);
const appIconTintDark_purple = Color(0xFF8998ff);
const appTxtTintDark_purple = Color(0xFF515BBE);
const appIconTintDarkCherry = Color(0xFFf2866c);
const appIconTintDark_sky_blue = Color(0xFF73d8d4);
const appDark_parrot_green = Color(0xFF5BC136);
const appDarkRed = Color(0xFFF06263);
const appLightRed = Color(0xFFF89B9D);
const bluePurple = Color(0xFF8998FE);
const catOrange = Color(0xFFFF9781);
const greenBlue = Color(0xFF73D7D3);
const skyBlue = Color(0xFF87CEFA);

Color get primaryColor => materialPrimaryColor;

Color get primaryRed => Colors.red;

Color get primaryRed20 => Colors.red.shade200;

Color get primaryRed40 => Colors.red.shade400;

Color get primaryRed60 => Colors.red.shade600;

// Color get materialAccentColor => Color(0xffFDC800);
Color get materialAccentColor =>Color(0xff002e5b);
//from old app
// Color get materialAccentColor => Color(0xff267b1b);

Color get textBlueDark => Color(0xff3051A0);

Color get categoryIconCyan => Color(0xff1bbef9);

Color get categoryTitleGrayDark => Color(0xff707070);

Color get categoryCardBg => Color(0xffe6ecf2);

Color get lightDividerColor => Colors.grey.shade200;

Color get borderSideColor => Colors.black26;

Color get borderSideFocusedColor => primaryColor;

Color get lightGrey50 => Colors.grey.shade50;

Color get whiteColor => Colors.white;

MaterialColor get randomColor => Colors.primaries[Random().nextInt(Colors.primaries.length)];

abstract class AppFonts {
  static String  textRegular = 'LatoRegular';
  static String  textBold = 'LatoBold';
  static String  textSemiBold = 'LatoBold';
}
