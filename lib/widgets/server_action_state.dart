import 'package:flutter/material.dart';
import 'info_with_text.dart';

class ServerActionState extends StatelessWidget {
  Widget area;

  String cpuUsageData;
  String memUsageData;

  Function playPress;
  Function stopPress;
  Function restartPress;

  ServerActionState({
    String state = "play",
    String cpuUsage = "0",
    String memUsage = "0",
    this.playPress,
    this.stopPress,
    this.restartPress,
  }) {
    cpuUsageData = "---";
    memUsageData = "---";

    switch (state) {
      case "load":
        area = loadArea();
        break;
      case "play":
        cpuUsageData = cpuUsage;
        memUsageData = memUsage;

        area = buttonArea(
            mainBtnIcon: Icons.stop,
            mainBtnColor: Colors.red,
            mainBtnPress: stopPress);
        break;
      case "stop":
        area = buttonArea(
            mainBtnIcon: Icons.play_arrow,
            mainBtnColor: Colors.green,
            mainBtnPress: playPress);
        break;
      default:
        area = Container();
    }
  }

  Widget loadArea() {
    return Center(
        child: Column(
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(),
        ),
        Container(
          margin: EdgeInsets.only(top: 18),
          child: Text("Carregando", style: TextStyle(fontSize: 20)),
        )
      ],
    ));
  }

  Widget buttonArea({
    IconData mainBtnIcon,
    Color mainBtnColor,
    Function mainBtnPress,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            width: 100,
            height: 100,
            child: RawMaterialButton(
              fillColor: mainBtnColor,
              shape: CircleBorder(),
              elevation: 4.0,
              child: Icon(
                mainBtnIcon,
                color: Colors.white,
                size: 50,
              ),
              onPressed: mainBtnPress,
            )),
        Container(
            width: 55,
            height: 55,
            margin: EdgeInsets.only(top: 16),
            child: RawMaterialButton(
              fillColor: Colors.blue,
              shape: CircleBorder(),
              elevation: 4.0,
              child: Icon(
                Icons.refresh,
                color: Colors.white,
                size: 22,
              ),
              onPressed: restartPress,
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(child: area),
        Container(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InfoWithText(title: "CPU:", info: cpuUsageData),
              InfoWithText(title: "MEM:", info: memUsageData),
            ],
          ),
        )
      ],
    );
  }
}
