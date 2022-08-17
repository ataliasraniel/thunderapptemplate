import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreenController with ChangeNotifier {
  void requestUserGalleryPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      log('user has denied access, try again');
    }

// You can can also directly ask the permission about its status.
    if (await Permission.mediaLibrary.request().isGranted) {
      log('User has granted access');
      // The OS restricts access, for example because of parental controls.
    }
  }
}
