class UsuarioModel{
  late String nome;
  late String email;
  late String senha;
  late String datanascimento;
  late String sexo;

  UsuarioModel({required this.nome, required this.email, required this.senha, required this.datanascimento, required this.sexo});

  factory UsuarioModel.fromJson(Map<String, dynamic> json){
    return UsuarioModel(
    nome:           json["nome"],
    email:          json["email"],
    senha:          json["senha"],
    datanascimento: json["datanascimento"],sexo: json["sexo"]);
  }

  Map<String, dynamic> toJson(){
    return{
      "nome"  : nome,
      "email" : email,
      "senha" : senha,
      "datanascimento" : datanascimento,
      "sexo"  : sexo
    };
  }

  @override
  String toString() {
    return 'UsuarioModel{nome: $nome, email: $email, senha: $senha, datanascimento: $datanascimento, sexo: $sexo}';
  }
}