import 'package:flutter/material.dart';

class Users extends StatelessWidget {
  final List<Map<String, dynamic>> userOnlineList;

  Users({this.userOnlineList});

  Widget _buildUserItem(BuildContext context, int index) {
    String user = userOnlineList[index]["user"];
    String logInTime = userOnlineList[index]["logInTime"];
    String ip = userOnlineList[index]["ip"];

    return Tooltip(
        message: "IP: $ip",
        child: ListTile(
          leading: Icon(
            Icons.person,
          ),
          title: Text(user),
          onTap: () {},
          subtitle: Text(logInTime),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: <Widget>[
        ListTile(
          title: Text("Usuários Online: ${userOnlineList.length}"),
          leading: Icon(Icons.people),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemBuilder: _buildUserItem,
            itemCount: userOnlineList.length,
          ),
        )
      ],
    ));
  }
}
