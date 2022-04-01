import 'package:flutter/material.dart';

class InputButtonCustomizado extends StatelessWidget {

  final String text;
  final onPressed;
  final primary;

  InputButtonCustomizado(
      {required this.text,
      this.onPressed,
      this.primary = const Color(0xff305d92)});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(text,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
          ),
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
          primary: primary),
          onPressed: onPressed,
    );
  }
}
