import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final Function() onTap;
  final IconData icon;

  MenuButton({required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 44,
      left: 20,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5.0,
                    spreadRadius: 0.5,
                    offset: Offset(
                      0.7,
                      0.7,
                    ))
              ]),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: Icon(
              icon,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
