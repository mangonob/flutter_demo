import 'package:flutter/material.dart';
import 'package:flutter_demo/week_widget_demo/submodule/animated_icon_demo.dart';
import 'package:flutter_demo/week_widget_demo/submodule/drag.dart';
import 'package:flutter_demo/week_widget_demo/submodule/fractional.dart';
import 'package:flutter_demo/week_widget_demo/submodule/limited_box_demo.dart';
import 'package:flutter_demo/week_widget_demo/submodule/wheel_list.dart';
import 'package:flutter_demo/widgets/general_scaffold.dart';

class WeekWidgetDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      title: "Widgets",
      body: ListView(
        children: [
          _Tile(
            title: "ListWheelScrollView",
            pageBuilder: (ctx) => WheelList(),
          ),
          _Tile(
            title: "FractionallySizedBox",
            pageBuilder: (ctx) => Fractional(),
          ),
          _Tile(
            title: "LimitedBox",
            pageBuilder: (ctx) => LimitedBoxDemo(),
          ),
          _Tile(
            title: "AnimatedIcon",
            pageBuilder: (ctx) => AnimatedIconDemo(),
          ),
          _Tile(
            title: "Dragable",
            pageBuilder: (ctx) => Drag(),
          ),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final String title;
  final WidgetBuilder pageBuilder;

  _Tile({
    Key? key,
    required this.title,
    required this.pageBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      tileColor: Colors.white,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: pageBuilder),
        );
      },
    );
  }
}
