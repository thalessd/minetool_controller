import 'package:flutter/material.dart';

class InfoWithText extends StatelessWidget {
  final String title;
  final String info;

  InfoWithText({this.title = "INFO", this.info = "0.0"});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          margin: EdgeInsets.only(right: 7),
        ),
        Text(
          info,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
