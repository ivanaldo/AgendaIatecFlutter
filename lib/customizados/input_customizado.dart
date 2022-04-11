import 'package:flutter/material.dart';

class InputCustomizado extends StatelessWidget {

  final String hint;
  final bool obscure;
  final icon;
  final TextEditingController controller;

  InputCustomizado(
      {required this.hint,
      this.obscure = false,
      this.icon = const Icon(Icons.person),
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(
          fontSize: 20
      ),
        obscureText: obscure,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            prefixIcon: icon,
            hintText: hint,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0)
            ),
        )
    );
  }
}
