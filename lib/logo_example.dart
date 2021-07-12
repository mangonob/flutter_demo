import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo/routes/routes.dart';

class LogoExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LogoExampleState();
}

class LogoExampleState extends State<LogoExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Size> _sizeAnimation;
  late Animation<Matrix4> _transformAnimation;
  bool _isForward = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        duration: const Duration(milliseconds: 250), vsync: this);
    _animationController.addListener(() {
      setState(() => {});
    });
    _sizeAnimation = Tween(begin: Size(300, 300), end: Size(100, 100))
        .animate(_animationController);
    _transformAnimation =
        Matrix4Tween(begin: Matrix4.identity(), end: Matrix4.rotationZ(pi))
            .animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 44,
        title: Text(
          "Flutter Logo",
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF181818),
          ),
        ),
      ),
      body: Center(
        child: InkWell(
          onDoubleTap: () {
            Navigator.pushNamed(context, Routes.first);
          },
          onTap: () {
            setState(() {
              _isForward = !_isForward;
              _isForward
                  ? _animationController.forward()
                  : _animationController.reverse();
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 300,
                width: 300,
              ),
              Container(
                padding: EdgeInsets.all(16),
                transformAlignment: FractionalOffset.center,
                height: _sizeAnimation.value.height,
                width: _sizeAnimation.value.width,
                transform: _transformAnimation.value,
                child: FlutterLogo(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
