// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wasalny/constants/my_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final TextInputType keyboardType;
  // final TextEditingController controller;
  final Function(String?) onSave;
  final String? Function(String?) validator;
  bool obscureText;
  bool autofocus;

  CustomTextFormField({
    this.label,
    this.keyboardType = TextInputType.text,
    // required this.controller,
    required this.onSave,
    required this.validator,
    this.obscureText = false,
    this.autofocus = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: controller,

      autofocus: autofocus,
      style: TextStyle(
        fontSize: 18,
        letterSpacing: 2.0,
      ),
      cursorColor: MyColors.grey,
      decoration: InputDecoration(
        labelText: label,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: MyColors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: MyColors.grey,
          ),
        ),
      ),
      keyboardType: keyboardType,
      onSaved: onSave,
      validator: validator,
      obscureText: obscureText,
    );
  }
}
