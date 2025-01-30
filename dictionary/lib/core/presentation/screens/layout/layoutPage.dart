import 'package:dictionary/core/presentation/screens/home/home.dart';
import 'package:flutter/material.dart';

import '../favoritos/favoritos.dart';
import '../historico/historico.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({Key? key}) : super(key: key);

  @override
  _LayoutPageState createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const List<Widget> _pages = <Widget>[
      Home(),
      Historico(),
      Favoritos(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'Historico'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'favoritos')
        ],
        onTap: _onItemTapped,
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
    );
  }
}
