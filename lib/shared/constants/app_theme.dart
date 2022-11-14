import 'package:flutter/material.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:thunderapp/shared/core/preferences_manager.dart';

class AppTheme with ChangeNotifier {
  CurrentAppTheme _currentAppTheme = CurrentAppTheme.light;
  CurrentAppTheme get currentAppTheme => _currentAppTheme;
  ThemeData getCurrentTheme(BuildContext context) {
    PreferencesManager.getTheme().then((value) {
      if (value) {
        _currentAppTheme = CurrentAppTheme.dark;
        notifyListeners();
      } else {
        _currentAppTheme = CurrentAppTheme.light;
      }
    }).catchError((e) {
      _currentAppTheme = CurrentAppTheme.light;
    });
    if (_currentAppTheme == CurrentAppTheme.light) {
      return getLightTheme(context);
    } else {
      return getDarkTheme(context);
    }
  }

  void toggleAppTheme() {
    if (_currentAppTheme == CurrentAppTheme.light) {
      _currentAppTheme = CurrentAppTheme.dark;
      notifyListeners();
    } else {
      _currentAppTheme = CurrentAppTheme.light;
      notifyListeners();
    }
    PreferencesManager.saveTheme(_currentAppTheme == CurrentAppTheme.dark ? true : false);
  }

  static ThemeData getLightTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: kBackgroundColor,
      useMaterial3: true,
      fontFamily: kDefaultFontFamily,
      textTheme: TextTheme(titleMedium: kTitle2.copyWith(color: kTextColor)),
      inputDecorationTheme: const InputDecorationTheme(hintStyle: kCaption2, labelStyle: kCaption2, counterStyle: kCaption2),
      appBarTheme: AppBarTheme.of(context).copyWith(iconTheme: const IconThemeData(color: kDetailColor), elevation: 0, backgroundColor: Colors.transparent),
    );
  }

  static ThemeData getDarkTheme(BuildContext context) {
    return ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: kPrimaryDarkColor,
        cardColor: kSecondaryDarkColor,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, titleTextStyle: kBody1, surfaceTintColor: Colors.white, iconTheme: IconThemeData(color: Colors.white)),
        inputDecorationTheme: const InputDecorationTheme(hintStyle: kCaption2),
        textTheme: TextTheme(
          titleMedium: kBody3.copyWith(color: kDarkTextColor),
          titleLarge: kBody3.copyWith(color: kDarkTextColor),
          bodySmall: kBody2.copyWith(color: kDarkTextColor),
          bodyLarge: kBody3.copyWith(color: kDarkTextColor),
          bodyMedium: kBody3.copyWith(color: kDarkTextColor),
          headlineSmall: kBody3.copyWith(color: kDarkTextColor),
          headlineMedium: kBody3.copyWith(color: kDarkTextColor),
          headlineLarge: kBody3.copyWith(color: kDarkTextColor),
        ));
  }
}
