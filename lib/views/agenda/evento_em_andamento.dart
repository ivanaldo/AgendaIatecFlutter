import 'package:agenda_iatec/bloc/agenda_cubit.dart';
import 'package:agenda_iatec/models/agenda_model.dart';
import 'package:flutter/material.dart';



class EventoEmAndamento extends StatefulWidget {
  const EventoEmAndamento({Key? key}) : super(key: key);

  @override
  State<EventoEmAndamento> createState() => _EventoEmAndamentoState();
}

class _EventoEmAndamentoState extends State<EventoEmAndamento> {
  final agenda = AgendaBloc();

  @override
  void initState() {
    super.initState();
    agenda.add(RetornaAgendas());
  }

  @override
  Widget build(BuildContext context) {
    var carregandoDados = Center(
      child: Column(children: const <Widget>[
        Text("Carregando anúncios"),
        CircularProgressIndicator()
      ],),
    );
    return Scaffold(
      body: StreamBuilder<List<AgendaModel>>(
        stream: agenda.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return carregandoDados;
            case ConnectionState.active:
            case ConnectionState.done:
            //Exibe mensagem de erro
              if (snapshot.hasError) {
                return const Text("Erro ao carregar os dados!");
              }
              List<AgendaModel> list = snapshot.data!;

              return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Card(
                        margin: const EdgeInsets.only(
                            top: 4, bottom: 4, right: 8, left: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            list[index].nome,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight:
                                                FontWeight
                                                    .bold),
                                          ),
                                          Text(
                                            list[index].data,
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          const Padding(
                                              padding:
                                              EdgeInsets.only(
                                                  top: 16)),
                                          Text(
                                            list[index].tipo,
                                          ),
                                          Text(list[index].local),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              );
          }
        }
    )
    );
  }
}

