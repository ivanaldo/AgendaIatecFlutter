import 'package:agenda_iatec/models/mensagem.dart';
import 'package:agenda_iatec/repositorys/get_repository_agenda.dart';
import 'package:agenda_iatec/repositorys/get_repository_usuario.dart';
import 'package:agenda_iatec/views/agenda/agendar_evento.dart';
import 'package:agenda_iatec/views/agenda/meus_evento.dart';
import 'package:agenda_iatec/views/autenticacao/cadastro.dart';
import 'package:agenda_iatec/views/autenticacao/login.dart';
import 'package:agenda_iatec/views/home/home.dart';
import 'package:agenda_iatec/views/splash_screen/splash_screen.dart';
import 'package:agenda_iatec/views/usuario/perfil.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module{
  @override
  List<Bind> get binds => [
    Bind.singleton((i) => Dio()),
    Bind.singleton((i) => Mensagens()),
    Bind.singleton<SearchDataSourceUsuario>((i) => GetRepositoryUsuario()),
    Bind.singleton<SearchDataSourceAgenda>((i) => GetRepositoryAgenda()),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const SplashScreen()),
    ChildRoute('/Login', child: (context, arg) => const Login()),
    ChildRoute('/Cadastro', child: (context, arg) => const Cadastro()),
    ChildRoute('/Home', child: (context, args) => const Home()),
    ChildRoute('/Perfil', child: (context, args) => const Perfil()),
    ChildRoute('/AgendarEvento', child: (context, args) => const AgendarEvento()),
    ChildRoute('/MeusEventos', child: (context, args) => const MeusEvento())
  ];
}