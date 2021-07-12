import 'package:flutter/material.dart';
import 'package:flutter_demo/scaffold.dart';

class OnlyText extends StatelessWidget {
  final String? text;

  OnlyText({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleScaffold(
      body: Center(
        child: Text(
          text ?? "Only Text",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
