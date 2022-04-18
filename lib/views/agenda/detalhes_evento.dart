import 'package:agenda_iatec/models/agenda_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetalhesEvento extends StatefulWidget {
  AgendaModel list;
 DetalhesEvento(this.list);

  @override
  State<DetalhesEvento> createState() => _DetalhesEventoState();
}

class _DetalhesEventoState extends State<DetalhesEvento> {

  @override
  Widget build(BuildContext context) {

    var dateTime = DateTime.parse(widget.list.data);
    var dataFormatada = DateFormat("dd/MM/yyyy");
    var data = dataFormatada.format(dateTime);

    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              const Padding(padding: EdgeInsets.only(top: 2)),
              Container(
                padding: const EdgeInsets.only(top: 16, right: 16, left: 16,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.list.nome,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 8)),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            data,
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            const Text("Horas:"),
                            Text(widget.list.hora),
                          ],
                        )
                      ],
                    ),
                    const Divider(),
                    const Text(
                      "Descrição:",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      widget.list.descricao,
                      style: const TextStyle(
                          fontSize: 18
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Divider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            const Text(
                              "Tipo",
                              style: TextStyle(
                                fontSize: 14,
                                //fontWeight: FontWeight.bold
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                widget.list.tipo,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const Text("Participantes"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
