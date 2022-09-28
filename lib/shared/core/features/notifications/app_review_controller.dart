import 'package:rate_my_app/rate_my_app.dart';

class AppReviewController {
  static RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 0,
    minLaunches: 0,
    remindDays: 3,
    remindLaunches: 5,
    googlePlayIdentifier: 'com.ardevstudio.iegg',
  );
  // Future<bool> requestIteaAppReview() async {
  //   try {
  //     final available = await inAppReview.isAvailable();
  //     if (available) {
  //       inAppReview.requestReview();
  //     } else {
  //       print('App Review is not available');
  //     }
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }
}
