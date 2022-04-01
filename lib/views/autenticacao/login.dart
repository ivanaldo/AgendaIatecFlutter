import 'package:agenda_iatec/views/autenticacao/cadastro.dart';
import 'package:agenda_iatec/customizados/input_button_customizados.dart';
import 'package:agenda_iatec/customizados/input_customizado.dart';
import 'package:agenda_iatec/views/home/home.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();

  _validarUsuario(){
    String email = controllerEmail.text.trim();
    String senha = controllerSenha.text.trim();

    if(email == "ivanaldogc@gmail.com" && senha == "1234"){
      Future.delayed(const Duration(seconds: 2)).then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                  child: Image.asset("imagens/iatec_logo.png", width: 180, height: 180),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 16, left: 46),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Ainda não tem conta?"),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const Cadastro()));
                        },
                        child: const Text("Cadastre-se aqui!",
                            style: TextStyle(color: Colors.blueAccent)
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
                  child: InputCustomizado(
                    hint: "Email",
                    controller: controllerEmail,
                    icon: const Icon(Icons.local_post_office_outlined),
                    obscure: false,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
                  child: InputCustomizado(
                    hint: "Senha",
                    controller: controllerSenha,
                    icon: const Icon(Icons.lock),
                    obscure: true,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                    child:  InputButtonCustomizado(
                      text: "Login",
                      onPressed: (){
                        _validarUsuario();
                      },
                    )
                )
              ],
            ),
          ),
        ),
      )

    );
  }
}
