import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';
import 'package:thunderapp/shared/core/db/firestore_db_manager.dart';
import 'package:thunderapp/shared/core/toast/app_notification_manager.dart';

class SignUpScreenController with ChangeNotifier {
  var screenState = ScreenState.idle;
  final FirestoreDatabaseManager _databaseManager = FirestoreDatabaseManager();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  TextEditingController get emailTextEditingController => _emailTextEditingController;
  TextEditingController get passwordTextEditingController => _passwordTextEditingController;
  int _stepIndex = 0;
  final int _maxSteps = 3;
  int get stepIndex => _stepIndex + 1;
  int get maxSteps => _maxSteps;

  void nextStep() {
    _stepIndex++;
    notifyListeners();
  }

  void finishSignUp() async {
    try {
      screenState = ScreenState.loading;
      notifyListeners();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailTextEditingController.text, password: _passwordTextEditingController.text).then((value) {
        log('User successfuly created. Creating user store...');
        _databaseManager.createUserInDB(value.user!.email!);
        AppSnackbarManager.showSimpleNotification(NotificationType.success, 'Bem-vindo ao iEgg!');
        _stepIndex++;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AppSnackbarManager.showSimpleNotification(NotificationType.error, 'Eita, sua senha está muito fraca. =(');
      } else if (e.code == 'email-already-in-use') {
        AppSnackbarManager.showSimpleNotification(NotificationType.error, 'Esse email já está sendo usado =(');
        // print('The account already exists for that email.');
      }
      screenState = ScreenState.idle;
      notifyListeners();
    } catch (e) {
      screenState = ScreenState.idle;
      notifyListeners();
      AppSnackbarManager.showSimpleNotification(NotificationType.error, e.toString());
      return Future.error('Deu merda meno');
    }
  }
}
