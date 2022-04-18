import 'package:agenda_iatec/models/agenda_model.dart';
import 'package:agenda_iatec/repositorys/get_repository_agenda.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

final _agendaSearch = Modular.get<GetRepositoryAgenda>();

abstract class AgendaEventAndamento{}

class RetornaAgendasAndamento extends AgendaEventAndamento{}

class RetornaAgendasProximo extends AgendaEventAndamento{}

class RetornaAgendasSearch extends AgendaEventAndamento{}

class AgendaBloc extends Bloc<AgendaEventAndamento, List<AgendaModel>>{
  AgendaBloc() : super([]){

    var dateTime = DateTime.now();
    var dataFormatada = DateFormat("yyyy-MM-dd");
    var data = dataFormatada.format(dateTime);

    on<RetornaAgendasAndamento>((event, emit) async{
      List<AgendaModel> _agenda;
      _agenda = await (_agendaSearch.getSearchAgendaAndamento(data));
      emit(_agenda);
    });

    on<RetornaAgendasProximo>((event, emit) async{
      List<AgendaModel> _agenda;
      _agenda = await (_agendaSearch.getSearchAgendaProxima(data));
      emit(_agenda);
    });

    on<RetornaAgendasSearch>((event, emit) async{
      List<AgendaModel> _agenda;
      _agenda = await (_agendaSearch.getSearchAgendaSearch(data));
      emit(_agenda);
    });
  }
}