import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrientationWidget extends StatefulWidget {
  final Widget child;
  final DeviceOrientation orientation;

  OrientationWidget({
    Key? key,
    required this.child,
    this.orientation = DeviceOrientation.portraitUp,
  }) : super(key: key);

  @override
  _OrientationWidgetState createState() => _OrientationWidgetState();
}

class _OrientationWidgetState extends State<OrientationWidget> {
  initState() {
    super.initState();
    // SystemChrome.setPreferredOrientations([widget.orientation]);
  }

  dispose() {
    super.dispose();
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  Widget build(BuildContext context) {
    return RotatedBox(quarterTurns: 1, child: widget.child);
  }
}
