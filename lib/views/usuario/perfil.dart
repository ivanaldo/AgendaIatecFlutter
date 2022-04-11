import 'package:agenda_iatec/bloc/perfil_cubit.dart';
import 'package:agenda_iatec/customizados/data_customizada.dart';
import 'package:agenda_iatec/models/mensagem.dart';
import 'package:agenda_iatec/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../customizados/input_button_customizados.dart';
import '../../customizados/input_customizado.dart';
import '../../repositorys/get_repository_usuario.dart';


class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerData = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();
  final mensagem = Modular.get<Mensagens>();
  late BuildContext _dialogContext;
  String? sexoSelecionado;
  late String hintGenero;

  final perfil = PerfilBloc();
  var atualizarPerfil = Modular.get<GetRepositoryUsuario>();


  atualizarUsuario() async{

    final prefs = await SharedPreferences.getInstance();
    final String? id = prefs.getString('idPerfilUsuario');

    mensagem.abrirDialog(_dialogContext);

    String nome = controllerNome.text.trim();
    String data = controllerData.text.trim().replaceAll("/", "-");
    String genero = sexoSelecionado ?? hintGenero;
    String email = controllerEmail.text.trim();
    String senha = controllerSenha.text.trim();

    var usuario = UsuarioModel(nome: nome, email: email, senha: senha, datanascimento: data, genero: genero);

    bool valor = await atualizarPerfil.updateUsuario(id, usuario);
    if(valor == true){
      Navigator.pop(_dialogContext);
      mensagem.mensagemAtualizar();
      perfil.add(RetornaUsuario());
    }
  }

  deletarUsuario() async{
    mensagem.abrirDialog(_dialogContext);

    final prefs = await SharedPreferences.getInstance();
    final String? id = prefs.getString('idPerfilUsuario');

    bool valor = await atualizarPerfil.deleteUsuario(id);
    if(valor == true){
      Navigator.pop(_dialogContext);
      mensagem.mensagemDeletar();
      Modular.to.navigate('/Login');
    }
  }

  @override
  void dispose() {
    super.dispose();
    controllerNome.dispose();
    controllerData.dispose();
    controllerEmail.dispose();
    controllerSenha.dispose();
  }

  @override
  void initState() {
    super.initState();
    perfil.add(RetornaUsuario());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Agenda IATec",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          //Colors.grey[100],
          elevation: 0.0,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.dark,
              systemStatusBarContrastEnforced: false),
        ),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: StreamBuilder(
                stream: perfil.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Erro ao carregar dados!"),
                    );
                  } else if (snapshot.connectionState == ConnectionState.active) {
                    final state = perfil.state;

                    var dateTime = DateTime.parse(state.datanascimento);
                    var dataFormatada = DateFormat("dd/MM/yyyy");
                    var data = dataFormatada.format(dateTime);

                    controllerNome.text  = state.nome;
                    controllerData.text  = data;
                    controllerEmail.text = state.email;
                    controllerSenha.text = state.senha;


                    switch(state.genero){
                      case "M":
                          hintGenero = "Masculino";
                      break;
                      case "F":
                          hintGenero = "Feminino";
                      break;
                    }
                    return Center(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: const Text(
                                "Perfil",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.only(top: 10, right: 16, left: 22),
                              child: Text("Nome"),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 8, right: 16, left: 16),
                              child: InputCustomizado(
                                hint: state.nome,
                                controller: controllerNome,
                                icon: const Icon(Icons.account_circle),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, right: 16, left: 22),
                                          child: Text("Data de nascimento"),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              top: 8, left: 16),
                                          child: DataCustomizada(
                                            hint: data,
                                            controller: controllerData,
                                            icon: const Icon(Icons.date_range),
                                          ),
                                        ),
                                      ],
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, right: 16, left: 22),
                                          child: Text("Gênero"),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              top: 8, right: 16, left: 6),
                                          child: DropdownButtonFormField(
                                            value: sexoSelecionado,
                                            hint: Text(hintGenero),
                                            items: <String>['Masculino', 'Feminino']
                                                .map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (String? valor) {
                                              setState(() {
                                                sexoSelecionado = valor!;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                contentPadding:
                                                const EdgeInsets.fromLTRB(16, 16, 16, 16),
                                                fillColor: Colors.transparent,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(25))),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.only(top: 10, right: 16, left: 22),
                              child: Text("Email"),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 4, right: 16, left: 16),
                              child: InputCustomizado(
                                hint: state.email,
                                controller: controllerEmail,
                                icon: const Icon(Icons.email),
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.only(top: 10, right: 16, left: 22),
                              child: Text("Senha"),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 8, right: 16, left: 16),
                              child: InputCustomizado(
                                hint: state.senha,
                                controller: controllerSenha,
                                icon: const Icon(Icons.lock),
                                obscure: false,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 16, right: 16, left: 16),
                                child: InputButtonCustomizado(
                                  text: "Atualizar",
                                  onPressed: () {
                                    _dialogContext = context;
                                    atualizarUsuario();
                                  },
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 16, right: 16, left: 16),
                                child: InputButtonCustomizado(
                                  text: "Deletar",
                                  primary: Colors.red,
                                  onPressed: () {
                                    _dialogContext = context;
                                    deletarUsuario();
                                  },
                                ))
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })));
  }
}

/*
 ListView.builder(
                  itemCount: perfil.state.length,
                  itemBuilder: (BuildContext context, int index){
                    return Center(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: const Text("Perfil", style: TextStyle(fontSize: 20, color: Colors.black),),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10, right: 16, left: 22),
                              child: Text("Nome"),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
                              child: InputCustomizado(
                                hint: perfil.state[index].nome,
                                controller: controllerNome,
                                icon: const Icon(Icons.account_circle),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(top: 10, right: 16, left: 22),
                                          child: Text("Data de nascimento"),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(top: 8, left: 16),
                                          child: InputCustomizado(
                                            hint: perfil.state[index].datanascimento,
                                            controller: controllerData,
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
                                        const Padding(
                                          padding: EdgeInsets.only(top: 10, right: 16, left: 22),
                                          child: Text("Gênero"),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(top: 8, right: 16, left: 6),
                                          child: InputCustomizado(
                                            hint: perfil.state[index].genero,
                                            controller: controllerGenero,
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10, right: 16, left: 22),
                              child: Text("Email"),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 4, right: 16, left: 16),
                              child: InputCustomizado(
                                hint: perfil.state[index].email,
                                controller: controllerEmail,
                                icon: const Icon(Icons.email),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10, right: 16, left: 22),
                              child: Text("Senha"),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
                              child: InputCustomizado(
                                hint: perfil.state[index].senha,
                                controller: controllerSenha,
                                icon: const Icon(Icons.lock),
                                obscure: true,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                                child:  InputButtonCustomizado(
                                  text: "Atualizar",
                                  onPressed: (){

                                  },
                                )
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                                child:  InputButtonCustomizado(
                                  text: "Deletar",
                                  primary: Colors.red,
                                  onPressed: (){

                                  },
                                )
                            )
                          ],
                        ),
                      ),
                    );
                  }
              )
 */