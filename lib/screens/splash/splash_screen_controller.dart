import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/shared/core/navigator.dart';
import 'package:thunderapp/shared/core/preferences_manager.dart';
import 'package:thunderapp/shared/core/user_manager.dart';
import 'package:thunderapp/shared/core/user_storage.dart';

class SplashScreenController {
  final BuildContext context;
  bool isFirstTime = false;
  SplashScreenController(this.context);
  final Logger _logger = Logger('Splash screen logger'); //a logger is always good to have
  final userStorage = UserStorage();

  ///this class is binded with SplashScreen widget and should be used
  /// to manage the startup logic of the app. ALL PRE LOAD DATA MUST BE HERE like the following:
  /// -- initialization of the app
  /// -- loading of the app
  /// -- getting startup data from the server
  /// -- setting and config startup data

  void initApplication(Function onComplete) async {
    ///initialize the application
    /// DO put all startup logic in here, the startup logic should be returned by futures
    /// so we can await the setup while the app don't freeze

    // navigatorKey.currentState!.pushReplacementNamed(Screens.signin);
    ///here we can put the logic that should be executed after the splash screen
    ///is shown for 3 seconds
    ///for example, we can go to the home screen after 3 seconds
    ///we can also use the following code to go to the home screen:
    ///Navigator.pushNamed(context, Screens.home);
    ///or we can use the following code to go to the sign in screen:
    await Future.delayed(const Duration(seconds: 3), () async {
      await configDefaultAppSettings();
    });
  }

  Future configDefaultAppSettings() async {
    _logger.config('Configuring default app settings...');
    const String loadedKey = 'loadedFirstTime';
    final prefs = await SharedPreferences.getInstance();
    PreferencesManager.saveIsFirstTime();
    setupGetIt();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _logger.fine('Default app settings configured!');
    final bool? isFirstTime = prefs.getBool(loadedKey);
    if (isFirstTime != null && isFirstTime) {
      log('First time user in: carrosel');
      navigatorKey.currentState!.pushNamed(Screens.carrousel);
    } else {
      log('User already open app: sign in or home');
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        log('Alright, checking firebase auth user');
        if (user == null) {
          log('User is $user');
          navigatorKey.currentState!.pushReplacementNamed(Screens.signin);
        } else {
          navigatorKey.currentState!.pushReplacementNamed(Screens.home);
        }
      });
      return;
    }
  }

  void setupGetIt() {
    final getIt = GetIt.instance;
    getIt.registerSingleton<UserManager>(UserManager());
  }
}
