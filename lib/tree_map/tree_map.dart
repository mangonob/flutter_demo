import 'package:flutter/material.dart';

import 'node_frame.dart';
import 'tree_map_config.dart';
import 'tree_node.dart';

class TreeMap extends StatelessWidget {
  final TreeNode rootNode;
  final Duration duration;
  final double space;

  TreeMap({
    Key? key,
    required this.rootNode,
    this.duration = const Duration(milliseconds: 250),
    this.space = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      assert(constraints.hasBoundedWidth);
      assert(constraints.hasBoundedHeight);

      return NodeFrame(
        frame: Rect.fromLTWH(0, 0, constraints.maxWidth, constraints.maxHeight),
        child: TreeMapConfig(
          duration: duration,
          space: space,
          child: rootNode,
        ),
      );
    });
  }
}
