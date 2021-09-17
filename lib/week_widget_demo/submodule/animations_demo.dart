import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/general_scaffold.dart';

class AnimationsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
        body: Center(
      child: OpenContainer(
        openBuilder: (ctx, action) {
          return GestureDetector(
            onTap: () => action(),
            child: Container(
              height: 200,
              width: 200,
              color: Colors.blue,
            ),
          );
        },
        useRootNavigator: true,
        tappable: true,
        closedBuilder: (ctx, action) {
          return Text(
            "Open",
            style: TextStyle(color: Colors.orange, fontSize: 32),
          );
        },
      ),
    ));
  }
}
