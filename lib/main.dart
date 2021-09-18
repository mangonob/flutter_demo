import 'package:flutter/material.dart';
import 'package:flutter_demo/only_text.dart';
import 'package:flutter_demo/routes/routes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'week_widget_demo/submodule/tree.dart';

void main() {
  runApp(
    MaterialApp(
      routes: {
        Routes.first: (_) => OnlyText(text: "first"),
        Routes.second: (_) => OnlyText(text: "second"),
        Routes.third: (_) => OnlyText(text: "third"),
      },
      title: "My app",
      home: Tree(),
      builder: EasyLoading.init(),
    ),
  );
}
