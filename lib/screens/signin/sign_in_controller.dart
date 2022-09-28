import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thunderapp/screens/screens_index.dart';

import 'sign_in_repository.dart';

enum SignInStatus {
  done,
  error,
  loading,
  idle,
}

class SignInController with ChangeNotifier {
  final SignInRepository _repository = SignInRepository();
  String? email;
  String? password;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? errorMessage;

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  var status = SignInStatus.idle;
  void signIn(BuildContext context) {
    try {
      _repository.signIn(
        email: _emailController.text,
        password: _passwordController.text,
        onSuccess: () {
          status = SignInStatus.done;
          Navigator.pushReplacementNamed(context, Screens.home);
        },
      );
    } catch (e) {
      status = SignInStatus.error;
      setErrorMessage(e.toString());
    }
  }

  void setErrorMessage(String value) {
    errorMessage = value;
    notifyListeners();
    Future.delayed(const Duration(seconds: 2));
    errorMessage = null;
    notifyListeners();
  }
}
