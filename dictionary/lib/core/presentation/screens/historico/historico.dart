import 'package:flutter/material.dart';
import '../../../data/repositories/word_repository.dart';
import '../../../domain/models/palavra.dart';
import '../palavradetalhes/detalhe_palavra.dart';

class Historico extends StatefulWidget {
  const Historico({Key? key}) : super(key: key);

  @override
  _HistoricoState createState() => _HistoricoState();
}

class _HistoricoState extends State<Historico> {
  final PalavraRepository _palavraRepository = PalavraRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('lista de históricos'),
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
              //final palavra = palavras[index];
              //bool isSalva = _isPalavraSalva(palavra);

              return Card(
                child: ListTile(
                  title: Text(palavras[index].palavra),
                  trailing: IconButton(
                    icon: Icon(
                      palavras[index].favorito
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.redAccent,
                    ),
                    onPressed: () => {
                      {
                        _palavraRepository.updatePalavra(
                            'favoritos', !palavras[index].favorito)
                      },
                    },
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => DetalhePalavra(
                              palavras[index].palavra,
                            ))));
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
