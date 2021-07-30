import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/only_text.dart';
import 'package:flutter_demo/orientation.dart';
import 'package:flutter_demo/routes/routes.dart';

void main() {
  StyleFactory.style = CustomChartStyle();

  runApp(
    MaterialApp(
      routes: {
        Routes.first: (_) => OnlyText(text: "first"),
        Routes.second: (_) => OnlyText(text: "second"),
        Routes.third: (_) => OnlyText(text: "third"),
      },
      title: "My app",
      home: Scaffold(
        body: SafeArea(
          top: true,
          bottom: true,
          child: OrientationWidget(
            orientation: StatusBarOrientation.landscapeRight,
            child: ListView(
              children: List.generate(
                1000,
                (index) => ListTile(title: Text("Item: $index")),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class CustomChartStyle extends MaterialStyle {
  @override
  Color get arcStrokeColor => Color.transparent;
}
