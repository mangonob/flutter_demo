import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class WheelList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListWheelScrollView(
        itemExtent: 80,
        children: List.generate(
          100,
          (index) {
            return Container(
              decoration: BoxDecoration(
                color: RandomColor().randomColor(),
                borderRadius: BorderRadius.circular(5),
              ),
            );
          },
        ),
      ),
    );
  }
}
