
class UsuarioModel{

  int? id;
  late String nome;
  late String email;
  late String senha;
  late String datanascimento;
  String? genero;

  UsuarioModel({
     this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.datanascimento,
    required this.genero,
  });

  factory UsuarioModel.fromMap(Map<String, dynamic> map){
    return UsuarioModel(
    id             : map["id"],
    nome           : map["nome"],
    email          : map["email"],
    senha          : map["senha"],
    datanascimento : map["dataNascimento"],
    genero         : map["genero"],
    );

  }

  Map<String, dynamic> toMap(){
    return{
      "id"             : id,
      "nome"           : nome,
      "email"          : email,
      "senha"          : senha,
      "dataNascimento" : datanascimento,
      "genero"           : genero,
    };
  }

}