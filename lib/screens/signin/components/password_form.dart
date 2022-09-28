import 'package:flutter/material.dart';

class PasswordForm extends StatelessWidget {
  const PasswordForm({Key? key, required this.onChanged}) : super(key: key);
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(),
      ),
      onChanged: onChanged,
      obscureText: true,
    );
  }
}
