import 'package:flutter/material.dart';

class DropDownSexoUsuario {

  //Categorias
  static List<DropdownMenuItem<String>> getSexoGenetico(){

    List<DropdownMenuItem<String>> itensDropSexo = [];

    itensDropSexo.add(
        const DropdownMenuItem(child: Text(
            "Sexo", style: TextStyle(
          color: Color(0x90000000)
        ),
        ), value: null,)
    );

    itensDropSexo.add(
        const DropdownMenuItem(child: Text("Masculino"), value: "M",)
    );

    itensDropSexo.add(
        const DropdownMenuItem(child: Text("Feminino"), value: "F",)
    );
    return itensDropSexo;
  }
}