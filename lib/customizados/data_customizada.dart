import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DataCustomizada extends StatelessWidget{
   final String hint;
   final bool obscure;
   final icon;
   final TextEditingController controller;

  const DataCustomizada(
      {required this.hint,
        this.obscure = false,
        this.icon = const Icon(Icons.person),
        required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: TextInputType.datetime,
      style: const TextStyle(fontSize: 20),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        DataInputFormatter(),
      ],
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
          fillColor: Colors.white,
          prefixIcon: icon,
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0)
          )
      ),
    );
  }
}