import 'package:agenda_iatec/models/agenda_model.dart';
import 'package:agenda_iatec/repositorys/get_repository_agenda.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

final agendaSearch = Modular.get<GetRepositoryAgenda>();

abstract class AgendaEvent{}

class RetornaAgendas extends AgendaEvent{}

class AgendaBloc extends Bloc<AgendaEvent, List<AgendaModel>>{
  AgendaBloc() : super([]){

    on<RetornaAgendas>((event, emit) async{
      List<AgendaModel> _agenda;
      _agenda = await (agendaSearch.getSearchAgenda());
      emit(_agenda);
    });
  }
}