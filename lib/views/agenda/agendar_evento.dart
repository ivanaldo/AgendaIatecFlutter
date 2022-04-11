import 'package:agenda_iatec/customizados/input_button_customizados.dart';
import 'package:agenda_iatec/models/agenda_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../configuracoes_dropdown/dropdown_tipo_agenda.dart';
import '../../customizados/data_customizada.dart';
import '../../customizados/input_customizado.dart';
import '../../customizados/input_dropdown_button_sexo.dart';
import '../../models/mensagem.dart';
import '../../repositorys/get_repository_agenda.dart';
import '../../repositorys/get_repository_usuario.dart';

class AgendarEvento extends StatefulWidget {
  const AgendarEvento({Key? key}) : super(key: key);

  @override
  State<AgendarEvento> createState() => _AgendarEventoState();
}

class _AgendarEventoState extends State<AgendarEvento> {
  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerData = TextEditingController();
  TextEditingController controllerLocal = TextEditingController();
  TextEditingController controllerDescricao = TextEditingController();
  List<DropdownMenuItem<String>> _listaItensDropAgenda = [];
  String? _tipoAgendaSelecionado;
  late BuildContext _dialogContext;
  final mensagem = Modular.get<Mensagens>();
  final perfilUsuario = Modular.get<GetRepositoryAgenda>();

  cadastraAgenda() async{

    String nome = controllerNome.text.trim();
    String data = controllerData.text.trim().replaceAll("/", "-");
    String? tipo = _tipoAgendaSelecionado;
    String local = controllerLocal.text.trim();
    String descricao = controllerDescricao.text.trim();

    if(nome.isNotEmpty && nome.length >= 5){
      if(data.isNotEmpty && data.length >= 10){
        if(tipo != null){
          if(local.isNotEmpty && local.length <= 100){
            if(descricao.isNotEmpty && descricao.length <= 250){

              var emailExiste = await perfilUsuario.getSearchEmailExiste(tipo, data);

              if(emailExiste == false){
                try{
                  mensagem.abrirDialog(_dialogContext);

                  var agenda = AgendaModel(nome: nome, tipo: tipo, descricao: descricao, data: data, local: local);
                  AgendaModel valor = await perfilUsuario.createUsuario(usuario);
                  if(valor.nome.isNotEmpty){
                    Navigator.pop(_dialogContext);
                    mensagem.mensagemSucess();
                  }
                }catch(e){
                  Exception(e);
                }
              }else{
                mensagem.mensagemEmailExiste();
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
    controllerData.dispose();
    controllerLocal.dispose();
    controllerDescricao.dispose();
  }

  @override
  void initState() {
    super.initState();
    _listaItensDropAgenda = DropDownTipoAgenda.getTipoAgenda();
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
                    child: const Text("Agendar Novo Evento", style: TextStyle(fontSize: 20, color: Colors.black),),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                    child: InputCustomizado(
                      hint: "Nome do evento",
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
                                  hint: "Data",
                                  controller: controllerData,
                                  icon: const Icon(Icons.date_range),
                                ),
                              ),
                            ],
                          )
                      ),
                      Expanded(
                        flex: 3,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 8, right: 16, left: 6),
                                child: InputDropdownButton(
                                  items: _listaItensDropAgenda,
                                  value: _tipoAgendaSelecionado,
                                  onChanged: (valor) {
                                    setState(() {
                                      _tipoAgendaSelecionado = valor!;
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
                      hint: "Local",
                      controller: controllerLocal,
                      icon: const Icon(Icons.add_location),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
                    child: TextField(
                        style: const TextStyle(
                            fontSize: 20
                        ),
                        maxLines: 5,
                        maxLength: 250,
                        controller: controllerDescricao,
                        decoration: InputDecoration(
                          hintText: "Descrição",
                          alignLabelWithHint: true,
                          contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                          //prefixIcon: icon,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0)
                          ),
                        )
                    )
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
                      child: TextField(
                          style: const TextStyle(
                              fontSize: 20
                          ),
                          decoration: InputDecoration(
                            labelText: "Participantes",
                            alignLabelWithHint: true,
                            contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                            //prefixIcon: icon,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0)
                            ),
                          )
                      )
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                      child:  InputButtonCustomizado(
                        text: "Agendar evento",
                        onPressed: (){

                        },
                      )
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}

