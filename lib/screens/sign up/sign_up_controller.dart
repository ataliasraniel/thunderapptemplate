import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';

class SignUpController with ChangeNotifier {
  int _infoIndex = 0;
  ScreenState screenState = ScreenState.idle;

  String? _errorMessage = '';
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();

  TextEditingController get emailController =>
      _emailController;
  TextEditingController get passwordController =>
      _passwordController;
  String? get errorMessage => _errorMessage;
  int get infoIndex => _infoIndex;

  void next() {
    _infoIndex++;
    notifyListeners();
  }

  void back() {
    _infoIndex--;
    notifyListeners();
  }
}
