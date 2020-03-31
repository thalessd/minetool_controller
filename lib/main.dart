import 'package:flutter/material.dart';
import 'package:minetoolcontroller/screens/home.dart';
import 'package:minetoolcontroller/services/socket.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  Socket _socket;

  Main() {
    this._socket = Socket('http://devdes.io:4444');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MineTool Controller',
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(socket: this._socket),
    );
  }
}