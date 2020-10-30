import 'package:flutter/material.dart';

class LevelIm extends StatefulWidget {
  @override
  _LevelImState createState() => _LevelImState();
}

class _LevelImState extends State<LevelIm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[200],
        title: Text(
          '모두의 오픽',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(),
    );
  }
}
