import 'package:flutter/material.dart';

import '../../widgets/card/card.dart';

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
        child: GridView.count(
          crossAxisCount: 3,
          children: List.generate(100, (index) {
            int ind = index;
            String inds = ind.toString();
            return Center(
              child: CardCustom(
                titulo: '$index',
                icone: IconButton(
                  icon: Icon(Icons.abc),
                  onPressed: () => {},
                ),
                funcNav: (inds) => {print(inds)},
              ), /*Card(
                child: Text(
                  '$index',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),*/
            );
          }),
        ),
      ),
    );
  }
}
