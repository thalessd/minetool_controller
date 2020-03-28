import 'package:flutter/material.dart';

class UserListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Usuario"),
          Container(
            width: 30,
            height: 30,
            child: IconButton(
              iconSize: 18,
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
