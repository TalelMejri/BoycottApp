import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Color color;
  const AuthButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.color});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 60,
      onPressed: onPressed,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.white
        ),
      ),
    );
  }
}