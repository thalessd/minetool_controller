import 'package:flutter/material.dart';

enum UserMenu { kick, say, tp }

class Users extends StatelessWidget {
  final List<Map<String, dynamic>> userOnlineList;

  Users({this.userOnlineList});

  _popupMenuItem({UserMenu value, String title, IconData iconData}) {
    return PopupMenuItem<UserMenu>(
      value: value,
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(iconData),
            margin: EdgeInsets.only(right: 12),
          ),
          Text(title)
        ],
      ),
    );
  }

  List<PopupMenuEntry<UserMenu>> _buildPopupMenuItem(BuildContext context) {
    return [
      _popupMenuItem(
          value: UserMenu.say, iconData: Icons.comment, title: "Enviar Mensagem"),
      _popupMenuItem(
          value: UserMenu.tp, iconData: Icons.swap_horizontal_circle, title: "Teleportar"),
      _popupMenuItem(value: UserMenu.kick, iconData: Icons.block, title: "Kickar")
    ];
  }

  Widget _buildUserItem(BuildContext context, int index) {
    String user = userOnlineList[index]["user"];
    String logInTime = userOnlineList[index]["logInTime"];
    String ip = userOnlineList[index]["ip"];

    return PopupMenuButton<UserMenu>(
        itemBuilder: _buildPopupMenuItem,
        tooltip: "IP: $ip",
        child: ListTile(
          leading: Icon(
            Icons.person,
          ),
          title: Text(user),
          subtitle: Text(logInTime),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            side: BorderSide(color: Colors.grey)),
        color: Colors.transparent,
        elevation: 0,
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
