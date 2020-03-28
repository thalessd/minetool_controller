import 'package:flutter/material.dart';

class TopInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Server Name",
              style:
              TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          FractionallySizedBox(
            widthFactor: 0.5,
            child: Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              color: Colors.white,
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
                  color: Colors.green.shade700,
                ),
              ),
              Text("Online",
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold))
            ],
          )
        ],
      ),
    );
  }
}
