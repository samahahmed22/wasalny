import 'package:flutter/material.dart';
import 'package:wasalny/styles/colors.dart';

class SubmitButton extends StatelessWidget {
  final String text;

  final VoidCallback onPress;

  SubmitButton({
    required this.onPress,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: onPress,
        child: Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(110, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}
