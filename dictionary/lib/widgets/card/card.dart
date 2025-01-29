import 'package:flutter/material.dart';

class CardCustom extends StatefulWidget {
  final String titulo;
  final Widget icone;
  final Function(String word) funcNav;
  const CardCustom({
    Key? key,
    required this.titulo,
    required this.icone,
    required this.funcNav,
  }) : super(key: key);

  @override
  _CardCustomState createState() => _CardCustomState();
}

class _CardCustomState extends State<CardCustom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
          child: ListTile(
        title: Text(widget.titulo),
        trailing: IconButton(
          onPressed: () => {},
          icon: widget.icone,
          color: Colors.red[400],
        ),
        onTap: () => widget.funcNav,
      ) /*Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  widget.icon,
                  size: 20,
                  color: Colors.red[400],
                ),
                Text(widget.titulo, style: TextStyle(color: Colors.amber)),
              ]),
        ),
      ),*/
          ),
    );
  }
}

/*
class OpcaoCard extends StatelessWidget {
  const OpcaoCard({Key key, this.opcao}) : super(key: key);
  final Opcao opcao;
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context)
.textTheme.display1;
        return Card(
          color: Colors.white,
          child: Center(
             child: Column(
                 mainAxisSize: MainAxisSize.min,
                 crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>[
                Icon(opcao.icon, size:80.0, color: textStyle.color),
                Text(opcao.titulo, style: textStyle),
          ]
        ),
      )
    );
  }
}

*/