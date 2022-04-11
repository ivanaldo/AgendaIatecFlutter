import 'package:agenda_iatec/views/agenda/proximo_evento.dart';
import 'package:agenda_iatec/views/agenda/evento_em_andamento.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../models/debouncer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  //bool _progresBarLinear;
  bool searchState = false;
  bool retornoMensagem = true;
  int favoritos = 0;
  int valorControllerTab = 0;
  //String valor;
 // List<Anuncio> lista = [];
  final _debouncer = Debouncer(milliseconds: 800);


  @override
  void initState() {
    super.initState();
    //retornarQuantidadeFavoritos();
    //_progresBarLinear = true;
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          valorControllerTab = _tabController.index;
          searchState = false;
          //lista.clear();
          //searchAnuncio();
        });
      }
    });
    //searchAnuncio();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !searchState
            ? const Text("Agenda IATec", style: TextStyle(color: Colors.black),)
            : TextField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.search),
                  hintText: "Search ...",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                onChanged: (text) {
                  _debouncer.run(() {
                    String texto = text.toLowerCase();
                    // searchAnuncio(search: texto);
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
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          EventoEmAndamento(),
          ProximoEvento()
        ],
      ),
    );
  }
}
