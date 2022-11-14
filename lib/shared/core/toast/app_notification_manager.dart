import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

class AppSnackbarManager {
  static void showSimpleNotification(NotificationType type, [String? title]) {
    Color typeColor;
    String notificationTitle;

    switch (type) {
      case NotificationType.success:
        typeColor = kSuccessColor;
        notificationTitle = 'Sucesso! 🥚';
        break;
      case NotificationType.error:
        typeColor = kErrorColor;
        notificationTitle = 'Puxa, alguma coisa deu errado...';

        break;
      case NotificationType.alert:
        typeColor = kAlertColor;
        notificationTitle = 'Ei, isso não está certo';

        break;
      default:
        typeColor = kSuccessColor;
        notificationTitle = 'Sucesso! 🥚';
    }
    BotToast.showSimpleNotification(titleStyle: kCaption2.copyWith(color: Colors.white), hideCloseButton: true, title: title ?? notificationTitle, backgroundColor: typeColor);
  }
}
