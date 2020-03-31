import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:minetoolcontroller/services/socket.dart';
import 'package:minetoolcontroller/widgets/server_action_state.dart';
import 'package:minetoolcontroller/widgets/top_info.dart';
import 'package:minetoolcontroller/widgets/users.dart';

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

  List<Map<String, dynamic>> _userOnlineList = [];

  TextEditingController _kickUserController;
  TextEditingController _sayToUserController;

  List<Widget> _dialogActions(
      {BuildContext context, Function onConfirm, String confirmText}) {
    return <Widget>[
      FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("CANCELAR", style: TextStyle(color: Colors.redAccent)),
      ),
      FlatButton(
        onPressed: () {
          onConfirm();
          Navigator.of(context).pop();
        },
        child: Text(
          confirmText.toUpperCase(),
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    ];
  }

  void _kickUserDialog(Map<String, dynamic> user) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Deseja kickar ${user["user"]}?"),
            content: TextField(
              controller: _kickUserController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Motivo',
              ),
            ),
            actions: _dialogActions(
                context: context,
                confirmText: "Kickar",
                onConfirm: () {
                  widget.socket.emitUserKick(
                    user["user"],
                    reason: _kickUserController.value.text
                  );

                  _kickUserController.text = "";
                }),
          );
        });
  }

  void _sayToUserDialog(Map<String, dynamic> user) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Enviar mensagem para ${user["user"]}?"),
            content: TextField(
              controller: _sayToUserController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Mensagem',
              ),
            ),
            actions: _dialogActions(
                context: context,
                confirmText: "Enviar",
                onConfirm: () {
                  widget.socket.emitUserSay(
                      _sayToUserController.value.text,
                      user: user["user"]
                  );
                  _sayToUserController.text = "";
                }),
          );
        });
  }

  @override
  void initState() {
    super.initState();

    _kickUserController = TextEditingController();
    _sayToUserController = TextEditingController();

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

    socket.onUserLogged((_) {
      socket.emitServerStatus();
    });

    socket.onUserLoggedOut((_) {
      socket.emitServerStatus();
    });

    socket.onServerStatsInfo((data) {
      setState(() {
        _cpuUsage = data["cpu"];
        _memoryUsage = data["memory"];
      });
    });

    socket.onServerStatusData((data) {
      var dateFormatter = DateFormat("dd 'às' HH'h' mm");

      List<Map<String, dynamic>> userOnlineList = [];

      for (var playerData in data["playersOnline"]) {
        var date = DateTime.fromMillisecondsSinceEpoch(playerData["date"]);

        userOnlineList.add({
          "user": playerData["user"],
          "logInTime": dateFormatter.format(date),
          "ip": playerData["ip"]
        });
      }

      setState(() {
        _serverStatus = data["serverStatus"];
        _serverName = data["serverName"];
        _serverDifficulty = data["serverDifficulty"];
        _userOnlineList = userOnlineList;
      });
    });

    socket.connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                  child: Users(
                    userOnlineList: _userOnlineList,
                    onSayMessageToUser: _sayToUserDialog,
                    onTpUser: (user) {
                      print(user);
                    },
                    onKickUser: _kickUserDialog,
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
