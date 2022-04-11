import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Mensagens {

  mensagemSucess (){
    Fluttertoast.showToast(
        msg: "Cadastro salvo com sucesso!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 20.0
    );
  }

  mensagemAtualizar (){
    Fluttertoast.showToast(
        msg: "Atualizado com sucesso!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 20.0
    );
  }

  mensagemDeletar (){
    Fluttertoast.showToast(
        msg: "Conta deletada com sucesso!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 20.0
    );
  }

  mensagemPreencha (String campo){
    Fluttertoast.showToast(
        msg: "Preencha o campo $campo!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 20.0
    );
  }

  mensagemEmailExiste (){
    Fluttertoast.showToast(
        msg: "Esse email já foi cadastrado, tente outro email!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 20.0
    );
  }

  mensagemErroLogin (){
    Fluttertoast.showToast(
        msg: "Confira seus dados ou sua internet!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 20.0
    );
  }

  abrirDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                Text("Salvando anúncio...")
              ],
            ),
          );
        });
  }
}
