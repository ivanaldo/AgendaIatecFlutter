import 'package:agenda_iatec/models/mensagem.dart';
import 'package:agenda_iatec/models/usuario_model.dart';
import 'package:agenda_iatec/repositorys/get_repository_usuario.dart';
import 'package:agenda_iatec/customizados/input_button_customizados.dart';
import 'package:agenda_iatec/customizados/input_customizado.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();

  _validarUsuario() async {
    final perfilUsuario = Modular.get<GetRepositoryUsuario>();
    final prefs = await SharedPreferences.getInstance();
    final mensagem = Modular.get<Mensagens>();

    String email = controllerEmail.text.trim();
    String senha = controllerSenha.text.trim();

    if(email.isNotEmpty && email.contains("@")){
      if(senha.isNotEmpty && senha.length >= 6){

        try{
          UsuarioModel usuarioModel = await perfilUsuario.getSearchLogin( email, senha);
          await prefs.setString('idPerfilUsuario', usuarioModel.id.toString());
          Modular.to.navigate('/Home');
        }catch(e){
          Exception(e);
        }

      }else{
        mensagem.mensagemPreencha("senha com 6 ou mais caracteres");
      }
    }else{
      mensagem.mensagemPreencha("email válido");
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
                          Modular.to.pushNamed('/Cadastro');
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
