import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';

class ReorderDemo extends StatefulWidget {
  @override
  _ReorderDemoState createState() => _ReorderDemoState();
}

class _ReorderDemoState extends State<ReorderDemo> {
  late List<int> _datas;

  @override
  void initState() {
    super.initState();

    final sRandom = Random.secure();
    _datas = List.generate(42, (index) => sRandom.nextInt(100));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 44,
        backgroundColor: Colors.white,
        title: Text("ReorderableListView Demo",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            )),
      ),
      body: ReorderableListView(
        dragStartBehavior: DragStartBehavior.start,
        onReorder: (oldIndex, newIndex) {
          setState(
            () => _datas.insert(
              newIndex >= oldIndex ? newIndex - 1 : newIndex,
              _datas.removeAt(oldIndex),
            ),
          );
        },
        children: [
          for (final entry in enumerate(_datas))
            Container(
              color: Colors.white,
              key: ValueKey(entry.index),
              child: ListTile(
                title: Text(
                  "Item: ${entry.value}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                trailing: ReorderableDragStartListener(
                  index: entry.index,
                  child: Container(
                    width: 30,
                    height: 30,
                    child: Center(
                      child: Icon(Icons.menu),
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
