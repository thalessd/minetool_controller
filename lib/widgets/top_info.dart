import 'package:flutter/material.dart';

class TopInfo extends StatelessWidget {
  final String serverName;
  final String serverDifficulty;
  final String status;

  TopInfo(
      {this.serverName = "Server Name",
      this.status = "loading",
      this.serverDifficulty});

  @override
  Widget build(BuildContext context) {
    String text;
    Color color;

    switch (this.status) {
      case "online":
        text = "Online";
        color = Colors.green.shade700;
        break;
      case "offline":
        text = "Offline";
        color = Colors.red.shade700;
        break;
      case "loading":
        text = "Carregando";
        color = Colors.blue.shade700;
        break;
      default:
        text = "";
        color = Colors.black45;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(serverName,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          FractionallySizedBox(
            widthFactor: 0.5,
            child: Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              color: Theme.of(context).primaryTextTheme.title.color,
              height: 1,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 12,
                width: 12,
                margin: EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
              Text("$text | ${serverDifficulty.toUpperCase()}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
            ],
          )
        ],
      ),
    );
  }
}
