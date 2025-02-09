import '../../domain/models/palavra.dart';
import '../datasources/database_helper.dart';

class PalavraRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // Adicionar palavra ao banco de dados
  Future<int> addPalavra(String palavra) async {
    int id = await _dbHelper.insert(palavra);
    return id;
  }

  // Atualizar status de favorito
  Future<int> updatePalavra(String row, bool status) async {
    int linhasAfetadas = await _dbHelper.update(row, status);
    return linhasAfetadas;
  }

  // Buscar todas as palavras salvas no banco
  Future<List<Palavra>> getPalavrasByHistorico() async {
    final result = await _dbHelper.queryByColumn('historico', 1);
    return result.map((map) => Palavra.fromMap(map)).toList();
  }

  // Buscar palavras favoritas no banco
  Future<List<Palavra>> getPalavrasByFavorito() async {
    final result = await _dbHelper.queryByColumn('favorito', 1);
    return result.map((map) => Palavra.fromMap(map)).toList();
  }
}
