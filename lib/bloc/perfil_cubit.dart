import 'package:agenda_iatec/models/usuario_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../repositorys/get_repository_usuario.dart';


final perfilUsuario = Modular.get<GetRepository>();

abstract class PerfilEvent {}

class RetornaUsuario extends PerfilEvent {}

class PerfilBloc extends Bloc<PerfilEvent, UsuarioModel> {
  PerfilBloc() : super(UsuarioModel(
      nome: "",
      email: "",
      senha: "",
      datanascimento: "",
      genero: "")) {

    on<RetornaUsuario>((event, emit) async {
      UsuarioModel _perfil;
      _perfil = (await perfilUsuario.getSearchPerfil());
      emit( _perfil);
    });
  }
}