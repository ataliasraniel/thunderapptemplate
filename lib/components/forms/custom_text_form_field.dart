import 'package:flutter/material.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({Key? key, this.label, this.controller, this.keyboardType, this.hintText, this.isPassword, this.icon}) : super(key: key);
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? isPassword;
  final IconData? icon;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = false;
  @override
  void initState() {
    if (widget.isPassword != null) {
      _obscureText = widget.isPassword!;
    }
    super.initState();
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        obscureText: _obscureText,
        controller: widget.controller,
        decoration: InputDecoration(
          prefixIcon: widget.icon == null ? null : Icon(widget.icon),
          labelText: widget.label,
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hintText,
          suffixIcon: widget.isPassword == true
              ? InkWell(
                  onTap: () => _toggleVisibility(),
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
