import 'model/aluno.dart';
import 'model/turma.dart';

abstract class ITurmaAcoes {
  void matricularAluno(Aluno aluno);
  void salvarArquivo();
  Turma carregarArquivo();
  double obterMedia();
  double obterSomaDasNOtas();
  List<Aluno> obterAprovados();
  List<Aluno> obterReprovados();
  Aluno melhorDesempenho();
  Aluno piorDesempenho();
}
