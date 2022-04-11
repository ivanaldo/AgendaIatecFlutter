import 'package:flutter/material.dart';

class DropDownTipoAgenda{
  static List<DropdownMenuItem<String>> getTipoAgenda(){

    List<DropdownMenuItem<String>> itensDropAgenda = [];

    itensDropAgenda.add(
        const DropdownMenuItem(child: Text("Agenda",
        style: TextStyle(color: Color(0x90000000)
        ),
        ),value: null,)
    );
    itensDropAgenda.add(
      const DropdownMenuItem(child: Text("Exclusivo"), value: "E",)
    );
    itensDropAgenda.add(
      const DropdownMenuItem(child: Text("Compartilhado"), value: "C",)
    );
    return itensDropAgenda;
  }
}