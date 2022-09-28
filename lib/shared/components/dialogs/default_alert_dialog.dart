import 'package:flutter/material.dart';
import 'package:thunderapp/components/buttons/custom_text_button.dart';
import 'package:thunderapp/components/buttons/primary_button.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:thunderapp/shared/core/navigator.dart';

class DefaultAlertDialog extends StatelessWidget {
  const DefaultAlertDialog({Key? key, required this.title, required this.body, required this.cancelText, required this.onConfirm, required this.confirmText}) : super(key: key);
  final String title;
  final String body;
  final String cancelText;
  final String confirmText;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      title: Text(
        title,
        style: kBody2,
      ),
      content: Text(
        body,
        style: kCaption2,
      ),
      actions: [CustomTextButton(title: cancelText, onPressed: (() => navigatorKey.currentState!.pop())), SizedBox(width: size.width * 0.3, child: PrimaryButton(text: confirmText, onPressed: onConfirm))],
    );
  }
}
