import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/general_scaffold.dart';

class FlutterAnimationDemo extends StatefulWidget {
  @override
  _FlutterAnimationDemoState createState() => _FlutterAnimationDemoState();
}

class _FlutterAnimationDemoState extends State<FlutterAnimationDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isForword = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      body: ListView(
        children: [
          Center(
            child: RotationTransition(
              turns: _controller,
              child: FlutterLogo(
                size: 200,
              ),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                _isForword ? _controller.reverse() : _controller.forward();
                setState(() {
                  _isForword = !_isForword;
                });
              },
              child: Text(
                _isForword ? "Reverse" : "Forward",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
