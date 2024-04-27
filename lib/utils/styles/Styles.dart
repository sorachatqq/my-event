import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../state/theme_state.dart';

class Styles {
  static ThemeData themeData(BuildContext context) {
    final ThemeState themeController = Get.put(ThemeState());

    return ThemeData(
        primarySwatch: Colors.red,
        primaryColor:
            themeController.isDarkMode.value ? Colors.black : Colors.white,
        // backgroundColor: isDarkTheme ? Colors.black : Color(0xffF1F5FB),
        indicatorColor: themeController.isDarkMode.value
            ? Color(0xff0E1D36)
            : Color(0xffCBDCF8),
        // buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
        hintColor: themeController.isDarkMode.value
            ? Color(0xff280C0B)
            : Color(0xffEECED3),
        highlightColor: themeController.isDarkMode.value
            ? Color(0xff372901)
            : Color(0xffFCE192),
        hoverColor: themeController.isDarkMode.value
            ? Color(0xff3A3A3B)
            : Color(0xff4285F4),
        focusColor: themeController.isDarkMode.value
            ? Color(0xff0B2512)
            : Color(0xffA8DAB5),
        disabledColor: Colors.grey,
        // textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
        cardColor:
            themeController.isDarkMode.value ? Color(0xFF151515) : Colors.white,
        canvasColor:
            themeController.isDarkMode.value ? Colors.black : Colors.grey[50],
        brightness: themeController.isDarkMode.value
            ? Brightness.dark
            : Brightness.light,
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: themeController.isDarkMode.value
                ? ColorScheme.dark()
                : ColorScheme.light()),
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
        ),
        fontFamily: GoogleFonts.athiti().fontFamily);
  }
}
