import 'package:flutter/material.dart';

class CardCustom extends StatelessWidget {
  final String word;
  final Function(String) onNavigate;
  final Function(int, bool) onToggleFavorite;
  final IconData? icon;
  final Function? iconAction;
  final bool isFavorite;

  CardCustom({
    required this.isFavorite,
    required this.word,
    required this.onNavigate,
    required this.onToggleFavorite,
    this.icon,
    this.iconAction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(2),
        title: Text(
          word,
          style: const TextStyle(
            fontSize: 10,
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
