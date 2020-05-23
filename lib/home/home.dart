import 'package:flutter/material.dart';
import 'widgets/header.dart';

class Home extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [Header()]),
    );
  }
}
