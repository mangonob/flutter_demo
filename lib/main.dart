import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/only_text.dart';
import 'package:flutter_demo/routes/routes.dart';
import 'package:flutter_demo/my_charts_example.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
      home: MyChartsExample(),
      builder: EasyLoading.init(),
    ),
  );
}

class CustomChartStyle extends MaterialStyle {
  @override
  Color get arcStrokeColor => Color.transparent;
}
