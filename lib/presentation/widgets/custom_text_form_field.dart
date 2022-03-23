import 'package:flutter/material.dart';

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
      autofocus: true,
      style: TextStyle(
        fontSize: 18,
        letterSpacing: 2.0,
      ),
      decoration: InputDecoration(border: InputBorder.none),
      
    
      keyboardType: keyboardType,
      onSaved: onSave,
      validator: validator,
      obscureText: obscureText,
    );
  }
}
