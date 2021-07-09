import 'dart:async';

import 'package:flutter/material.dart';

class DateTimeBuilder extends StatefulWidget {
  final Function(BuildContext context, DateTime time) builder;
  final Function(DateTime time)? onTick;

  DateTimeBuilder({
    Key? key,
    required this.builder,
    this.onTick,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DateTimeBuilderState();
}

class _DateTimeBuilderState extends State<DateTimeBuilder> {
  late Timer _timer;
  late DateTime _time;

  @override
  void initState() {
    super.initState();

    _time = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now();

      if (widget.onTick != null) widget.onTick!(now);
      setState(() => _time = now);
    });
  }

  @override
  void dispose() {
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _time);
  }
}
