import 'pessoa.dart';

class Aluno {
  Pessoa pessoa = Pessoa();
  double _nota;
  String _status;

  Aluno({this.pessoa});

  double get nota {
    return _nota;
  }

  void set nota(double novaNota) {
    _nota = novaNota;
  }

  String get status {
    return _status;
  }

  void set status(String novoStatus) {
    _status = novoStatus;
  }

  bool isAprove() {
    return this._status == "Aprovado";
  }

  void set nome(String nome) {
    this.pessoa.nome = nome;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.pessoa.nome;
    data['idade'] = this.pessoa.idade;
    data['nota'] = this.nota;
    data['status'] = this.status;
    return data;
  }

  Aluno.fromJson(Map<String, dynamic> json) {
    this.nome = json['nome'];
    this.pessoa.idade = json['idade'];
    this.nota = json['nota'];
    this.status = json['status'];
  }
}
