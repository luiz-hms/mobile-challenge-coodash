import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../../domain/models/dictionary_models.dart';
import '../../../services/api.dart';

class DetalhePalavra extends StatefulWidget {
  final String palavra;
  DetalhePalavra(this.palavra, {super.key});
  //const DetalhePalavra({Key? key, required this.palavra}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DetalhePalavraState createState() => _DetalhePalavraState();
}

class _DetalhePalavraState extends State<DetalhePalavra> {
  final player = AudioPlayer();

  String urlAudio = "";
  String formatDuration(Duration duration) {
    final minutos = duration.inMinutes.remainder(60);
    final segundos = duration.inSeconds.remainder(60);
    return "${minutos.toString().padLeft(2, '0')}:${segundos.toString().padLeft(2, '0')}";
  }

  void handlePause() {
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
  }

  void handleSeek(double value) {
    player.seek(Duration(seconds: value.toInt()));
  }

  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  @override
  void initState() {
    super.initState();
    player.setUrl(urlAudio
        //'https://api.dictionaryapi.dev/media/pronunciations/en/hello-uk.mp3'
        );
    player.positionStream.listen((p) {
      setState(() => position = p);
    });

    player.durationStream.listen((d) {
      setState(() {
        duration = d!;
      });
    });

    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          position = Duration.zero;
        });
        player.pause();
        player.seek(position);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: FutureBuilder<List<ApiWord>>(
          future: ApiService().fetchWordDetails(widget.palavra),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Error loading details'));
            }
            final data = snapshot.data!;
            final wordDetails = data.first;
            setState(() {
              urlAudio = wordDetails.phonetics.first.audio.toString();
            });
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 300,
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          children: [
                            Text(wordDetails.word,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25)),
                            const SizedBox(
                              height: 15,
                            ),
                            Text('${wordDetails.phonetics.first.text}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 15)),
                          ],
                        )),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(formatDuration(position)),
                      Slider(
                        min: 0.0,
                        max: duration.inSeconds.toDouble(),
                        value: position.inSeconds.toDouble(),
                        onChanged: handleSeek,
                      ),
                      Text(formatDuration(duration)),
                      IconButton(
                        onPressed: handlePause,
                        icon: Icon(
                            player.playing ? Icons.pause : Icons.play_arrow),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('meanings',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 35)),
                      Text(
                        'verb - ${wordDetails.meanings.first.definitions.first.definition}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      )
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
