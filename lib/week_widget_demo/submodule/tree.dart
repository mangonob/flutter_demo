import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/general_scaffold.dart';
import 'package:flutter_svg/svg.dart';

class Tree extends StatefulWidget {
  @override
  _TreeState createState() => _TreeState();
}

class _TreeState extends State<Tree> {
  bool _isFlutter = true;

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _isFlutter ? "Hello Flutter" : "Hello Dart",
                  style: TextStyle(fontSize: 30),
                ),
                _isFlutter
                    ? SizedBox(width: 10)
                    : Padding(padding: EdgeInsets.only(right: 10)),
                SvgPicture.asset(
                  _isFlutter
                      ? "assets/images/flutterio-icon.svg"
                      : "assets/images/dartlang-icon.svg",
                  height: 40,
                ),
              ],
            ),
            SizedBox(
              height: 30,
              key: UniqueKey(),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isFlutter = !_isFlutter;
                });
              },
              child: Text("Switch"),
            )
          ],
        ),
      ),
    );
  }
}
