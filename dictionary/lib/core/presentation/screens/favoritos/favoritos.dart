import 'package:dictionary/core/data/repositories/word_repository.dart';
import 'package:flutter/material.dart';
import '../../../domain/models/palavra.dart';
import '../palavradetalhes/detalhe_palavra.dart';

class Favoritos extends StatefulWidget {
  const Favoritos({Key? key}) : super(key: key);

  @override
  _FavoritosState createState() => _FavoritosState();
}

class _FavoritosState extends State<Favoritos> {
  final PalavraRepository _palavraRepository = PalavraRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('lista de favoritos'),
      ),
      body: FutureBuilder<List<Palavra>>(
        future: _palavraRepository.getPalavrasByHistorico(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar histórico"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhuma palavra no histórico"));
          }

          final palavras = snapshot.data!;
          return GridView.builder(
            itemCount: palavras.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              String palavra = palavras[index].palavra;
              return Card(
                child: ListTile(
                  title: Text(palavras[index].palavra),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                    ),
                    onPressed: () => {
                      {
                        _palavraRepository.updatePalavra(
                            'favoritos', !palavras[index].favorito)
                      },
                    },
                  ),
                  onTap: () async {
                    int id = await _palavraRepository.addPalavra(palavra);
                    if (id != 0) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => DetalhePalavra(
                                palavra,
                              ))));
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
