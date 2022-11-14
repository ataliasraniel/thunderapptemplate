import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';
import 'package:thunderapp/shared/core/navigator.dart';
import 'package:thunderapp/shared/core/toast/app_notification_manager.dart';
import 'sign_in_repository.dart';

enum SignInStatus {
  done,
  error,
  loading,
  idle,
}

class SignInController with ChangeNotifier {
  // final _auth = FirebaseAuth.instance;
  final SignInRepository _repository = SignInRepository();
  String? email;
  String? password;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? errorMessage;

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  var status = SignInStatus.idle;

  Future signInAnonimously() async {
    status = SignInStatus.loading;
    FirebaseAuth.instance.signInAnonymously().then((value) => navigatorKey.currentState!.pushReplacementNamed(Screens.home)).catchError((e) {
      setErrorMessage(e);
    });
    notifyListeners();
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn().catchError((e) {
      log('Bad: $e');
    });

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    log(googleAuth.toString());
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth!.accessToken,
      idToken: googleAuth.idToken,
    );
    if (credential.accessToken != null) {
      AppSnackbarManager.showSimpleNotification(NotificationType.success, 'Tudo certo. Bem-vindo ao iEgg');
    }
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      navigatorKey.currentState!.pushReplacementNamed(Screens.home);
      return value;
    });
  }

  void signIn(BuildContext context) async {
    try {
      status = SignInStatus.loading;
      notifyListeners();
      await _repository.signIn(
        email: _emailController.text,
        password: _passwordController.text,
        onSuccess: () {
          status = SignInStatus.done;
          Navigator.pushReplacementNamed(context, Screens.home);
        },
      );
    } catch (e) {
      status = SignInStatus.idle;
      notifyListeners();
      setErrorMessage(e.toString());
    }
  }

  void setErrorMessage(String value) async {
    errorMessage = value;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 5));
    errorMessage = null;
    notifyListeners();
  }
}
