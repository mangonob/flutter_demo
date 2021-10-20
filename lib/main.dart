import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo/only_text.dart';
import 'package:flutter_demo/routes/routes.dart';
import 'package:flutter_demo/tree_map/flat_node.dart';
import 'package:flutter_demo/tree_map/leaf_node.dart';
import 'package:flutter_demo/tree_map/tree_map.dart';
import 'package:flutter_demo/widgets/general_scaffold.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(
    MaterialApp(
      routes: {
        Routes.first: (_) => OnlyText(text: "first"),
        Routes.second: (_) => OnlyText(text: "second"),
        Routes.third: (_) => OnlyText(text: "third"),
      },
      title: "My app",
      home: TreeMapDemo(),
      builder: EasyLoading.init(),
    ),
  );
}

class TreeMapDemo extends StatefulWidget {
  @override
  State<TreeMapDemo> createState() => _TreeMapDemoState();
}

class _TreeMapDemoState extends State<TreeMapDemo> {
  late List<num> _datas;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generateNewData();
  }

  _generateNewData() {
    final random = Random();
    _datas = List.generate(14, (index) => random.nextInt(120) + 40);
  }

  @override
  Widget build(BuildContext context) {
    var index = 0;

    final nextValue = () {
      final result = _datas[index];
      index += 1;
      return result;
    };

    return GeneralScaffold(
      title: "TreeMap",
      body: ListView(
        children: [
          Container(
            height: 200,
            child: TreeMap(
              rootNode: FlatNode(
                children: List.generate(
                  5,
                  (index) => LeafNode(
                    value: nextValue(),
                    child: Container(
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          index.toString(),
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                setState(() => _generateNewData());
              },
              child: Text("Generate new data"))
        ],
      ),
    );
  }
}
