import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AutoRotated extends StatefulWidget {
  final Widget child;

  AutoRotated({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _AutoRotatedState createState() => _AutoRotatedState();
}

class _AutoRotatedState extends State<AutoRotated> {
  DeviceOrientation _orientation = DeviceOrientation.portraitUp;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<AutoRotatedNotification>(
      child: RotatedBox(
        quarterTurns: _orientation.turns(),
        child: widget.child,
      ),
      onNotification: (noti) {
        setState(() => _orientation = noti.orientation);
        return true;
      },
    );
  }
}

class AutoRotatedNotification extends Notification {
  final DeviceOrientation orientation;

  AutoRotatedNotification(this.orientation) : super();
}

extension _OrientationTruns on DeviceOrientation {
  int turns() {
    switch (this) {
      case DeviceOrientation.portraitUp:
        return 0;
      case DeviceOrientation.landscapeRight:
        return 1;
      case DeviceOrientation.portraitDown:
        return 2;
      case DeviceOrientation.landscapeLeft:
        return 3;
    }
  }
}
