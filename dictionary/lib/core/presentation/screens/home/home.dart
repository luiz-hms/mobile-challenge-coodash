import 'package:flutter/material.dart';

import '../../widgets/card/card.dart';
import '../palavradetalhes/detalhePalavra.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: 100,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            String inds = index.toString();
            return CardCustom(
              word: inds,
              onNavigate: (word) {
                // Navega para a tela de detalhes
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetalhePalavra(),
                    //builder: (context) => DetailsScreen(word: word),
                  ),
                );
              },
              onToggleFavorite: (id, isFavorite) {
                // Lógica para alternar o status de favorito da palavra
                print('Palavra $id favorita: $isFavorite');
              },
              isFavorite: false, // Exemplo de palavra não favorita
            );
          },
        ),
      ),
    );
  }
}
