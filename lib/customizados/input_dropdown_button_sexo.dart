import 'package:flutter/material.dart';

class InputDropdownButton extends StatelessWidget {

  final String? value;
  final List<DropdownMenuItem<String>> items;
  final onChanged;


  const InputDropdownButton({
    required this.value,
    required this.items,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isExpanded: true,
      decoration: InputDecoration(
          contentPadding:
          const EdgeInsets.fromLTRB(16, 16, 16, 16),
          fillColor: Colors.transparent,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25))),
      value: value,
      items: items,
      onChanged: onChanged
    );
  }
}
