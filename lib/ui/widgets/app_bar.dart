import 'package:flutter/material.dart';

Widget normalAppBar() {
  return AppBar(
    centerTitle: true,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Daily '),
        Text(
          'News',
          style: TextStyle(color: Colors.blue),
        ),
      ],
    ),
    elevation: 0,
  );
}

Widget specificAppBar() {
  return AppBar(
    centerTitle: true,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Daily '),
        Text(
          'News',
          style: TextStyle(color: Colors.blue),
        ),
      ],
    ),
    actions: <Widget>[
      Opacity(
        opacity: 0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Icon(Icons.description),
        ),
      ),
    ],
    elevation: 0,
  );
}