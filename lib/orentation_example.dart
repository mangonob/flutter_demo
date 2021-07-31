import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/orientation.dart';
import 'package:flutter_demo/widgets/popover.dart';

class OrentationExample extends StatefulWidget {
  @override
  _OrentationExampleState createState() => _OrentationExampleState();
}

class _OrentationExampleState extends State<OrentationExample> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlay>(
      value: SystemUiOverlay.bottom,
      child: Container(
        color: Colors.red,
        child: Scaffold(
          body: SafeArea(
            top: true,
            bottom: true,
            child: RotatedBox(
              quarterTurns: 1,
              child: Scrollbar(
                child: ListView(
                  children: List.generate(
                    1000,
                    (index) => ListTile(
                      onLongPress: () => Navigator.pop(context),
                      title: Row(
                        children: [
                          Popover(
                            child: Text("Item: $index"),
                            popoverBuilder: (_) => Container(
                              color: Colors.red,
                              width: 100,
                              height: 100,
                              child: Center(child: Text("Some")),
                            ),
                          ),
                          Popover(
                            child: Text("Item: $index"),
                            popoverBuilder: (_) => Container(
                              color: Colors.red,
                              width: 100,
                              height: 100,
                              child: Center(child: Text("Some")),
                            ),
                          ),
                          Popover(
                            child: Text("Item: $index"),
                            popoverBuilder: (_) => Container(
                              color: Colors.red,
                              width: 100,
                              height: 100,
                              child: Center(child: Text("Some")),
                            ),
                          ),
                          Popover(
                            child: Text("Item: $index"),
                            popoverBuilder: (_) => Container(
                              color: Colors.red,
                              width: 100,
                              height: 100,
                              child: Center(child: Text("Some")),
                            ),
                          ),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OrentationExampleEnter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (ctx, a1, a2) => OrentationExample(),
                transitionDuration: Duration(seconds: 0),
              ),
            );
          },
          child: Container(
            height: 300,
            child: Row(
              children: [
                Expanded(flex: 2, child: Container(color: Colors.red)),
                Expanded(flex: 1, child: Container(color: Colors.green)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
