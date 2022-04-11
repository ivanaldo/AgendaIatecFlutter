import 'package:agenda_iatec/models/usuario_model.dart';

abstract class SearchState {}

class SearchSuccess implements SearchState {
  List<UsuarioModel> list;

  SearchSuccess(this.list);
}

class SearchStart implements SearchState{}

class SearchLoading implements SearchState{}


class SearchError implements SearchState {}
