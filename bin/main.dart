import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'model/aluno.dart';
import 'model/pessoa.dart';
import 'model/turma.dart';

void main() async {
  const GABARITO = ['A', 'C', 'A', 'C', 'B', 'C', 'A', 'B', 'B', 'A'];
  const OPCOES = ['A', 'B', 'C'];
  var entrada = "";
  Turma turma = Turma();

  var fileIsPresent = await File("database.json").exists();

  if (fileIsPresent) {
    print("Arquivo já existe!");
    var filePresent = await File("database.json").readAsString();
    print(filePresent);
  } else {
    turma.id = "1";

    do {
      print("Cadastre um aluno:");
      stdout.write("Nome:");
      var entrada = stdin.readLineSync();
      if (entrada == "exit") break;

      stdout.write("Idade:");
      var idade = int.tryParse(stdin.readLineSync());

      turma.matricularAluno(Aluno(pessoa: Pessoa(nome: entrada, idade: idade)));
    } while (entrada != "exit");

    turma.alunos.forEach((aluno) {
      var respostas = turma.geradorRespostas(GABARITO.length, OPCOES);
      var nota = turma.atualizaNota(respostas, GABARITO);
      var status = nota > 4 ? "Aprovado" : "Reprovado";
      aluno.nota = nota.toDouble();
      aluno.status = status;
    });

    File file = new File("database.json");
    await file.writeAsString(json.encode(turma));
    print(turma.toJson());
  }
}
