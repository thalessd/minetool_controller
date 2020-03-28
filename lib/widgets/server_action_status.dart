import 'package:flutter/material.dart';

import 'info_with_text.dart';

class ServerActionStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 100,
                    height: 100,
                    child: new RawMaterialButton(
                      fillColor: Colors.red,
                      shape: new CircleBorder(),
                      elevation: 4.0,
                      child: Icon(
                        Icons.stop,
                        color: Colors.white,
                        size: 50,
                      ),
                      onPressed: () {},
                    )),
                Container(
                    width: 55,
                    height: 55,
                    margin: EdgeInsets.only(top: 16),
                    child: new RawMaterialButton(
                      fillColor: Colors.blue,
                      shape: new CircleBorder(),
                      elevation: 4.0,
                      child: Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 22,
                      ),
                      onPressed: () {},
                    )),
              ],
            )),
        Container(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InfoWithText(title: "CPU", info: "80%"),
              InfoWithText(title: "MEM", info: "1024 GB"),
            ],
          ),
        )
      ],
    );
  }
}
