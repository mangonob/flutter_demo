import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/auto_rotated.dart';

class SomeStuff extends StatefulWidget {
  @override
  _SomeStuffState createState() => _SomeStuffState();
}

class _SomeStuffState extends State<SomeStuff> {
  double _opacity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 250),
        opacity: _opacity,
        child: Scaffold(
          body: GestureDetector(
            onDoubleTap: () => setState(() => _opacity = 0),
            child: ListView(
              padding: EdgeInsets.zero,
              children: List.generate(100, (index) {
                return Container(
                  color: [Colors.red, Colors.green, Colors.blue][index % 3],
                  child: ListTile(),
                );
              }),
            ),
          ),
        ),
        onEnd: () async {
          if (_opacity == 0) {
            AutoRotatedNotification(DeviceOrientation.landscapeRight)
                .dispatch(context);
            await Navigator.push(context,
                PageRouteBuilder(pageBuilder: (ctx, a1, a2) => Others()));
            AutoRotatedNotification(DeviceOrientation.portraitUp)
                .dispatch(context);
            setState(() => _opacity = 1);
          }
        },
      ),
    );
  }
}

class Others extends StatefulWidget {
  @override
  _OthersState createState() => _OthersState();
}

class _OthersState extends State<Others> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();

    setState(() => _opacity = 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 250),
        opacity: _opacity,
        child: Scaffold(
          body: GestureDetector(
            onDoubleTap: () => setState(() => _opacity = 0),
            child: ListView(
              padding: EdgeInsets.zero,
              children: List.generate(100, (index) {
                return Container(
                  color: [Colors.red, Colors.green, Colors.blue][index % 3],
                  child: ListTile(),
                );
              }),
            ),
          ),
        ),
        onEnd: () {
          if (_opacity == 0) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
