import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/general_scaffold.dart';

class BackdropFilterDemo extends StatefulWidget {
  @override
  _BackdropFilterDemoState createState() => _BackdropFilterDemoState();
}

class _BackdropFilterDemoState extends State<BackdropFilterDemo>
    with TickerProviderStateMixin {
  bool _isBlur = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Hello Filter",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (ctx, child) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: _animationController.value * 10,
                        sigmaY: _animationController.value * 10,
                      ),
                      child: child,
                    );
                  },
                  child: Container(
                    child: Center(
                      child: Text("NoFilter"),
                    ),
                  ),
                ),
              )
            ],
          ),
          CupertinoSwitch(
              value: _isBlur,
              onChanged: (v) {
                setState(() {
                  _isBlur = v;
                  _isBlur
                      ? _animationController.forward()
                      : _animationController.reverse();
                });
              }),
        ],
      ),
    );
  }
}
