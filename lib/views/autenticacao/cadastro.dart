import 'package:agenda_iatec/customizados/input_button_customizados.dart';
import 'package:agenda_iatec/customizados/input_customizado.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  TextEditingController controller = TextEditingController();

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
                      controller: controller,
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
                            child: InputCustomizado(
                              hint: "Nascimento",
                              controller: controller,
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
                                padding: const EdgeInsets.only(top: 8, right: 16, left: 6),
                                child: InputCustomizado(
                                  hint: "Sexo",
                                  controller: controller,
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
                    child: InputCustomizado(
                      hint: "Email",
                      controller: controller,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
                    child: InputCustomizado(
                      hint: "Senha",
                      controller: controller,
                      obscure: true,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                      child:  InputButtonCustomizado(
                        text: "Cadastrar",
                        onPressed: (){

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
