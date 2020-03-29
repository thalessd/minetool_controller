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
  String _serverStatus = "loading";
  String _serverName = "Carregando...";
  String _serverDifficulty = "---";

  String _cpuUsage = "0%";
  String _memoryUsage = "0 Kb";

  @override
  void initState() {
    super.initState();

    var socket = widget.socket;

    socket.onConnect((_) {
      print("Conectou ao Socket");
      socket.emitServerStatus();
    });

    socket.onServerRunning((_) {
      socket.emitServerStatus();
    });

    socket.onServerDone((_) {
      socket.emitServerStatus();
    });

    socket.onServerStop((_) {
      socket.emitServerStatus();
    });

    socket.onServerStatsInfo((data) {
      setState(() {
        _cpuUsage = data["cpu"];
        _memoryUsage = data["memory"];
      });
    });

    socket.onServerStatusData((data) {
      setState(() {
        _serverStatus = data["serverStatus"];
        _serverName = data["serverName"];
        _serverDifficulty = data["serverDifficulty"];
      });
    });

    socket.connect();
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
            child: TopInfo(
              status: _serverStatus,
              serverName: _serverName,
              serverDifficulty: _serverDifficulty,
            ),
          ),
          Expanded(
              flex: 4,
              child: ServerActionState(
                status: _serverStatus,
                cpuUsage: _cpuUsage,
                memUsage: _memoryUsage,
                playPress: () {
                  widget.socket.emitServerRun();
                },
                stopPress: () {
                  widget.socket.emitServerStop();
                },
                restartPress: () {
                  widget.socket.emitServerRestart();
                },
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
