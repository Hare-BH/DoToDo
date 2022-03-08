import 'package:flutter/material.dart';

class SoftButton extends StatelessWidget {
  SoftButton(
      {required this.isPressed, required this.icon, this.color = Colors.white});

  final bool isPressed;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isPressed
              ? [
                  BoxShadow(
                    color: Colors.grey.shade700,
                    offset: const Offset(2, 2),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Colors.deepOrange.shade500,
                    offset: Offset(-2, -2),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ]
              : null),
      duration: const Duration(milliseconds: 200),
      child: Icon(
        icon,
        size: 30.0,
        color: color,
      ),
    );
  }
}
