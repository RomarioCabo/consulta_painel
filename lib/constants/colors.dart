import 'dart:ui';
import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    fontFamily: "Nunito",
    primaryColor: colorPrimary,
    accentColor: colorAccent,
    brightness: Brightness.light,
    backgroundColor: colorBackground,
    scaffoldBackgroundColor: colorBackground,
    dividerColor: colorDivider,
    errorColor: colorError,
    cardColor: colorCard,
    cardTheme: CardTheme(color: colorCard),
    appBarTheme: AppBarTheme(
      color: colorAppBar,
      textTheme: TextTheme(
        subtitle1: TextStyle(
          color: colorTextAppBar,
          fontWeight: FontWeight.w800,
          fontSize: 24,
          fontFamily: "Nunito",
        ),
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: colorPrimary,
      unselectedLabelColor: colorUnselectedLabelTabBar,
    ),
    textTheme: TextTheme(
      subtitle1: TextStyle(
        color: colorText,
        fontWeight: FontWeight.w800,
        fontSize: 24,
      ),
      subtitle2: TextStyle(
        color: colorText,
        fontWeight: FontWeight.w800,
        fontSize: 20,
      ),
      bodyText1: TextStyle(
        color: colorText,
        fontWeight: FontWeight.normal,
        fontSize: 20,
      ),
      bodyText2: TextStyle(
        color: colorTextLight,
        fontWeight: FontWeight.normal,
        fontSize: 14,
        height: 1.5,
      ),
      caption: TextStyle(
        color: colorTextExtraLight,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
    ),
    unselectedWidgetColor: colorUnselectedWidget,
    buttonTheme: ButtonThemeData(
        buttonColor: colorPrimary,
        textTheme: ButtonTextTheme.primary,
        disabledColor: colorPrimaryTransparent),
    buttonColor: colorPrimary,
    colorScheme: ColorScheme.light(
      primary: colorPrimary,
    ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: colorPrimary),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: colorAccent,
      contentTextStyle: TextStyle(color: Colors.white),
    ),
    dialogTheme: DialogTheme(backgroundColor: Colors.white),
  );
}

TextStyle styleTextField = TextStyle(
  color: colorTextField,
  fontWeight: FontWeight.normal,
  fontSize: 14,
);

const Color colorPrimary = Color(0xFF1160a5);
const Color colorPrimaryLight = Color(0xFF1f6aab);
const Color colorPrimaryTransparent = Color(0x801160a5);
const Color colorAccent = Color(0xFF1160a5);
const colorSecondary = Color(0xFF448AFF);

const Color colorTextButtonPrimary = Color(0xFFFFFFFF);

const Color colorAppBar = Color(0xFF1160a5);
const Color colorTextAppBar = Color(0xFFFFFFFF);

const Color colorTabBar = Color(0xFFFFFFFF);
const Color colorUnselectedLabelTabBar = Color(0xFFAAAAAA);

const Color colorBackground = Color(0xFFF0F0F0);
const Color colorBackgroundSecondary = Color(0xFFFFFFFF);
const Color colorChip = Color(0xFFCCCCCC);
const Color colorDivider = Color(0xFFCCCCCC);

const Color colorText = Color(0xFF555555);
const Color colorTextDark = Color(0xFF3333333);
const Color colorTextLight = Color(0xFF777777);
const Color colorTextExtraLight = Color(0xFF999999);

const Color colorTextFieldDisabled = Color(0xFFF5F5F5);

const Color colorUnselectedWidget = Color(0xFFBBBBBB);

const Color colorCard = Color(0xFFFFFFFF);
const Color colorMenu = Color(0xFFF5F5F5);

const Color colorTextField = Color(0xFF6c757d);

const Color colorError = Color(0xFFF44336);
const Color colorSuccess = Color(0xFF00C853);

const Color colorBeing = Color(0xFF2E7D32);
const Color colorFaulty = Color(0xFFC62828);
const Color colorJustified = Color(0xFF1565C0);
