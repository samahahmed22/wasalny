import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String text;

  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPress;

  SubmitButton({
    required this.onPress,
    required this.text,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
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
          primary: backgroundColor,
          minimumSize: Size(110, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}
