// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wasalny/core/utils/app_colors.dart';

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
      cursorColor: AppColors.grey,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.primary, fontSize: 16),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: AppColors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: AppColors.grey,
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
