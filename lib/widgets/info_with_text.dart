import 'package:flutter/material.dart';

class InfoWithText extends StatelessWidget {
  String _title;
  String _info;

  InfoWithText({String title = "INFO", String info = "0.0"}) {
    this._title = title;
    this._info = info;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            this._title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          margin: EdgeInsets.only(right: 7),
        ),
        Text(
          this._info,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
