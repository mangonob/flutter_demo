import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/general_scaffold.dart';

class LimitedBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      body: ListView(children: [
        LimitedBox(
          maxHeight: 100,
          child: Container(
            color: Colors.red,
          ),
        ),
      ]),
    );
  }
}
