import 'package:bot_toast/bot_toast.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:thunderapp/screens/carrousel/carrousel_screen.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/screens/sign%20up/sign_up_screen.dart';
import 'package:thunderapp/shared/constants/app_theme.dart';
import 'package:thunderapp/shared/core/navigator.dart';

import 'screens/home/home_screen.dart';
import 'screens/signin/sign_in_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'shared/core/features/notifications/notifications_manager.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    // NotificationManager().init(context: context, key: navigatorKey);
  }

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppTheme())],
      builder: ((context, child) => MaterialApp(
            useInheritedMediaQuery: true,
            navigatorObservers: [BotToastNavigatorObserver()],
            onGenerateRoute: (settings) {
              late Widget page;
              if (settings.name == Screens.home) {
                page = const HomeScreen();
              } else if (settings.name == Screens.eggTimer) {
                // page = const EggTimerScreen();
              }
              return MaterialPageRoute(
                  builder: (context) {
                    return page;
                  },
                  settings: settings);
            },
            navigatorKey: navigatorKey,
            locale: DevicePreview.locale(context),
            builder: (context, child) {
              child = botToastBuilder(context, child);
              child = DevicePreview.appBuilder(
                  context,
                  ResponsiveWrapper.builder(child, minWidth: 640, maxWidth: 1980, defaultScale: true, breakpoints: const [
                    ResponsiveBreakpoint.resize(480, name: MOBILE),
                    ResponsiveBreakpoint.resize(768, name: TABLET),
                    ResponsiveBreakpoint.resize(1024, name: DESKTOP),
                  ]));
              return child;
            },
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
            theme: context.watch<AppTheme>().getCurrentTheme(context),
            routes: {
              Screens.splash: (BuildContext context) => const SplashScreen(),
              Screens.home: (BuildContext context) => const HomeScreen(),
              Screens.signin: (BuildContext context) => const SignInScreen(),
              Screens.carrousel: (_) => const CarrouselScreen(),
              // Screens.eggTimer: (_) => const EggTimerScreen(),
              Screens.signup: (_) => const SignUpScreen(),
              // Screens.recipeView: (_) => const RecipeViewScreen()
            },
          )),
    );
  }
}
