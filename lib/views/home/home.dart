import 'package:agenda_iatec/views/agenda/agendar_evento.dart';
import 'package:agenda_iatec/views/agenda/meus_evento.dart';
import 'package:agenda_iatec/views/agenda/proximo_evento.dart';
import 'package:agenda_iatec/views/agenda/evento_em_andamento.dart';
import 'package:agenda_iatec/views/usuario/perfil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: const Text("Agenda IATec", style: TextStyle(color: Colors.black),),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Perfil()));
              },
            ),
            ListTile(
              title: const Text("Agendar Evento"),
              leading: const Icon(Icons.date_range),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AgendarEvento()));
              },
            ),
            ListTile(
              title: const Text("Meus Eventos"),
              leading: const Icon(Icons.calendar_today_rounded),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MeusEvento()));
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
