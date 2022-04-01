import 'package:agenda_iatec/customizados/input_button_customizados.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../customizados/input_customizado.dart';

class AgendarEvento extends StatefulWidget {
  const AgendarEvento({Key? key}) : super(key: key);

  @override
  State<AgendarEvento> createState() => _AgendarEventoState();
}

class _AgendarEventoState extends State<AgendarEvento> {
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
                    child: const Text("Agendar Novo Evento", style: TextStyle(fontSize: 20, color: Colors.black),),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                    child: InputCustomizado(
                      hint: "Nome do evento",
                      controller: controller,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 8, left: 16),
                                child: InputCustomizado(
                                  hint: "Data",
                                  controller: controller,
                                  icon: const Icon(Icons.date_range),
                                ),
                              ),
                            ],
                          )
                      ),
                      Expanded(
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 8, right: 16, left: 6),
                                child: InputCustomizado(
                                  hint: "Tipo",
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
                      hint: "Local",
                      controller: controller,
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
                        decoration: InputDecoration(
                          labelText: "Descrição",
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

