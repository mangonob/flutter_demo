import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo/only_text.dart';
import 'package:flutter_demo/routes/routes.dart';
import 'package:flutter_demo/tree_map/hnode.dart';
import 'package:flutter_demo/tree_map/leaf_node.dart';
import 'package:flutter_demo/tree_map/tree_map.dart';
import 'package:flutter_demo/tree_map/vnode.dart';
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
    _datas = List.generate(14, (index) => random.nextInt(40) + 5);
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
            height: 400,
            child: TreeMap(
              rootNode: VNode(
                children: [
                  HNode(
                    children: [
                      VNode(
                        forceValue: 0.5,
                        children: [
                          LeafNode(
                            value: nextValue(),
                            child: Container(
                              color: Colors.red,
                            ),
                          ),
                          HNode(children: [
                            VNode(
                              children: [
                                LeafNode(
                                  value: nextValue(),
                                  child: Container(
                                    color: Colors.blue,
                                  ),
                                ),
                                LeafNode(
                                  value: nextValue(),
                                  child: Container(
                                    color: Colors.purple,
                                  ),
                                ),
                              ],
                            ),
                            LeafNode(
                              value: nextValue(),
                              child: Container(
                                color: Colors.orange,
                              ),
                            ),
                          ]),
                        ],
                      ),
                      VNode(
                        forceValue: 0.5,
                        children: [
                          HNode(
                            children: [
                              VNode(
                                children: [
                                  LeafNode(
                                    value: nextValue(),
                                    child: Container(
                                      color: Colors.yellow,
                                    ),
                                  ),
                                  LeafNode(
                                    value: nextValue(),
                                    child: Container(
                                      color: Colors.green,
                                    ),
                                  ),
                                  LeafNode(
                                    value: nextValue(),
                                    child: Container(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                              LeafNode(
                                value: nextValue(),
                                child: Container(
                                  color: Colors.orange,
                                ),
                              ),
                              LeafNode(
                                value: nextValue(),
                                child: Container(
                                  color: Colors.pink,
                                ),
                              ),
                            ],
                          ),
                          LeafNode(
                            value: nextValue(),
                            child: Container(
                              color: Colors.green,
                            ),
                          ),
                          LeafNode(
                            value: nextValue(),
                            child: Container(
                              color: Colors.yellow,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
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
