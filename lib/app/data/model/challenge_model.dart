import 'package:intl/intl.dart';

class ChallengeModel {
  String nome;
  String email;
  String telefone;
  String cpf;
  DateTime nascimentoData;
  String cidade;
  String estado;
  String pais;

  ChallengeModel(
      {this.nome,
      this.email,
      this.telefone,
      this.cpf,
      this.nascimentoData,
      this.cidade,
      this.estado,
      this.pais});

  ChallengeModel.fromJson(Map<String, dynamic> json) {
    this.nome = json['nome'];
    this.email = json['email'];
    this.telefone = json['telefone'];
    this.cpf = json['cpf'];
    this.nascimentoData = json['nascimentoData'];
    this.cidade = json['cidade'];
    this.estado = json['estado'];
    this.pais = json['pais'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['nome'] = this.nome;
    data['email'] = this.email;
    data['telefone'] = this.telefone;
    data['cpf'] = this.cpf;
    data['nascimentoData'] =
        DateFormat("dd/MM/yyyy").format(this.nascimentoData).toString();
    data['cidade'] = this.cidade;
    data['estado'] = this.estado;
    data['pais'] = this.pais;
    return data;
  }

  String toString() {
    return "Nome: " +
        this.nome +
        " email: " +
        this.email +
        " telefone: " +
        this.telefone +
        " cpf: " +
        this.cpf +
        " data de nascimento: " +
        DateFormat("dd/MM/yyyy").format(this.nascimentoData).toString() +
        " cidade: " +
        this.cidade +
        " estado: " +
        this.estado +
        " país: " +
        this.pais;
  }
}
