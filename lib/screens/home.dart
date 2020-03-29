import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minetoolcontroller/services/socket.dart';
import 'package:minetoolcontroller/widgets/server_action_state.dart';
import 'package:minetoolcontroller/widgets/top_info.dart';
import 'package:minetoolcontroller/widgets/user_list_tile.dart';

class Home extends StatefulWidget {
  final Socket socket;

  Home({this.socket});

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {

  String _serverState = "load";
  bool _serverOnline = false;

  @override
  void initState() {
    super.initState();

    var socket = widget.socket;

    socket.onConnect((_) {
      print("Conectou ao Socket");
      socket.emitServerStatus();
    });

    socket.onServerRunning((_) {
        setState(() {
          _serverState = "load";
        });
    });

    socket.onServerDone((_) {
      socket.emitServerStatus();
    });

    socket.onServerStop((_) {
      socket.emitServerStatus();
    });

    socket.onServerStatusData((data) {
      setState(() {
        _serverState = data["serverOnline"] ? "play" : "stop";
        _serverOnline = data["serverOnline"];
      });
    });

    socket.connect();
  }

  void serverRestart() {
    widget.socket.emitServerRestart();
    setState(() {
      _serverState = "load";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: TopInfo(isOnline: _serverOnline),
          ),
          Expanded(flex: 4, child: ServerActionState(
            state: _serverState,
            playPress: () { widget.socket.emitServerRun(); },
            stopPress: () { widget.socket.emitServerStop(); },
            restartPress: () { serverRestart(); },
          )),
          Expanded(
              flex: 4,
              child: ListView(
                children: <Widget>[
                  UserListTile(),
                  UserListTile(),
                  UserListTile(),
                  UserListTile(),
                  UserListTile(),
                ],
              )),
          SizedBox(
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.only(top: 2),
              child: RaisedButton(
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                child: Text("LOGS GLOBAIS"),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
