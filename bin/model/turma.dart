import 'dart:convert';
import 'dart:io';
import 'dart:math';

import '../turma-acoes.dart';
import 'aluno.dart';
import 'entidade.dart';

class Turma extends Entidade implements ITurmaAcoes {
  List<Aluno> _alunos = [];

  Turma({alunos}) : super();

  List<Aluno> get alunos => _alunos;
  void set alunos(List<Aluno> alunos) => this._alunos = alunos;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this._alunos != null) {
      data['alunos'] = this._alunos.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Turma.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['alunos'] != null) {
      // alunos = new List<Aluno>();
      json['alunos'].forEach((v) {
        print("Aluno read: $v");
        this.matricularAluno(new Aluno.fromJson(v));
      });
    }
  }

  @override
  carregarArquivo() async {
    // TODO: implement salvarArquivo
  }

  @override
  void salvarArquivo() {
    // TODO: implement salvarArquivo
  }

  @override
  void matricularAluno(Aluno aluno) {
    this._alunos.add(aluno);
  }

  @override
  double obterSomaDasNOtas() {
    return this.alunos.fold(0, (acc, e) => acc += e.nota);
  }

  @override
  double obterMedia() {
    return this.obterSomaDasNOtas() / this.alunos.length;
  }

  @override
  Aluno melhorDesempenho() {
    List<Aluno> orderedList = this.alunos;
    orderedList.sort((a, b) => b.nota.compareTo(a.nota));
    return orderedList[0];
  }

  @override
  Aluno piorDesempenho() {
    List<Aluno> orderedList = this.alunos;
    orderedList.sort((a, b) => a.nota.compareTo(b.nota));
    return orderedList[0];
  }

  @override
  List<Aluno> obterAprovados() {
    var alunosAprovados = this.alunos.where((aluno) => aluno.isAprove());
    return alunosAprovados.toList();
  }

  @override
  List<Aluno> obterReprovados() {
    var alunosReprovados = this.alunos.where((aluno) => !aluno.isAprove());
    return alunosReprovados.toList();
  }

  List<String> geradorRespostas(int qtdRespostas, List<String> opcoes) {
    List<String> notas = [];

    for (var i = 0; i < qtdRespostas; i++) {
      var respostaAleatoria = opcoes[Random().nextInt(opcoes.length)];
      notas.add(respostaAleatoria);
    }

    return notas;
  }

  int atualizaNota(List<String> respostas, List<String> gabarito) {
    int acertos = 0;

    for (var i = 0; i < respostas.length; i++) {
      if (respostas[i] == gabarito[i]) {
        acertos++;
      }
    }

    return acertos;
  }
}
