import 'package:flutter/material.dart';

class SliderScope extends StatefulWidget {
  final Widget child;

  SliderScope({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<SliderScope> createState() => SliderScopeState();
}

class SliderScopeState extends State<SliderScope> {
  final offset = ValueNotifier(0.0);

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
