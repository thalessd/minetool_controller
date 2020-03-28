import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minetoolcontroller/services/socket.dart';
import 'package:minetoolcontroller/widgets/server_action_status.dart';
import 'package:minetoolcontroller/widgets/top_info.dart';
import 'package:minetoolcontroller/widgets/user_list_tile.dart';

class Home extends StatefulWidget {
  final Socket socket;

  Home({this.socket});

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  @override
  void initState() {
    super.initState();

    var socket = widget.socket;

    socket.onConnect((_) {
      print("Conectou ao Socket");
    });

    socket.onUserLogged((data) {
      print(data);
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
            child: TopInfo(),
          ),
          Expanded(flex: 4, child: ServerActionStatus()),
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
