import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/general_scaffold.dart';
import 'package:random_color/random_color.dart';

class Drag extends StatefulWidget {
  @override
  _DragState createState() => _DragState();
}

class _DragState extends State<Drag> {
  late List<int> _datas;

  @override
  void initState() {
    super.initState();
    _datas = List.generate(10, (index) => index);
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      body: ListView(
        children: _datas.map((value) {
          final color = RandomColor().randomColor();
          final item = _Item(value: value, color: color);

          return Container(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Draggable(
                child: item,
                feedback: item,
                childWhenDragging: Opacity(
                  opacity: 0.5,
                  child: item,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final int value;
  final Color? color;

  _Item({
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: color ?? RandomColor().randomColor(),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        "$value",
        style: TextStyle(
          fontSize: 32,
          color: Colors.white,
        ),
      ),
    );
  }
}
