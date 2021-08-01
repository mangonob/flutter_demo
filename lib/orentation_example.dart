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
            child: OrientationWidget(
              orientation: DeviceOrientation.landscapeRight,
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

class OrentationExampleEnter extends StatefulWidget {
  @override
  _OrentationExampleEnterState createState() => _OrentationExampleEnterState();
}

class _OrentationExampleEnterState extends State<OrentationExampleEnter>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _linearAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 125),
    );

    _linearAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (ctx, child) {
            return Container(
              transformAlignment: Alignment.center,
              transform: Matrix4.rotationY(pi / 2 * _linearAnimation.value),
              child: Scaffold(
                body: Center(
                  child: GestureDetector(
                    onTap: () async {
                      await _animationController.forward();
                      await Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (ctx, a1, a2) => OrentationExample(),
                          transitionDuration: Duration.zero,
                        ),
                      );
                      await _animationController.reverse();
                    },
                    child: Container(
                      height: 300,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2, child: Container(color: Colors.red)),
                          Expanded(
                              flex: 1, child: Container(color: Colors.green)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
