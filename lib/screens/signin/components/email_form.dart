import 'package:flutter/material.dart';

class EmailForm extends StatelessWidget {
  const EmailForm({Key? key, required this.onChanged}) : super(key: key);
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(),
      ),
      onChanged: onChanged,
    );
  }
}
