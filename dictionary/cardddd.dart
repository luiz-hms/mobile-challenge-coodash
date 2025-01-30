import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  final String word;
  final Function(String)
      onNavigate; // Função para navegação para a tela de detalhes
  final Function(int, bool)
      onToggleFavorite; // Função para alternar o status de favorito
  final bool isFavorite; // Indica se a palavra está favoritada ou não

  WordCard({
    required this.word,
    required this.onNavigate,
    required this.onToggleFavorite,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: ListTile(
        contentPadding: EdgeInsets.all(12),
        title: Text(
          word,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () => onNavigate(word), // Navegar para a tela de detalhes
        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : null,
          ),
          onPressed: () {
            // Alterar o status de favorito quando o ícone for pressionado
            onToggleFavorite(1,
                !isFavorite); // Passando um ID fictício e alternando o estado de favorito
          },
        ),
      ),
    );
  }
}
