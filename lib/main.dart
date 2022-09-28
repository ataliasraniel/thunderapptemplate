import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:thunderapp/app.dart';
import 'package:thunderapp/screens/home/home_screen_controller.dart';
import 'package:thunderapp/shared/core/selected_item.dart';
import 'package:timezone/data/latest_all.dart' as tz;

main() {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {});
  MultiProvider(providers: [ChangeNotifierProvider(create: (_) => HomeScreenController()), ChangeNotifierProvider(create: (_) => SelectedItem())], child: const App());

  runApp(DevicePreview(enabled: defaultTargetPlatform == TargetPlatform.android ? false : true, builder: (context) => const App()));
}
