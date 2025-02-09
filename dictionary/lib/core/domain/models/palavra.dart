class Palavra {
  final int? id;
  final String palavra;
  bool favorito;
  bool historico;

  Palavra({
    this.id,
    required this.palavra,
    this.favorito = false,
    this.historico = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'palavra': palavra,
      'favorito': favorito ? 1 : 0,
      'historico': historico ? 1 : 0,
    };
  }

  factory Palavra.fromMap(Map<String, dynamic> map) {
    return Palavra(
      id: map['id'],
      palavra: map['palavra'],
      favorito: map['favorito'] == 1,
      historico: map['historico'] == 1,
    );
  }
}
