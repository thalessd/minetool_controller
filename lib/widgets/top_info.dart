import 'package:flutter/material.dart';

class TopInfo extends StatelessWidget {
  final String serverName;
  final bool isOnline;

  TopInfo({this.serverName = "Server Name", this.isOnline = true});

  @override
  Widget build(BuildContext context) {
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
                  color: isOnline ? Colors.green.shade700 : Colors.red.shade700,
                ),
              ),
              Text(isOnline ? "Online" : "Offline",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
            ],
          )
        ],
      ),
    );
  }
}
