import 'package:agenda_iatec/bloc/agenda_cubit.dart';
import 'package:agenda_iatec/models/agenda_model.dart';
import 'package:agenda_iatec/views/agenda/detalhes_evento.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../models/debouncer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  bool searchState = false;
  int valorControllerTab = 0;
  final _debouncer = Debouncer(milliseconds: 800);
  final agenda = AgendaBloc();

  searchAgendas(String texto){
    setState(() {
      AgendaModel.search = texto;
      AgendaModel.tabController = valorControllerTab;
    });
      agenda.add(RetornaAgendasSearch());
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          valorControllerTab = _tabController.index;
          searchState = false;
          if(valorControllerTab == 0){
            agenda.add(RetornaAgendasAndamento());
          }else{
            agenda.add(RetornaAgendasProximo());
          }
        });
      }
    });
    agenda.add(RetornaAgendasAndamento());
  }

  @override
  void dispose() async{
    super.dispose();
    _tabController.dispose();
    await agenda.close();
  }

  @override
  Widget build(BuildContext context) {
    var carregandoDados = Center(
      child: Column(children: const <Widget>[
        Text("Carregando agenda"),
        CircularProgressIndicator()
      ],),
    );
    return Scaffold(
      appBar: AppBar(
        title: !searchState
            ? const Text("Agenda IATec", style: TextStyle(color: Colors.black),)
            : TextField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.search),
                  hintText: "Search ...",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                onChanged: (text) {
                  _debouncer.run(() {
                    String texto = text.toLowerCase();
                    searchAgendas(texto);
                  });
                },
              ),
        centerTitle: true,
        backgroundColor: Colors.transparent, //Colors.grey[100],
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
            systemStatusBarContrastEnforced: false
        ),
        bottom: TabBar(
          indicatorWeight: 4,
          labelStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal
          ),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          controller: _tabController,
          indicatorColor: const Color(0xff305d92),
          tabs: const <Widget>[
            Tab(
              text: "Em Andamento",
            ),
            Tab(
              text: "Próximos Eventos",
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: !searchState
                ? IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        searchState = !searchState;
                      });
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        searchState = !searchState;
                        AgendaModel.search = "";
                        agenda.add(RetornaAgendasSearch());
                      });
                    },
                  ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
             DrawerHeader(
              child: Image.asset("imagens/iatec_logo.png"),
            ),
            const Divider(),
            ListTile(
              title: const Text("Perfil"),
              leading: const Icon(Icons.account_circle),
              onTap: (){
                Modular.to.pushNamed('Perfil');
              },
            ),
            ListTile(
              title: const Text("Agendar Evento"),
              leading: const Icon(Icons.date_range),
              onTap: (){
                Modular.to.pushNamed('AgendarEvento');
              },
            ),
            ListTile(
              title: const Text("Meus Eventos"),
              leading: const Icon(Icons.calendar_today_rounded),
              onTap: (){
                Modular.to.pushNamed('MeusEventos');
              },
            ), ListTile(
              title: const Text("Sair"),
              leading: const Icon(Icons.close),
              onTap: (){
                Modular.to.navigate("/Login");
              },
            )
          ],
        ),
      ),
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

                      var dateTime = DateTime.parse(list[index].data);
                      var dataFormatada = DateFormat("dd/MM/yyyy");
                      var data = dataFormatada.format(dateTime);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetalhesEvento(list[index])));
                        },
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
                                                  fontSize: 20,
                                                  fontWeight:
                                                  FontWeight
                                                      .bold),
                                            ),
                                            Text(
                                              data,
                                              style: const TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            const Padding(
                                                padding:
                                                EdgeInsets.only(
                                                    top: 16)),
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
      ),
    );
  }
}
