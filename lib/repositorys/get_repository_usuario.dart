import 'package:agenda_iatec/models/mensagem.dart';
import 'package:agenda_iatec/models/usuario_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class SearchDataSourceUsuario {
  Future<UsuarioModel> getSearchPerfil();
  Future<UsuarioModel> getSearchLogin(String email, String senha);
  Future<bool> getSearchEmailExiste( String email);
  Future<UsuarioModel> createUsuario(UsuarioModel usuario);
  Future<bool> updateUsuario(String? id, UsuarioModel usuario);
  Future<bool> deleteUsuario(String? id);
}

final usuarioPerfil = Modular.get<UsuarioModel>();
final mensagem = Modular.get<Mensagens>();

class GetRepositoryUsuario implements SearchDataSourceUsuario {
  final dio = Modular.get<Dio>();
  String url = "https://10.0.2.2:7082/api/UsuarioModels";

  @override
  Future<UsuarioModel> getSearchPerfil() async {
    final prefs = await SharedPreferences.getInstance();
    final String? id = prefs.getString('idPerfilUsuario');

    final response = await dio.get('$url${'/'}$id');
    if (response.statusCode == 200) {
      try {
        return UsuarioModel.fromMap(response.data);
      } catch (e) {
        Exception(e);
      }
    } else {}
    throw Exception("Falhou");
  }
  @override
  Future<UsuarioModel> getSearchLogin(String email, String senha) async {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      try {
        final usuario =
        (response.data as List).map((e) => UsuarioModel.fromMap(e))
            .firstWhere((element) => element.email == email && element.senha == senha);
        return usuario;
      } catch (e) {
        Exception(e);
      }
    } else {}
    mensagem.mensagemErroLogin();
    throw Exception("Falhou");
  }

  @override
  Future<bool> getSearchEmailExiste( String email) async {

    final response = await dio.get(url);
    if (response.statusCode == 200) {
      try {
        (response.data as List).map((e) => UsuarioModel.fromMap(e))
        .firstWhere((element) => element.email == email);
        return true;
      } catch (e) {
        Exception(e);
      }
    } else {}
    return false;
  }

  @override
  Future<UsuarioModel> createUsuario(UsuarioModel usuario) async {
    //Formatação da data de 02-02-2022 para 2022-02-02 do datatime
    var inputFormat = DateFormat('dd-MM-yyyy');
    var formatacao = inputFormat.parse(usuario.datanascimento);
    var outputFormat = DateFormat('yyyy-MM-dd');
    var dataFormatada = outputFormat.format(formatacao);

    Map data = {
      'nome': usuario.nome,
      'email': usuario.email,
      'datanascimento': dataFormatada,
      'senha': usuario.senha,
      'genero': usuario.genero,
    };

    final response = await dio.post(
      url,
      data: data,
    );

    if (response.statusCode == 201) {
      Modular.to.navigate("/Login");
      return UsuarioModel.fromMap(response.data);
    } else {
      throw Exception('Failed to post cases');
    }
  }

  @override
  Future<bool> updateUsuario(String? id, UsuarioModel usuario) async {

    //Formatação da data de 02-02-2022 para 2022-02-02 do datatime
    var inputFormat = DateFormat('dd-MM-yyyy');
    var formatacao = inputFormat.parse(usuario.datanascimento);
    var outputFormat = DateFormat('yyyy-MM-dd');
    var dataFormatada = outputFormat.format(formatacao);

    if(usuario.genero == 'Masculino'){
      usuario.genero = 'M';
    }else if(usuario.genero == 'Feminino'){
      usuario.genero == "F";
    }

    Map data = {
      'id'            : id,
      'nome'          : usuario.nome,
      'email'         : usuario.email,
      'datanascimento': dataFormatada,
      'senha'         : usuario.senha,
      'genero'        : usuario.genero,

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
  Future<bool> deleteUsuario(String? id) async {

    Response response = await dio.delete('$url${'/'}$id');

    if (response.statusCode == 204) {
      return true;
    } else {
      throw "Failed to delete a case.";
    }
  }

}

/*
 @override
  Future<UsuarioModel> getSearch() async {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      try {
        final list =
        (response.data as List).map((e) => UsuarioModel.fromMap(e))
            .firstWhere((element) => element.id == usuarioPerfil.id);
        return list;
      } catch (e) {
        Exception(e);
      }
    } else {}
    throw Exception("Falhou");
  }
 */