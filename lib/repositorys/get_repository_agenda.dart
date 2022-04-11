import 'package:agenda_iatec/models/agenda_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/mensagem.dart';

abstract class SearchDataSourceAgenda {
  Future<AgendaModel> getSearchAgenal();
  Future<bool> getSearchTipoAgendaExiste( String tipo, String data);
  Future<AgendaModel> createAgenda(AgendaModel agendaModel);
  Future<bool> updateAgenda(String? id, AgendaModel agendaModel);
  Future<bool> deleteAgenda(String? id);
}

final usuarioPerfil = Modular.get<AgendaModel>();
final mensagem = Modular.get<Mensagens>();

class GetRepositoryAgenda implements SearchDataSourceAgenda {
  final dio = Modular.get<Dio>();
  String url = "https://10.0.2.2:7082/api/UsuarioModels";

  @override
  Future<AgendaModel> getSearchAgenal() async {
    final prefs = await SharedPreferences.getInstance();
    final String? id = prefs.getString('idPerfilUsuario');

    final response = await dio.get('$url${'/'}$id');
    if (response.statusCode == 200) {
      try {
        return AgendaModel.fromMap(response.data);
      } catch (e) {
        Exception(e);
      }
    } else {}
    throw Exception("Falhou");
  }

  @override
  Future<bool> getSearchTipoAgendaExiste( String tipo, String data) async {

    final response = await dio.get(url);
    if (response.statusCode == 200) {
      try {
        (response.data as List).map((e) => AgendaModel.fromMap(e))
            .firstWhere((element) => element.tipo == tipo && element.data == data);
        return true;
      } catch (e) {
        Exception(e);
      }
    } else {}
    return false;
  }

  @override
  Future<AgendaModel> createAgenda(AgendaModel agenda) async {
    //Formatação da data de 02-02-2022 para 2022-02-02 do datatime
    var inputFormat = DateFormat('dd-MM-yyyy');
    var formatacao = inputFormat.parse(agenda.data);
    var outputFormat = DateFormat('yyyy-MM-dd');
    var dataFormatada = outputFormat.format(formatacao);

    Map data = {
      "id"                  : agenda.id,
      "nome"                : agenda.nome,
      "tipo"                : agenda.tipo,
      "descricao"           : agenda.descricao,
      "data"                : dataFormatada,
      "local"               : agenda.local,
      "participantesModels" : agenda.participantesModels
    };

    final response = await dio.post(
      url,
      data: data,
    );

    if (response.statusCode == 201) {
      Modular.to.navigate("/Login");
      return AgendaModel.fromMap(response.data);
    } else {
      throw Exception('Failed to post cases');
    }
  }

  @override
  Future<bool> updateAgenda(String? id, AgendaModel agenda) async {

    //Formatação da data de 02-02-2022 para 2022-02-02 do datatime
    var inputFormat = DateFormat('dd-MM-yyyy');
    var formatacao = inputFormat.parse(agenda.data);
    var outputFormat = DateFormat('yyyy-MM-dd');
    var dataFormatada = outputFormat.format(formatacao);

    if(agenda.tipo == 'Exclusivo'){
      agenda.tipo = 'E';
    }else if(agenda.tipo == 'Compartilhado'){
      agenda.tipo == "C";
    }

    Map data = {
      "id"                  : agenda.id,
      "nome"                : agenda.nome,
      "tipo"                : agenda.tipo,
      "descricao"           : agenda.descricao,
      "data"                : dataFormatada,
      "local"               : agenda.local,
      "participantesModels" : agenda.participantesModels

    };
    Response response = await dio.put(
      '$url${'/'}$id',
      data: data,
    );
    if (response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Failed to update a case');
    }
  }

  @override
  Future<bool> deleteAgenda(String? id) async {

    Response response = await dio.delete('$url${'/'}$id');

    if (response.statusCode == 204) {
      return true;
    } else {
      throw "Failed to delete a case.";
    }
  }

}
