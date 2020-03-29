import 'package:flutter/material.dart';
import 'package:minetoolcontroller/screens/home.dart';
import 'package:minetoolcontroller/services/socket.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  Socket _socket;

  Main() {
    this._socket = Socket('http://192.168.0.100:4444');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(socket: this._socket),
    );
  }
}