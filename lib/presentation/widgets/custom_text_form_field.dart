// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wasalny/styles/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? initialValue;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final Function(String?) onSave;
  final String? Function(String?) validator;
  bool obscureText;
  bool autofocus;

  CustomTextFormField({
    this.label,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    this.controller,
    required this.onSave,
    required this.validator,
    this.obscureText = false,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      autofocus: autofocus,
      style: TextStyle(
        fontSize: 18,
        letterSpacing: 2.0,
      ),
      cursorColor: MyColors.grey,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: MyColors.primaryColor, fontSize: 16),
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
