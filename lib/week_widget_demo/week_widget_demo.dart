import 'package:flutter/material.dart';
import 'package:flutter_demo/week_widget_demo/submodule/animated_icon_demo.dart';
import 'package:flutter_demo/week_widget_demo/submodule/animations_demo.dart';
import 'package:flutter_demo/week_widget_demo/submodule/backdrop_filter_demo.dart';
import 'package:flutter_demo/week_widget_demo/submodule/curve_demo/curve_demo.dart';
import 'package:flutter_demo/week_widget_demo/submodule/data_table_demo.dart';
import 'package:flutter_demo/week_widget_demo/submodule/drag.dart';
import 'package:flutter_demo/week_widget_demo/submodule/flutter_animation_demo.dart';
import 'package:flutter_demo/week_widget_demo/submodule/fractional.dart';
import 'package:flutter_demo/week_widget_demo/submodule/inherited_model_demo.dart';
import 'package:flutter_demo/week_widget_demo/submodule/interactive_viewer_demo.dart';
import 'package:flutter_demo/week_widget_demo/submodule/limited_box_demo.dart';
import 'package:flutter_demo/week_widget_demo/submodule/physical_model_demo.dart';
import 'package:flutter_demo/week_widget_demo/submodule/shader_mask_demo.dart';
import 'package:flutter_demo/week_widget_demo/submodule/table_demo.dart';
import 'package:flutter_demo/week_widget_demo/submodule/tree.dart';
import 'package:flutter_demo/week_widget_demo/submodule/wheel_list.dart';
import 'package:flutter_demo/widgets/general_scaffold.dart';

import 'submodule/wrap_demo.dart';

class WeekWidgetDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      title: "Widgets",
      body: ListView(
        children: [
          _Tile(
            title: "Widget Tree",
            pageBuilder: (ctx) => Tree(),
          ),
          _Tile(
            title: "Flutter Animations",
            pageBuilder: (ctx) => FlutterAnimationDemo(),
          ),
          _Tile(
            title: "Animations",
            pageBuilder: (ctx) => AnimationsDemo(),
          ),
          _Tile(
            title: "PhysicalModel",
            pageBuilder: (ctx) => PhysicalModelDemo(),
          ),
          _Tile(
            title: "ShaderMask",
            pageBuilder: (ctx) => ShaderMaskDemo(),
          ),
          _Tile(
            title: "InteractiveViewer",
            pageBuilder: (ctx) => InteractiveViewerDemo(),
          ),
          _Tile(
            title: "Curve",
            pageBuilder: (ctx) => CurveDemo(),
          ),
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
          _Tile(
            title: "Wrap",
            pageBuilder: (ctx) => WrapDemo(),
          ),
          _Tile(
            title: "Table",
            pageBuilder: (ctx) => TableDemo(),
          ),
          _Tile(
            title: "DataTable",
            pageBuilder: (ctx) => DataTableDemo(),
          ),
          _Tile(
            title: "InheritedModel",
            pageBuilder: (ctx) => InheritedModelDemo(),
          ),
          _Tile(
            title: "BackdropFilter",
            pageBuilder: (ctx) => BackdropFilterDemo(),
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
