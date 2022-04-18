import 'package:agenda_iatec/models/participantes_model.dart';

class AgendaModel {

  int? id;
  late String nome;
  late String tipo;
  late String descricao;
  late String data;
  late String local;
  late String hora;
  late List<ParticipantesModel>? participantesModels;
  static late String search;
  static late int tabController;

  AgendaModel({this.id, required this.nome, required this.tipo, required this.descricao, required this.data,
      required this.local, required this.hora, this.participantesModels});

  factory AgendaModel.fromMap(Map<String, dynamic> map){
    return AgendaModel(
        id                  : map["id"],
        nome                : map["nome"],
        tipo                : map["tipo"],
        descricao           : map["descricao"],
        data                : map["data"],
        local               : map["local"],
        hora                : map["hora"],
        participantesModels : map["participantesModels"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id"                  : id,
      "nome"                : nome,
      "tipo"                : tipo,
      "descricao"           : descricao,
      "data"                : data,
      "local"               : local,
      "hora"                : hora,
      "participantesModels" : participantesModels
    };
  }
}