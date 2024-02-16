import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vocabulary_app/view/styles/colors.dart';

abstract class ThemeManager {
  static ThemeData getAppTheme() {
    return ThemeData(
      scaffoldBackgroundColor: ColorManager.black,
      appBarTheme: const AppBarTheme(
        color: ColorManager.black,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 21,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.black,
        ),
      ),
    );
  }
}
