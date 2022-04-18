import 'package:agenda_iatec/configuracoes_dropdown/dropdown_sexo_usuario.dart';
import 'package:agenda_iatec/customizados/data_customizada.dart';
import 'package:agenda_iatec/customizados/input_button_customizados.dart';
import 'package:agenda_iatec/customizados/input_customizado.dart';
import 'package:agenda_iatec/customizados/input_dropdown_button_sexo.dart';
import 'package:agenda_iatec/models/mensagem.dart';
import 'package:agenda_iatec/models/usuario_model.dart';
import 'package:agenda_iatec/repositorys/get_repository_usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  List<DropdownMenuItem<String>> _listaItensDropSexo = [];
  TextEditingController controllerNome       = TextEditingController();
  TextEditingController controllerNascimento = TextEditingController();
  TextEditingController controllerEmail      = TextEditingController();
  TextEditingController controllerSenha      = TextEditingController();
  late BuildContext _dialogContext;
  String? _sexoSelecionado;
  final mensagem = Modular.get<Mensagens>();
  final perfilUsuario = Modular.get<GetRepositoryUsuario>();

  cadastraUsuario() async{

    String nome = controllerNome.text.trim();
    String nascimento = controllerNascimento.text.trim().replaceAll("/", "-");
    String? genero = _sexoSelecionado;
    String email = controllerEmail.text.trim();
    String senha = controllerSenha.text.trim();

    if(nome.isNotEmpty && nome.length >= 5){
      if(nascimento.isNotEmpty && nascimento.length >= 10){
        if(genero != null){
          if(email.isNotEmpty && email.contains("@")){
            if(senha.isNotEmpty && senha.length >= 6){

              var emailExiste = await perfilUsuario.getSearchEmailExiste(email);

              if(emailExiste == false){
                try{
                  mensagem.abrirDialog(_dialogContext);

                  var usuario = UsuarioModel( nome: nome, email: email, senha: senha, datanascimento: nascimento, genero: genero);
                  UsuarioModel valor = await perfilUsuario.createUsuario(usuario);
                  if(valor.nome.isNotEmpty){
                    Navigator.pop(_dialogContext);
                    mensagem.mensagemSucess();
                  }
                }catch(e){
                  Exception(e);
                }
              }else{
                mensagem.mensagemExiste();
              }

            }else{
              mensagem.mensagemPreencha("senha com 6 ou mais caracteres");
            }
          }else{
            mensagem.mensagemPreencha("email válido");
          }
        }else{
          mensagem.mensagemPreencha("sexo");
        }
      }else{
        mensagem.mensagemPreencha("data de nascimento");
      }
    }else{
      mensagem.mensagemPreencha("nome, com mais de 5 caracteres");
    }
  }

  @override
  void dispose() {
    super.dispose();
    controllerNome.dispose();
    controllerNascimento.dispose();
    controllerSenha.dispose();
    controllerEmail.dispose();
  }

  @override
  void initState() {
    super.initState();
    _listaItensDropSexo = DropDownSexoUsuario.getSexoGenetico();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agenda IATec", style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.transparent, //Colors.grey[100],
        elevation: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
            systemStatusBarContrastEnforced: false
        ),
      ),
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
                    alignment: Alignment.center,
                    child: const Text("Faça seu Cadastro", style: TextStyle(fontSize: 20, color: Colors.black),),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
                    child: InputCustomizado(
                      hint: "Nome",
                      controller: controllerNome,
                    ),
                  ),
                  Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                          child: Column(
                          children: [
                           Container(
                            padding: const EdgeInsets.only(top: 8, left: 16),
                            child: DataCustomizada(
                              hint: "Nascimento",
                              controller: controllerNascimento,
                              icon: const Icon(Icons.date_range),
                            ),
                          ),
                        ],
                      )
                      ),
                      Expanded(
                        flex: 2,
                          child: Column(
                            children: [
                           Container(
                          padding: const EdgeInsets.only(top: 8, right: 6, left: 16),
                              child: InputDropdownButton(
                                items: _listaItensDropSexo,
                                value: _sexoSelecionado,
                                onChanged: (valor) {
                                  setState(() {
                                    _sexoSelecionado = valor!;
                                  });
                                },
                              ),
                            )
                            ],
                          )
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
                    child: InputCustomizado(
                      hint: "Email",
                      controller: controllerEmail,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
                    child: InputCustomizado(
                      hint: "Senha",
                      controller: controllerSenha,
                      obscure: true,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                      child:  InputButtonCustomizado(
                        text: "Cadastrar",
                        onPressed: (){
                          _dialogContext = context;
                            cadastraUsuario();
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
