import 'dart:async';

import 'package:flutter/material.dart';

/// Widget that builds it self base on current time.
/// ```dart
/// @override
/// Widget build(BuildContext context) {
///   return DateTimeBuilder(
///     builder: (ctx, time) {
///       return Text(
///         "Current Time: ${time.toIso8601String()}",
///         style: TextStyle(
///           fontSize: 16,
///           color: Color(0xFF181818),
///         ),
///       );
///     },
///   );
/// }
/// ```
class DateTimeBuilder extends StatefulWidget {
  /// The build strategy currently used by this builder
  ///
  /// The builder is provided with an [DateTime] object just `DateTime.now()`.
  final Widget Function(BuildContext context, DateTime time) builder;
  final Function(DateTime time, Timer timer)? onTick;

  /// [Duration] to update widget, default is `Duration(second: 1)`.
  final Duration? duration;

  DateTimeBuilder({
    Key? key,
    required this.builder,
    this.onTick,
    this.duration,
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
    _timer = Timer.periodic(widget.duration ?? Duration(seconds: 1), (timer) {
      final now = DateTime.now();

      if (widget.onTick != null) widget.onTick!(now, timer);
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
